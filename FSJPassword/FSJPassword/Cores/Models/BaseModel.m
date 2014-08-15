//
//  BaseModel.m
//  FSJPassword
//
//  Created by yto on 14-8-14.
//  Copyright (c) 2014年 yto_yewankun. All rights reserved.
//

#import "BaseModel.h"
#import "LQDescriptionBuilder.h"

@implementation BaseModel

// bean输出
- (NSString *)description {
    return [LQDescriptionBuilder reflectionToString:self];
}

@end
