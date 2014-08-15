//
//  LQKeyValuePair.m
//  LQLongQi
//
//  Created by 琥珀先知 on 13-10-11.
//  Copyright (c) 2013年 琥珀先知. All rights reserved.
//

#import "LQKeyValuePair.h"

@implementation LQKeyValuePair
@synthesize key;
@synthesize value;

- (id)initWithKey:(id)aKey value:(id)aValue {
    self = [super init];
    if (self) {
        key = aKey;
        value = aValue;
    }
    return self;
}

@end
