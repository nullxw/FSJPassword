//
//  BaseViewController.h
//  FSJPassword
//
//  Created by yto on 14-8-14.
//  Copyright (c) 2014年 yto_yewankun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController

/**
 * 数据少的时候，去掉多余的分割线
 */
- (void)setExtraCellLineHidden: (UITableView *)tableView;

@end
