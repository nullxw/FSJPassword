//
//  ImageEnlargeController.m
//  FSJPassword
//
//  Created by yto on 14-8-27.
//  Copyright (c) 2014年 yto_yewankun. All rights reserved.
//

#import "ImageEnlargeController.h"
#import "PopBaseView.h"

@interface ImageEnlargeController ()

@end

@implementation ImageEnlargeController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self initNavbar];
    
    [self initView];
}

- (void)initNavbar {
    self.navigationItem.title = @"显示大图";
}

- (void)initView {
    mediaFocusManager = [[FSJFocusManager alloc] init];
    mediaFocusManager.delegate = self;
    
    [mediaFocusManager installOnView:imgView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - btn action
- (IBAction)clickAlert:(id)sender {
    PopBaseView *popView = [PopBaseView sharePopView];
    [popView show];
}

#pragma mark - FSJFocusManagerDelegate
- (UIImage *)focusManager:(FSJFocusManager *)mediaFocusManager imageForView:(UIView *)view {
    return ((UIImageView *)view).image;
}

// 返回大图
- (UIImage *)focusManager:(FSJFocusManager *)mediaFocusManager mediaPathForView:(UIView *)view {
    UIImage *aImg = [UIImage imageNamed:@"1.jpg"];
    return aImg;
}

- (UIViewController *)parentViewControllerForMediaFocusManager:(FSJFocusManager *)mediaFocusManager {
    return self.parentViewController;
}

@end
