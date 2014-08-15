//
//  FSJNetUtil.m
//  FSJPassword
//
//  Created by yto on 14-8-15.
//  Copyright (c) 2014年 yto_yewankun. All rights reserved.
//

#import "FSJNetUtil.h"

@implementation FSJNetUtil

/**
 * post 请求
 **/
+ (void)sendPostRequestWithUrl:(NSString *)url
                    parameters:(NSDictionary *)parameters
                       success:(void(^)(NSString *responseString))success
                       failure:(void(^)(NSString *responseString, NSError *error))failure {
    dispatch_queue_t aQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(aQueue, ^{
        @autoreleasepool {
            FSJHttpRequest *request = [[FSJHttpRequest alloc] init];
            [request asyncExecute:url params:parameters success:success failure:failure];
        }
    });
}

@end
