//
//  LQDescriptionBuilder.m
//  LQLongQi
//
//  Created by 琥珀先知 on 13-10-11.
//  Copyright (c) 2013年 琥珀先知. All rights reserved.
//

#import "LQDescriptionBuilder.h"
#import "LQBeanUtil.h"
#import "LQKeyValuePair.h"

@implementation LQDescriptionBuilder

- (id)initWithObj:(id)obj {
    self = [super init];
    
    if (self) {
        _obj = obj;
        _keyValuePairs = [[NSMutableDictionary alloc] init];
    }
    
    return self;
}

- (LQDescriptionBuilder *)appendDisplayName:(NSString *)displayName displayValue:(NSString *)displayValue {
    [_keyValuePairs setValue:displayValue forKey:displayName];
    return self;
}

- (NSString *)description {
    NSString *desc = [NSString stringWithFormat:@"%@[", NSStringFromClass([_obj class])];
    
    id value;
    BOOL isFirst = YES;
    for (NSString *key in [_keyValuePairs allKeys]) {
        value = [_keyValuePairs valueForKey:key];
        if (!isFirst) {
            desc = [desc stringByAppendingString:@","];
        }
        desc = [desc stringByAppendingFormat:@"%@=%@", key, value];
        if (isFirst) {
            isFirst = NO;
        }
    }
    
    desc = [desc stringByAppendingString:@"]"];
    
    return desc;
}

+ (NSString *)reflectionToString:(id)obj {
    
    NSArray *propList = [LQBeanUtil getPropertyList:obj];
    
    LQDescriptionBuilder *descBuilder = [[LQDescriptionBuilder alloc] initWithObj:obj];
    for (LQKeyValuePair *pair in propList) {
        [descBuilder appendDisplayName:pair.key displayValue:pair.value];
    }
    return [descBuilder description];
}

@end
