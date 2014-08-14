//
//  MJPasswordPopView.m
//  PasswordApp
//
//  Created by yto on 14-7-14.
//  Copyright (c) 2014年 yto_yewankun. All rights reserved.
//

#import "MJPasswordPopView.h"

NSString *const MJ_PASSWORD_TRUE = @"truePassword";

static MJPasswordPopView *popView = nil;

@implementation MJPasswordPopView
@synthesize delegate;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

+ (id)sharePopView {
    if (popView == nil) {
        popView = [[MJPasswordPopView alloc] init];
        [popView initFrame];
    }
    return popView;
}

- (void)initFrame {
    // 设置本身view的坐标
    [self setFrame:CGRectMake(0, App_Frame_Height+20, App_Frame_Width, App_Frame_Height)];
    
    //    [popView setBackgroundColor:COLOR(9.0, 36.0, 73.0, 1.0)];
    // 设置背景
    UIImageView *backImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    [backImgView setImage:[self getBackImg]];
    [self addSubview:backImgView];
    
    CGFloat messageY = 0;
    if (App_Frame_Height > 500) {
        if (IOS_7) {
            messageY = 40;
        }else {
            messageY = 60;
        }
    }else {
        if (IOS_7) {
            messageY = 40;
        }else {
            messageY = 60;
        }
    }
    messageLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, messageY, App_Frame_Width, 20)];
    [messageLabel setBackgroundColor:[UIColor clearColor]];
    [messageLabel setTextColor:[UIColor redColor]];
    [messageLabel setTextAlignment:NSTextAlignmentCenter];
    
    CGFloat passwordY = 0;
    if (App_Frame_Height > 500) {
        if (IOS_7) {
            passwordY = 110;
        }else {
          passwordY = 130;
        }
    }else {
        if (IOS_7) {
            passwordY = 80;
        }else {
            passwordY = 100;
        }
    }
    passwordView = [[MJPasswordView alloc] initWithFrame:CGRectMake(PPV_Margin_Left, passwordY, kPasswordViewSideLength, kPasswordViewSideLength)];
    passwordView.delegate = self;
    
    CGFloat forgotY = 0;
    if (App_Frame_Height > 500) {
        forgotY = passwordY+kPasswordViewSideLength+40;
    }else {
        forgotY = passwordY+kPasswordViewSideLength+20;
    }
    forgotPwdBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [forgotPwdBtn setTitle:@"忘记密码" forState:UIControlStateNormal];
    [forgotPwdBtn setTitleColor:COLOR(63.0, 73.0, 89.0, 1.0) forState:UIControlStateNormal];
    [forgotPwdBtn setFrame:CGRectMake(PPV_Margin_Left, forgotY, 130, 40)];
    [forgotPwdBtn addTarget:self action:@selector(clickForgot:) forControlEvents:UIControlEventTouchUpInside];
    
    otherBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [otherBtn setTitle:@"用其他帐号登录" forState:UIControlStateNormal];
    [otherBtn setTitleColor:COLOR(63.0, 73.0, 89.0, 1.0) forState:UIControlStateNormal];
    [otherBtn setFrame:CGRectMake(170, forgotY, 130, 40)];
    [otherBtn addTarget:self action:@selector(clickOtherAccount:) forControlEvents:UIControlEventTouchUpInside];
    
    resetBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [resetBtn setTitle:@"重新设置手势" forState:UIControlStateNormal];
    [resetBtn setTitleColor:COLOR(63.0, 73.0, 89.0, 1.0) forState:UIControlStateNormal];
    [resetBtn setFrame:CGRectMake(95, forgotY, 130, 40)];
    [resetBtn addTarget:self action:@selector(clickResetPassword:) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:messageLabel];
    [self addSubview:passwordView];
    [self addSubview:forgotPwdBtn];
    [self addSubview:otherBtn];
    [self addSubview:resetBtn];
}

- (UIImage *)getBackImg {
    NSArray *colors = [NSArray arrayWithObjects:[UIColor colorWithRed:8.0 / 255.0 green:32.0 / 255.0 blue:65.0 / 255.0 alpha:1.0],
                       [UIColor colorWithRed:10.0 / 255.0 green:15.0 / 255.0 blue:34.0 / 255.0 alpha:1.0],
                       nil];
    NSMutableArray *ar = [NSMutableArray array];
    for(UIColor *c in colors) {
        [ar addObject:(id)c.CGColor];
    }
    UIGraphicsBeginImageContextWithOptions(self.frame.size, YES, 1);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    CGColorSpaceRef colorSpace = CGColorGetColorSpace([[colors lastObject] CGColor]);
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (CFArrayRef)ar, NULL);
    CGPoint center = CGPointMake(self.frame.size.width/2.0, self.frame.size.height/2.0);
    float myRadius = MIN(self.frame.size.width, self.frame.size.height) * 1.0;
    CGContextDrawRadialGradient(context, gradient, center, 0, center, myRadius,  kCGGradientDrawsBeforeStartLocation | kCGGradientDrawsAfterEndLocation);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    CGGradientRelease(gradient);
    CGContextRestoreGState(context);
    CGColorSpaceRelease(colorSpace);
    UIGraphicsEndImageContext();
    return image;
}

- (void)setPasswordType:(PasswordType)_type {
    switch (_type) {
        case PasswordTypeSet:
        {
            isCanEnter = YES;
            [messageLabel setTextColor:[UIColor whiteColor]];
            [messageLabel setText:@"绘制解锁图案"];
            
            [forgotPwdBtn setHidden:YES];
            [otherBtn setHidden:YES];
            [resetBtn setHidden:NO];
        }
            break;
        
        case PasswordTypeRepeat:
        {
            [messageLabel setTextColor:[UIColor whiteColor]];
            [messageLabel setText:@"再次绘制解锁图案"];
            
            [forgotPwdBtn setHidden:YES];
            [otherBtn setHidden:YES];
            [resetBtn setHidden:NO];
        }
            break;
            
        case PasswordTypeEnter:
        {
            NSString *savePassword = [[NSUserDefaults standardUserDefaults] objectForKey:MJ_PASSWORD_TRUE];
            
            if (savePassword != nil || [savePassword isEqualToString:@""]) {
                passwordView.truePassword = savePassword;
                isCanEnter = YES;
            }else {
                isCanEnter = NO;
            }
            [messageLabel setTextColor:[UIColor whiteColor]];
            [messageLabel setText:@"请输入密码"];
            
            [forgotPwdBtn setHidden:NO];
            [otherBtn setHidden:NO];
            [resetBtn setHidden:YES];
        }
            break;
        default:
            break;
    }
    currentType = _type;
}

// 显示错误信息
- (void)showErrorMessge:(PasswordType)_type {
    switch (_type) {
        case PasswordTypeSet:
        {
            [messageLabel setTextColor:[UIColor redColor]];
            [messageLabel setText:@"与上一次绘制不一致，请重新绘制"];
        }
            
            break;
        case PasswordTypeRepeat:
        {
            [messageLabel setTextColor:[UIColor redColor]];
            [messageLabel setText:@"与上一次绘制不一致，请重新绘制"];
        }
            break;
        case PasswordTypeEnter:
        {
            pswCount--;
            if (pswCount <= 0) {
                [self hidden];
                if (self.delegate && [self.delegate respondsToSelector:@selector(enterPasswordErrorLimit:)]) {
                    [self.delegate enterPasswordErrorLimit:self];
                }
                return;
            }
            [messageLabel setTextColor:[UIColor redColor]];
            [messageLabel setText:[NSString stringWithFormat:@"密码错误，还可以再输入%d次",pswCount]];
        }
            break;
        default:
            break;
    }
    currentType = _type;
}

- (void)show:(UIView *)aView {
    if (isCanEnter) {
        // 已设置密码
        [aView addSubview:self];
        pswCount = PPV_Count;
        [UIView animateWithDuration:0.5 animations:^{
            if (IOS_7) {
                [popView setFrame:CGRectMake(0, 20, App_Frame_Width, App_Frame_Height)];
            }else {
                [popView setFrame:CGRectMake(0, 0, App_Frame_Width, App_Frame_Height)];
            }
        } completion:^(BOOL finished) {
            
        }];
    }else {
        // 未设置密码
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示"
                                                            message:@"你还没有设置密码呢" delegate:nil
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil, nil];
        [alertView show];
    }
}

- (void)hidden {
    [UIView animateWithDuration:0.5 animations:^{
        [self setFrame:CGRectMake(0, App_Frame_Height+20, App_Frame_Width, App_Frame_Height)];
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

#pragma mark - btn action
- (void)clickForgot:(id)sender {
    [self hidden];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(didForgotPassword:)]) {
        [self.delegate didForgotPassword:self];
    }
}

- (void)clickOtherAccount:(id)sender {
    [self hidden];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(switchOtherAccount:)]) {
        [self.delegate switchOtherAccount:self];
    }
}

- (void)clickResetPassword:(id)sender {
    [self setPasswordType:PasswordTypeSet];
}

#pragma mark - MJPasswordDelegate
/** 密码输入完毕回调 */
- (void)passwordView:(MJPasswordView*)passwordView_ withPassword:(NSString*)password {
    NSLog(@"%s",__FUNCTION__);
    switch (currentType) {
        case PasswordTypeSet:
        {
            passwordView.firstPassword = password;
            [self setPasswordType:PasswordTypeRepeat];
        }
            break;
            
        case PasswordTypeRepeat:
            if ([passwordView.firstPassword isEqualToString:password]) {
                passwordView.truePassword = password;
                
                [self hidden];
                
                // 保存到userdefault中
                [[NSUserDefaults standardUserDefaults] setObject:password forKey:MJ_PASSWORD_TRUE];
                [[NSUserDefaults standardUserDefaults] synchronize];
                
                // 设置密码成功回调
                if (self.delegate && [self.delegate respondsToSelector:@selector(didPasswordSuccess:withSuccessType:)]) {
                    [self.delegate didPasswordSuccess:self withSuccessType:PasswordSuccessTypeSet];
                }
            }else {
                [self showErrorMessge:PasswordTypeSet];
            }
            
            break;
            
        case PasswordTypeEnter:
            if ([passwordView.truePassword isEqualToString:password]) {
                [self hidden];
                if (self.delegate && [self.delegate respondsToSelector:@selector(didPasswordSuccess:withSuccessType:)]) {
                    [self.delegate didPasswordSuccess:self withSuccessType:PasswordSuccessTypeEnter];
                }
            }else {
                [self showErrorMessge:PasswordTypeEnter];
            }
            
            break;
            
        default:
            break;
    }
}

@end
