//
//  FSJImageScrollView.m
//  FSJPassword
//
//  Created by yto on 14-8-27.
//  Copyright (c) 2014年 yto_yewankun. All rights reserved.
//

#import "FSJImageScrollView.h"

@implementation FSJImageScrollView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.showsVerticalScrollIndicator = NO;
        self.showsHorizontalScrollIndicator = NO;
        self.bouncesZoom = YES;
        self.decelerationRate = UIScrollViewDecelerationRateFast;
        self.delegate = self;
        self.maximumZoomScale = 5.0;
        self.minimumZoomScale = 1.0;
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // center the zoom view as it becomes smaller than the size of the screen
    CGSize boundsSize = self.bounds.size;
    CGRect frameToCenter = self.zoomImageView.frame;
    // center horizontally
    if (frameToCenter.size.width < boundsSize.width)
        frameToCenter.origin.x = (boundsSize.width - frameToCenter.size.width) / 2;
    else
        frameToCenter.origin.x = 0;
    
    // center vertically
    if (frameToCenter.size.height < boundsSize.height)
        frameToCenter.origin.y = (boundsSize.height - frameToCenter.size.height) / 2;
    else
        frameToCenter.origin.y = 0;
    self.zoomImageView.frame = frameToCenter;
}

- (void)displayImage:(UIImage *)image
{
    if(self.zoomImageView == nil)
    {
        self.zoomScale = 1.0;
        
        // make a new UIImageView for the new image
        self.zoomImageView = [[UIImageView alloc] initWithImage:image];
        [self addSubview:self.zoomImageView];
    }
    else
    {
        self.zoomImageView.image = image;
    }
    
//    [self configureForImageSize:image.size];
}

//- (void)configureForImageSize:(CGSize)imageSize
//{
//    _imageSize = imageSize;
//    self.contentSize = imageSize;
//    [self setMaxMinZoomScalesForCurrentBounds];
//    self.zoomScale = self.minimumZoomScale;
//}
//
//- (void)setMaxMinZoomScalesForCurrentBounds
//{
//    CGSize boundsSize = self.bounds.size;
//    CGFloat maxScale = 1;
//    
//    // calculate min/max zoomscale
//    CGFloat xScale = boundsSize.width  / _imageSize.width;    // the scale needed to perfectly fit the image width-wise
//    CGFloat yScale = boundsSize.height / _imageSize.height;   // the scale needed to perfectly fit the image height-wise
//    CGFloat minScale = MIN(xScale, yScale);                   // use minimum of these to allow the image to become fully visible
//    
//    // Image must fit the screen, even if its size is smaller.
//    CGFloat xImageScale = maxScale*_imageSize.width / boundsSize.width;
//    CGFloat yImageScale = maxScale*_imageSize.height / boundsSize.width;
//    CGFloat maxImageScale = MAX(xImageScale, yImageScale);
//    
//    maxImageScale = MAX(minScale, maxImageScale);
//    maxScale = MIN(maxScale, maxImageScale);
//    
//    // don't let minScale exceed maxScale. (If the image is smaller than the screen, we don't want to force it to be zoomed.)
//    if (minScale > maxScale) {
//        minScale = maxScale;
//    }
//    
//    self.maximumZoomScale = maxScale;
//    self.minimumZoomScale = minScale;
//}

#pragma mark - UIScrollViewDelegate

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.zoomImageView;
}

- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(float)scale
{
    
}
@end
