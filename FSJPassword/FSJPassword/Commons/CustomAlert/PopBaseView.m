//
//  PopBaseView.m
//  YTongExpress
//
//  Created by yto on 14-9-1.
//  Copyright (c) 2014年 wuxiaozhen. All rights reserved.
//

#import "PopBaseView.h"

@interface PopBaseView ()
- (void)clickCancel:(id)sender;
- (void)clickConfirm:(id)sender;
@end

@implementation PopBaseView

static PopBaseView *popView = nil;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

// 类方法
+ (id)sharePopView {
    if (popView == nil) {
        popView = [[PopBaseView alloc] init];
        [popView initView];
    }
    return popView;
}

// 初始化界面
- (void)initView {
    
    bgW = App_Frame_Width-POP_Margin_Left-POP_Margin_Right;
    CGFloat bgH = POP_Title_Default_H+POP_Content_Default_H+POP_Button_View_H;
    backView = [[UIView alloc] initWithFrame:CGRectMake(POP_Margin_Left, 0, bgW, bgH)];
    [backView setBackgroundColor:COLOR(240.0, 239.0, 245.0, 1.0)];
    [ContainerUtil changeRoundViewWithBorderView:backView withRadius:6.0 withBorderColor:[UIColor clearColor]];
    [self addSubview:backView];
    
    titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, bgW, POP_Title_Default_H)];
    [titleLabel setTextColor:COLOR(136.0, 134.0, 140.0, 1.0)];
    [titleLabel setBackgroundColor:[UIColor clearColor]];
    [titleLabel setFont:[UIFont boldSystemFontOfSize:17]];
    [titleLabel setText:@"标题"];
    [titleLabel setTextAlignment:NSTextAlignmentCenter];
    [backView addSubview:titleLabel];
    
    CGFloat contentY = POP_Title_Default_H;
    contentView = [[UIView alloc] initWithFrame:CGRectMake(0, contentY, bgW, POP_Content_Default_H)];
    [contentView setBackgroundColor:[UIColor clearColor]];
    [backView addSubview:contentView];
    
    CGFloat buttonVY = POP_Title_Default_H+POP_Content_Default_H;
    buttonView = [[UIView alloc] initWithFrame:CGRectMake(0, buttonVY, bgW, POP_Button_View_H)];
    [buttonView setBackgroundColor:[UIColor clearColor]];
    [backView addSubview:buttonView];
    
    CGFloat buttonY = (POP_Button_View_H-POP_Button_Default_H)/2;
    CGFloat buttonW = (bgW-POP_Padding_Left-POP_Padding_Right-POP_Padding_Space)/2;
    cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancelButton setFrame:CGRectMake(POP_Padding_Left, buttonY, buttonW, POP_Button_Default_H)];
    [cancelButton setBackgroundColor:[UIColor whiteColor]];
    [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    [cancelButton.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [cancelButton setTitleColor:COLOR(136.0, 134.0, 140.0, 1.0) forState:UIControlStateNormal];
    [ContainerUtil changeRoundViewWithBorderView:cancelButton withRadius:6.0 withBorderColor:COLOR(153.0, 153.0, 153.0, 1.0)];
    [cancelButton addTarget:self action:@selector(clickCancel:) forControlEvents:UIControlEventTouchUpInside];
    [buttonView addSubview:cancelButton];
    
    confirmButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [confirmButton setFrame:CGRectMake(POP_Padding_Left+buttonW+POP_Padding_Space, buttonY, buttonW, POP_Button_Default_H)];
    [confirmButton setBackgroundColor:COLOR(150.0, 222.0, 243.0, 1.0)];
    [confirmButton setTitle:@"确定" forState:UIControlStateNormal];
    [confirmButton.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [confirmButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [ContainerUtil changeRoundViewWithBorderView:confirmButton withRadius:6.0 withBorderColor:COLOR(153.0, 153.0, 153.0, 1.0)];
    [confirmButton addTarget:self action:@selector(clickConfirm:) forControlEvents:UIControlEventTouchUpInside];
    [buttonView addSubview:confirmButton];
    
    lineUp = [[UILabel alloc] initWithFrame:CGRectMake(0, POP_Title_Default_H-1, bgW, 1)];
    [lineUp setBackgroundColor:COLOR(200.0, 199.0, 205.0, 1.0)];
    [backView addSubview:lineUp];
    
    lineDown = [[UILabel alloc] initWithFrame:CGRectMake(0, (POP_Title_Default_H+POP_Content_Default_H)-1, bgW, 1)];
    [lineDown setBackgroundColor:COLOR(200.0, 199.0, 205.0, 1.0)];
    [backView addSubview:lineDown];
}

// 设置中心位置
- (void)setBackCenter {
    [backView setCenter:self.center];
}

// 显示
- (void)show {
    UIView *aView = [[[UIApplication sharedApplication] delegate] window];
    if (IOS_7) {
        [popView setFrame:CGRectMake(0, 0, App_Frame_Width, App_Frame_Height+20)];
    }else {
        [popView setFrame:CGRectMake(0, 0, App_Frame_Width, App_Frame_Height)];
    }
    
    if (panelView == nil) {
        panelView = (UAPopTitledPanel *)[[JTYRenewalPopoView alloc] initWithFrame:aView.frame withView:popView];
        panelView.delegate = self;
    }
    [aView addSubview:panelView];
    
    [self setBackCenter];
    
    [panelView showFromPoint:[aView center]];
}

#pragma mark - public method
// 设置标题
- (void)setTitle:(NSString *)aString {
    [titleLabel setText:aString];
}

// 设置取消按钮标题
- (void)setCancelTitle:(NSString *)aString {
    [cancelButton setTitle:aString forState:UIControlStateNormal];
}

// 设置确认按钮标题
- (void)setConfirmTitle:(NSString *)aString {
    [confirmButton setTitle:aString forState:UIControlStateNormal];
}

/**
 * 设置content、button的坐标
 **/
- (void)setContentPosition:(CGFloat)contentH {
    [contentView setFrame:CGRectMake(contentView.frame.origin.x, contentView.frame.origin.y, contentView.frame.size.width, contentH)];
    [buttonView setFrame:CGRectMake(buttonView.frame.origin.x, contentView.frame.origin.y+contentH, buttonView.frame.size.width, buttonView.frame.size.height)];
    [lineDown setFrame:CGRectMake(lineDown.frame.origin.x, contentView.frame.origin.y+contentH-1, lineDown.frame.size.width, lineDown.frame.size.height)];
    CGFloat backH = POP_Title_Default_H+contentH+POP_Button_View_H;
    [backView setFrame:CGRectMake(backView.frame.origin.x, backView.frame.origin.y, backView.frame.size.width, backH)];
}

- (void)hidden {
//    [self removeFromSuperview];
    [[NSNotificationCenter defaultCenter] postNotificationName:kGFColseButtonDonePressed object:nil];
}

#pragma mark - btn action
- (void)clickCancel:(id)sender {
    [self hidden];
}

- (void)clickConfirm:(id)sender {
    [self hidden];
}

#pragma mark - UAModalPanelDelegate
- (BOOL)shouldCloseModalPanel:(UAModalPanel *)modalPanel {
	UADebugLog(@"shouldCloseModalPanel called with modalPanel: %@", modalPanel);
	return YES;
}

@end
