//
//  ProfessorModel.h
//  FSJPassword
//
//  Created by yto on 14-8-14.
//  Copyright (c) 2014年 yto_yewankun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProfessorModel : NSObject

@property (nonatomic,strong)NSString *head;         // 头像地址
@property (nonatomic,strong)NSString *id;
@property (nonatomic,strong)NSString *job;          // 职位
@property (nonatomic,strong)NSString *name;         // 名称
@property (nonatomic,strong)NSString *summary;      // 专家介绍

@end
