//
//  SettingUtil.h
//  PasswordApp
//
//  Created by yto on 14-7-15.
//  Copyright (c) 2014年 yto_yewankun. All rights reserved.
//  自己写的json转换对象库

#import <Foundation/Foundation.h>

@interface SettingUtil : NSObject

// 将对象属性key、value 转化成字典类型
+ (id)getPropertyList:(id)obj;

// 将对象转化成json
+ (NSString *)getJsonString:(id)obj;

// 将json转化成对象，以对象或数组的形式返回
+ (id)getModel:(Class)aModel withJson:(NSString *)jsonStr;

// 根据字典转化成对象
+ (id)getModel:(Class)aModel withDict:(NSDictionary *)aDict;
@end
