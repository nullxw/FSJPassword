//
//  ContainerUtil.m
//  YTongExpress
//
//  Created by yto on 14-6-18.
//  Copyright (c) 2014年 wuxiaozhen. All rights reserved.
//

#import "ContainerUtil.h"

@implementation ContainerUtil

// 不固定设置圆角  加边框
+ (void)changeRoundViewWithBorderView:(UIView *)aView withRadius:(float)radius withBorderColor:(UIColor *)bColor {
    aView.layer.masksToBounds = YES;
    aView.layer.cornerRadius = radius;
    aView.layer.borderWidth = 1.0;
    aView.layer.borderColor = [bColor CGColor];
}

// 设置textField边框
+ (void)changeRoundTextFieldWithBorderView:(UIView *)aView withRadius:(float)radius {
    [aView setBackgroundColor:[UIColor whiteColor]];
    aView.layer.masksToBounds = YES;
    aView.layer.cornerRadius = radius;
    aView.layer.borderWidth = 1.0;
    aView.layer.borderColor = [COLOR(216.0, 217.0, 219.0, 1.0) CGColor];
}

// 设置头像边框
+ (void)changeRoundPhotoWithBorderView:(UIView *)aView withRadius:(float)radius {
    aView.layer.masksToBounds = YES;
    aView.layer.cornerRadius = radius;
    aView.layer.borderWidth = 3.0;
    aView.layer.borderColor = [[UIColor whiteColor] CGColor];
}
@end
