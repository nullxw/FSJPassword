//
//  ImageEnlargeController.h
//  FSJPassword
//
//  Created by yto on 14-8-27.
//  Copyright (c) 2014年 yto_yewankun. All rights reserved.
//

#import "BaseViewController.h"
#import "FSJFocusManager.h"

@interface ImageEnlargeController : BaseViewController <FSJFocusManagerDelegate> {
    IBOutlet UIImageView *imgView;
    FSJFocusManager *mediaFocusManager;
}

//@property (strong, nonatomic) FSJFocusManager *mediaFocusManager;

@end
