//
//  FSJFocusManager.m
//  FSJPassword
//
//  Created by yto on 14-8-27.
//  Copyright (c) 2014年 yto_yewankun. All rights reserved.
//

#import "FSJFocusManager.h"


static CGFloat const kAnimationDuration = 0.5;
static CGFloat const kAnimateElasticDurationRatio = 0.6;

@implementation FSJFocusManager
@synthesize delegate;
@synthesize animationDuration;

- (id)init
{
    self = [super init];
    if(self)
    {
        self.animationDuration = kAnimationDuration;
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.8];
        self.zoomEnabled = YES;
    }
    
    return self;
}

- (void)installOnViews:(NSArray *)views
{
    for(UIView *view in views)
    {
        [self installOnView:view];
    }
}

- (void)installOnView:(UIView *)view
{
    UITapGestureRecognizer *tapGesture;
    
    tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleFocusGesture:)];
    [view addGestureRecognizer:tapGesture];
    view.userInteractionEnabled = YES;
}

- (CGRect)getLargeImageFrame:(UIImage *)aImage {
    if (aImage == nil) {
        return CGRectZero;
    }
    CGFloat screenH = self.focusViewController.view.bounds.size.height;
    CGFloat screenW = self.focusViewController.view.bounds.size.width;
    
    CGFloat imgH = aImage.size.height;
    CGFloat imgW = aImage.size.width;
    
    if (screenH/screenW > imgH/imgW) {
        // 按照宽来计算
        CGFloat width = screenW;
        CGFloat height = imgH/imgW*width;
        CGFloat x = 0;
        CGFloat y = (screenH-height)/2;
        return CGRectMake(x, y, width, height);
    }else if (screenH/screenW < imgH/imgW) {
        // 按照高来计算
        CGFloat height = screenH;
        CGFloat width = imgW/imgH*height;
        CGFloat y = 0;
        CGFloat x = (screenW-width)/2;
        return CGRectMake(x, y, width, height);
    }
    return CGRectZero;
}

- (FSJFocusController *)focusViewControllerForView:(UIView *)mediaView
{
    FSJFocusController *viewController;
    UITapGestureRecognizer *tapGesture;
    UIImage *image;
    
    image = [self.delegate focusManager:self imageForView:mediaView];
    if(image == nil)
        return nil;
    
    viewController = [[FSJFocusController alloc] initWithNibName:nil bundle:nil];
    tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleDefocusGesture:)];
    [viewController.view addGestureRecognizer:tapGesture];
    viewController.mainImageView.image = image;
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        UIImage *image = [self.delegate focusManager:self mediaPathForView:mediaView];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            viewController.mainImageView.image = image;
        });
    });
    
    return viewController;
}

- (void)installZoomView
{
    FSJImageScrollView *scrollView;
    
    if(!self.zoomEnabled)
        return;
    
    scrollView = [[FSJImageScrollView alloc] initWithFrame:self.focusViewController.contentView.bounds];
    scrollView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    self.focusViewController.scrollView = scrollView;
    [self.focusViewController.contentView addSubview:scrollView];
    [scrollView displayImage:self.focusViewController.mainImageView.image];
    
    scrollView.zoomImageView.frame = [self getLargeImageFrame:self.focusViewController.mainImageView.image];
    self.focusViewController.mainImageView.hidden = YES;
}

- (void)uninstallZoomView
{
    CGRect frame;
    
    if(!self.zoomEnabled)
        return;
    
    frame = [self.focusViewController.contentView convertRect:self.focusViewController.scrollView.zoomImageView.frame fromView:self.focusViewController.scrollView];
    self.focusViewController.scrollView.hidden = YES;
    self.focusViewController.mainImageView.hidden = NO;
    self.focusViewController.mainImageView.frame = frame;
}

#pragma mark -  手势
- (void)handleFocusGesture:(UIGestureRecognizer *)gesture
{
    UIViewController *parentViewController;
    FSJFocusController *focusViewController;
    CGPoint center;
    UIView *mediaView;
    UIView *imageView;
    
    mediaView = gesture.view;
    focusViewController = [self focusViewControllerForView:mediaView];
    if(focusViewController == nil)
        return;
    
    self.focusViewController = focusViewController;
    self.mediaView = mediaView;
    parentViewController = [self.delegate parentViewControllerForMediaFocusManager:self];
    [parentViewController addChildViewController:focusViewController];
    [parentViewController.view addSubview:focusViewController.view];
    focusViewController.view.frame = parentViewController.view.bounds;
    mediaView.hidden = YES;
    
    imageView = focusViewController.mainImageView;
    // 还原到原始坐标
    center = [imageView.superview convertPoint:mediaView.center fromView:mediaView.superview];
    imageView.center = center;
    imageView.transform = mediaView.transform;
    imageView.bounds = mediaView.bounds;
    
    [UIView animateWithDuration:0.1//self.animationDuration
                     animations:^{
                         
                     }
                     completion:^(BOOL finished) {
                         [UIView animateWithDuration:self.animationDuration*kAnimateElasticDurationRatio
                                          animations:^{
                                              
                                              // 计算imageview的坐标
                                              UIImage *image = focusViewController.mainImageView.image;
                                              imageView.frame = [self getLargeImageFrame:image];
                                              
                                              focusViewController.view.backgroundColor = self.backgroundColor;
                                          }
                                          completion:^(BOOL finished) {
                                              [self installZoomView];
                                          }];
                     }];
    
}

- (void)handleDefocusGesture:(UIGestureRecognizer *)gesture
{
    UIView *contentView;
    CGRect __block bounds;
    
    [self uninstallZoomView];
    contentView = self.focusViewController.mainImageView;
    [UIView animateWithDuration:self.animationDuration
                     animations:^{
                         self.focusViewController.contentView.transform = CGAffineTransformIdentity;
                         contentView.center = [contentView.superview convertPoint:self.mediaView.center fromView:self.mediaView.superview];
                         contentView.transform = self.mediaView.transform;
                         bounds = self.mediaView.bounds;
                         contentView.bounds = bounds;
                         gesture.view.backgroundColor = [UIColor clearColor];
                     }
                     completion:^(BOOL finished) {
                         [UIView animateWithDuration:self.animationDuration*kAnimateElasticDurationRatio
                                          animations:^{
                                              contentView.bounds = bounds;
                                          }
                                          completion:^(BOOL finished) {
                                              self.mediaView.hidden = NO;
                                              [self.focusViewController.view removeFromSuperview];
                                              [self.focusViewController removeFromParentViewController];
                                              self.focusViewController = nil;
                                          }];
                     }];
}

@end
