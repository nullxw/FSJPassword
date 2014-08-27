//
//  FSJFocusController.h
//  FSJPassword
//
//  Created by yto on 14-8-27.
//  Copyright (c) 2014年 yto_yewankun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FSJImageScrollView.h"

@interface FSJFocusController : UIViewController

@property (nonatomic,strong) FSJImageScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UIImageView *mainImageView;
@property (strong, nonatomic) IBOutlet UIView *contentView;

@end
