//
//  XmlParseController.h
//  FSJPassword
//
//  Created by yto on 14-8-14.
//  Copyright (c) 2014年 yto_yewankun. All rights reserved.
//

#import "BaseViewController.h"

@interface XmlParseController : BaseViewController <UITableViewDataSource,UITableViewDelegate> {
    IBOutlet UITableView *v_table;
    
@private
    NSArray *t_array;
}

@end
