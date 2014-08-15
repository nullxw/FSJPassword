//
//  LQDescriptionBuilder.h
//  LQLongQi
//
//  Created by 琥珀先知 on 13-10-11.
//  Copyright (c) 2013年 琥珀先知. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LQDescriptionBuilder : NSObject {
@private
    id _obj;
    NSMutableDictionary *_keyValuePairs;
}

- (id)initWithObj:(id)obj;
- (LQDescriptionBuilder *)appendDisplayName:(NSString *)displayName displayValue:(NSString *)displayValue;
+ (NSString *)reflectionToString:(id)obj;
@end
