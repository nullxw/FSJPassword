//
//  FSJHttpRequest.h
//  FSJPassword
//
//  Created by yto on 14-8-15.
//  Copyright (c) 2014年 yto_yewankun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
#import "UIKit+AFNetworking.h"

@interface FSJHttpRequest : NSObject

- (void)asyncExecute:(NSString *)url
              params:(NSDictionary *)params
             success:(void(^)(NSString *responseString))success
             failure:(void(^)(NSString *responseString, NSError *error))failure;

@end
