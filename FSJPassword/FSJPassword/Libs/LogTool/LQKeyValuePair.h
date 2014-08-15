//
//  LQKeyValuePair.h
//  LQLongQi
//
//  Created by 琥珀先知 on 13-10-11.
//  Copyright (c) 2013年 琥珀先知. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LQKeyValuePair : NSObject

@property(nonatomic, strong) id key;
@property(nonatomic, strong) id value;

- (id)initWithKey:(id)aKey value:(id)aValue;
@end
