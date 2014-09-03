//
//  ContainerUtil.h
//  YTongExpress
//
//  Created by yto on 14-6-18.
//  Copyright (c) 2014年 wuxiaozhen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ContainerUtil : NSObject

// 不固定设置圆角 加边框
+ (void)changeRoundViewWithBorderView:(UIView *)aView withRadius:(float)radius withBorderColor:(UIColor *)bColor;

// 设置textField边框
+ (void)changeRoundTextFieldWithBorderView:(UIView *)aView withRadius:(float)radius;

// 设置头像边框
+ (void)changeRoundPhotoWithBorderView:(UIView *)aView withRadius:(float)radius;
@end
