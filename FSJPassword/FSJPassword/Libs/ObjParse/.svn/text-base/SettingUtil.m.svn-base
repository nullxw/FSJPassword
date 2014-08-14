//
//  SettingUtil.m
//  PasswordApp
//
//  Created by yto on 14-7-15.
//  Copyright (c) 2014年 yto_yewankun. All rights reserved.
//  json转化model

#import "SettingUtil.h"
#import <objc/runtime.h>
#import "SBJson.h"

@implementation SettingUtil

// 将对象属性key、value 转化成字典类型
+ (id)getPropertyList:(id)obj {
    id clazzOfObj = objc_getClass(class_getName([obj class]));
    unsigned int numberOfProperties;
    objc_property_t *properties = class_copyPropertyList(clazzOfObj, &numberOfProperties);
    id valueRef;
    //    long long v;
    NSInteger v;
    NSMutableDictionary *pairDict = [[[NSMutableDictionary alloc] init] autorelease];
    for (int i = 0; i < numberOfProperties; i++) {
        objc_property_t property = properties[i];
        const char * name = property_getName(property);
        const char * atti = property_getAttributes(property);
        // 判断是否是简单数据类型
        if (! [[self class] isClassType:[NSString stringWithCString:atti encoding:NSUTF8StringEncoding]]) {
            // 简单数据类型
            object_getInstanceVariable(obj, property_getName(property), (void *)&v);
            if([NSNumber numberWithInteger:v] != nil) {
                [pairDict setObject:[NSNumber numberWithInteger:v] forKey:[NSString stringWithCString:name encoding:NSUTF8StringEncoding]];
            }
        } else {
            // class数据类型
            object_getInstanceVariable(obj, property_getName(property), (void *)&valueRef);
            if (valueRef != nil) {
                [pairDict setObject:valueRef forKey:[NSString stringWithCString:name encoding:NSUTF8StringEncoding]];
            }
        }
    }
    
    return pairDict;
}

// 将对象转化成json
+ (NSString *)getJsonString:(id)obj {
    NSDictionary *aDict = [[self class] getPropertyList:obj];
    return [aDict JSONRepresentation];
}

// 将json转化成对象，以对象或数组的形式返回
+ (id)getModel:(Class)aClass withJson:(NSString *)jsonStr {
    id jsonValue = [jsonStr JSONValue];
    NSLog(@" jsonValue :%@",[jsonValue class]);
    if ([jsonValue isKindOfClass:[NSDictionary class]]) {
        // 字典
        NSDictionary *jsonDict = jsonValue;
        NSArray *keyArray = [jsonDict allKeys];
        if ([keyArray count] > 0) {
            id firstValue = [jsonDict objectForKey:[keyArray objectAtIndex:0]];
            if ([firstValue isKindOfClass:[NSDictionary class]]) {
                // 第一层是字典
                id object = [[self class] getModel:aClass withDict:firstValue];
                return object;
            }else if ([firstValue isKindOfClass:[NSArray class]]){
                // 第一层是数组
                NSArray *firstArray = firstValue;
                NSMutableArray *dataArray = [[NSMutableArray alloc] init];
                for (int i = 0; i < [firstArray count]; i++) {
                    NSDictionary *singleDict = [firstArray objectAtIndex:i];
                    id object = [[self class] getModel:aClass withDict:singleDict];
                    [dataArray addObject:object];
                }
                return dataArray;
            }
        }
    }else if ([jsonValue isKindOfClass:[NSArray class]]) {
        // 数组
        NSArray *firstArray = jsonValue;
        NSMutableArray *dataArray = [[NSMutableArray alloc] init];
        for (int i = 0; i < [firstArray count]; i++) {
            NSDictionary *singleDict = [firstArray objectAtIndex:i];
            id object = [[self class] getModel:aClass withDict:singleDict];
            [dataArray addObject:object];
        }
        return dataArray;
    }
    return nil;
}

// 根据字典转化成对象
+ (id)getModel:(Class)aClass withDict:(NSDictionary *)aDict {
    NSArray *modelKeyArray = [[self class] getKeyNameWithClass:aClass];
    NSObject *object = class_createInstance(aClass, 0);
    NSArray *singleKeyArray = [aDict allKeys];
    for (int j = 0; j < [singleKeyArray count]; j++) {  // 数据key循环
        NSString *dataKey = [singleKeyArray objectAtIndex:j];
        NSString *dataValue = [aDict objectForKey:dataKey];
        for (int k = 0; k < [modelKeyArray count]; k++) { // model的key循环
            NSString *modelKey = [modelKeyArray objectAtIndex:k];
            if ([dataKey isEqualToString:modelKey]) {
                [object setValue:dataValue forKey:modelKey];
            }
        }
    }
    return object;
}

/*******************************************************************************************/
+ (BOOL)isClassType:(NSString *)propDesc {
    return [propDesc rangeOfString:@"T@"].location != NSNotFound;
}

// 根据对象 获取key数组
+ (NSArray *)getKeyName:(NSObject *)className {
    NSMutableArray *keyArray = [[NSMutableArray alloc] init];
    id clazzOfObj = objc_getClass(class_getName([className class]));
    unsigned int numberOfProperties;
    objc_property_t *properties = class_copyPropertyList(clazzOfObj, &numberOfProperties);
    
    for (int i = 0; i < numberOfProperties; i++) {
        objc_property_t property = properties[i];
        const char * name = property_getName(property);
        NSString *keyName = [NSString stringWithCString:name encoding:NSUTF8StringEncoding];
        
        [keyArray addObject:keyName];
    }
    return keyArray;
}

// 根据类名 获取key数组
+ (NSArray *)getKeyNameWithClass:(Class)aClass {
    NSMutableArray *keyArray = [[NSMutableArray alloc] init];
    id clazzOfObj = objc_getClass(class_getName(aClass));
    unsigned int numberOfProperties;
    objc_property_t *properties = class_copyPropertyList(clazzOfObj, &numberOfProperties);
    for (int i = 0; i < numberOfProperties; i++) {
        objc_property_t property = properties[i];
        const char * name = property_getName(property);
        NSString *keyName = [NSString stringWithCString:name encoding:NSUTF8StringEncoding];
        [keyArray addObject:keyName];
    }
    
    return keyArray;
}

@end
