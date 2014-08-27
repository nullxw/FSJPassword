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
#import "ImageEnlargeController.h"

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
    
    [self setExtraCellLineHidden:v_tableView];
    
    menuList = [NSArray arrayWithObjects:@"设置密码",@"输入密码",@"xml解析",@"json解析成对象",@"图片放大", nil];
    
    [v_tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [menuList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifierCell = @"identifierCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifierCell];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifierCell];
    }
    int row = [indexPath row];
    cell.textLabel.text = [menuList objectAtIndex:row];
    [cell.textLabel setTextColor:COLOR(104.0, 243.0, 44.0, 1.0)];
    [cell.textLabel setTextAlignment:NSTextAlignmentCenter];
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    int row = [indexPath row];
    switch (row) {
        case 0:
        {
            MJPasswordPopView *popView = [MJPasswordPopView sharePopView];
            [popView setPasswordType:PasswordTypeSet];
            popView.delegate = self;
            [popView show:[[[UIApplication sharedApplication] delegate] window]];
        }
            break;
        case 1:
        {
            MJPasswordPopView *popView = [MJPasswordPopView sharePopView];
            [popView setPasswordType:PasswordTypeEnter];
            popView.delegate = self;
            [popView show:[[[UIApplication sharedApplication] delegate] window]];
        }
            break;
        case 2:
        {
            XmlParseController *parseController = [[XmlParseController alloc] initWithNibName:@"XmlParseController" bundle:nil];
            [self.navigationController pushViewController:parseController animated:YES];
        }
            break;
        case 3:
        {
            JsonObjectParseController *parseController = [[JsonObjectParseController alloc] initWithNibName:@"JsonObjectParseController" bundle:nil];
            [self.navigationController pushViewController:parseController animated:YES];
        }
            break;
        case 4:
        {
            ImageEnlargeController *imageController = [[ImageEnlargeController alloc] initWithNibName:@"ImageEnlargeController" bundle:nil];
            [self.navigationController pushViewController:imageController animated:YES];
        }
            break;
        default:
            break;
    }
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
