//
//  FSJNetUtil.h
//  FSJPassword
//
//  Created by yto on 14-8-15.
//  Copyright (c) 2014年 yto_yewankun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FSJHttpRequest.h"

@interface FSJNetUtil : NSObject

/** 
 * post 请求
 **/
+ (void)sendPostRequestWithUrl:(NSString *)url
                parameters:(NSDictionary *)parameters
                   success:(void(^)(NSString *responseString))success
                   failure:(void(^)(NSString *responseString, NSError *error))failure;
@end
