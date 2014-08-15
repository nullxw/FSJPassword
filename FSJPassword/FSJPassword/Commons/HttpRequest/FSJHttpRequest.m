//
//  FSJHttpRequest.m
//  FSJPassword
//
//  Created by yto on 14-8-15.
//  Copyright (c) 2014年 yto_yewankun. All rights reserved.
//

#import "FSJHttpRequest.h"

@implementation FSJHttpRequest


- (void)asyncExecute:(NSString *)url
              params:(NSDictionary *)params
             success:(void(^)(NSString *responseString))success
             failure:(void(^)(NSString *responseString, NSError *error))failure {
    [self executeHttpRequest:url params:params success:success failure:failure];
}

- (void)executeHttpRequest:(NSString *)url
                    params:(NSDictionary *)params
                   success:(void(^)(NSString *responseString))success
                   failure:(void(^)(NSString *responseString, NSError *error))failure {
    //https://api.app.net/
    //http://114.80.201.219:8082/greenark/
    //http://121.199.46.47/
//    NSURL *baseUrl = [NSURL URLWithString:@"http://121.199.46.47/"];
//    NSString *tempUrl = @"api/ListLabel.aspx";
    //@"opt.do?ctrl_business=savants";
    //@"http://114.80.201.219:8082/greenark/opt.do?ctrl_business=savants";
    //@"stream/0/posts/stream/global";
//    http://121.199.46.47/api/ListLabel.aspx
//    NSMutableDictionary *pDict = [[NSMutableDictionary alloc] init];
////    [pDict setObject:@"1" forKey:@"limit_startPage"];
////    [pDict setObject:@"10" forKey:@"limit_maxCount"];
//    
//    [pDict setObject:@"XY2013" forKey:@"ss"];
//    [pDict setObject:@"1036" forKey:@"topicID"];
    
//    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//    AFHTTPRequestOperation *operation = [manager POST:@"http://121.199.46.47/api/ListLabel.aspx" parameters:pDict success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSLog(@"JSON post: %@", responseObject);
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLog(@"Error: %@", error);
//    }];
//    [operation start];
    
//    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//    [manager GET:@"http://www.baidu.com/" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSLog(@"JSON get: %@", responseObject);
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLog(@"Error: %@", error);
//    }];
    
    // 成功  AFHTTPRequestSerializer 类似于 旧版本中的AFHTTPClient
    [self setNetworkActivityStart];
    AFHTTPRequestSerializer *httpClient = [AFHTTPRequestSerializer serializer];
    NSMutableURLRequest *request = [httpClient requestWithMethod:@"POST" URLString:url parameters:params error:nil];
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    operation.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        [self setNetworkActivityEnd];
        if (success) {
            success(operation.responseString);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self setNetworkActivityEnd];
        if (failure) {
            failure(operation.responseString,error);
        }
    }];
    [operation start];
}

- (void)setNetworkActivityStart {
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
}

- (void)setNetworkActivityEnd {
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
}

@end
