//
//  PopBaseView.h
//  YTongExpress
//
//  Created by yto on 14-9-1.
//  Copyright (c) 2014年 wuxiaozhen. All rights reserved.
//  弹出框 － 用于弹出一些特殊的alert 

#import <UIKit/UIKit.h>
#import "JTYRenewalPopoView.h"

@class PopBaseView;
#define POP_Margin_Left 10
#define POP_Margin_Right 10

#define POP_Padding_Left 10
#define POP_Padding_Right 10
#define POP_Padding_Space 10
#define POP_Content_Padding_Top 10
#define POP_Content_Padding_Bottom 10

#define POP_Title_Default_H 40
#define POP_Content_Default_H 80
#define POP_Button_Default_H 40
#define POP_Button_View_H 60

@interface PopBaseView : UIView <UAModalPanelDelegate> {
    UIView *shadowView;         // 阴影view
    UIView *backView;           // 背景view
    UILabel *titleLabel;        // 标题
    UIView *contentView;        // 内容view
    UIView *buttonView;         // 按钮view
    UIButton *cancelButton;     // 取消按钮
    UIButton *confirmButton;    // 确认按钮
    UILabel *lineUp;            // 上线
    UILabel *lineDown;          // 下线
    
    UAPopTitledPanel *panelView; // 用于测试popview弹出效果
    
    CGFloat bgW;                // content view的宽度
}

/**
 * 类方法
 **/
+ (id)sharePopView;

/**
 * 显示
 **/
- (void)show;

/**
 * 初始化界面
 **/
- (void)initView;

/**
 * 设置中心位置
 **/
- (void)setBackCenter;

/** 
 * 设置标题
 **/
- (void)setTitle:(NSString *)aString;

/**
 * 设置取消按钮标题
 **/
- (void)setCancelTitle:(NSString *)aString;

/**
 * 设置确认按钮标题
 **/
- (void)setConfirmTitle:(NSString *)aString;

/**
 * 设置content、button的坐标
 **/
- (void)setContentPosition:(CGFloat)contentH;
@end
