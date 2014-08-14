//
//  MainViewController.m
//  FSJPassword
//
//  Created by yto on 14-8-14.
//  Copyright (c) 2014年 yto_yewankun. All rights reserved.
//

#import "MainViewController.h"
#import "XmlParseController.h"
#import "JsonObjectParseController.h"

@interface MainViewController ()

@end

@implementation MainViewController

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - btn action
- (IBAction)clickSetPassword:(id)sender {
    MJPasswordPopView *popView = [MJPasswordPopView sharePopView];
    [popView setPasswordType:PasswordTypeSet];
    popView.delegate = self;
    [popView show:[[[UIApplication sharedApplication] delegate] window]];
}

- (IBAction)clickEnterPassword:(id)sender {
    MJPasswordPopView *popView = [MJPasswordPopView sharePopView];
    [popView setPasswordType:PasswordTypeEnter];
    popView.delegate = self;
    [popView show:[[[UIApplication sharedApplication] delegate] window]];
}

- (IBAction)clickXmlParse:(id)sender {
    XmlParseController *parseController = [[XmlParseController alloc] initWithNibName:@"XmlParseController" bundle:nil];
    [self.navigationController pushViewController:parseController animated:YES];
}

- (IBAction)clickJsonParseToObject:(id)sender {
    JsonObjectParseController *parseController = [[JsonObjectParseController alloc] initWithNibName:@"JsonObjectParseController" bundle:nil];
    [self.navigationController pushViewController:parseController animated:YES];
}

#pragma mark - MJPasswordPopViewDelegate
// 忘记密码
- (void)didForgotPassword:(MJPasswordPopView *)pwdPopView {
    NSLog(@"%s",__FUNCTION__);
}

// 设置密码成功、输入密码成功
- (void)didPasswordSuccess:(MJPasswordPopView *)pwdPopView withSuccessType:(PasswordSuccessType)successType {
    NSLog(@"%s",__FUNCTION__);
}

// 切换其他帐号登陆
- (void)switchOtherAccount:(MJPasswordPopView *)pwdPopview {
    NSLog(@"%s",__FUNCTION__);
}

// 输入5次密码都错误
- (void)enterPasswordErrorLimit:(MJPasswordPopView *)pwdPopview {
    NSLog(@"%s",__FUNCTION__);
}

@end
