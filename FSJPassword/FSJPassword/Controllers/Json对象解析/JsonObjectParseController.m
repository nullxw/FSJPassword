//
//  JsonObjectParseController.m
//  FSJPassword
//
//  Created by yto on 14-8-14.
//  Copyright (c) 2014年 yto_yewankun. All rights reserved.
//

#import "JsonObjectParseController.h"

@interface JsonObjectParseController ()

@end

@implementation JsonObjectParseController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self initView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initView {
    [self requestData];
}

#pragma mark - 数据请求
- (void)requestData {
    NSString *url = @"http://121.199.46.47/api/ListLabel.aspx";
    NSMutableDictionary *pDict = [[NSMutableDictionary alloc] init];
    [pDict setObject:@"XY2013" forKey:@"ss"];
    [pDict setObject:@"1036" forKey:@"topicID"];
    [FSJNetUtil sendPostRequestWithUrl:url parameters:pDict success:^(NSString *responseString) {
        NSLog(@"responseString   :   %@",responseString);
        NSDictionary *dataDict = [responseString JSONValue];
        NSArray *resultArr = [dataDict objectForKey:@"result"];
        NSArray *aArray = [RMMapper mutableArrayOfClass:[LabelModel class] fromArrayOfDictionary:resultArr];
        NSLog(@"aArray >>> %@",aArray);
    } failure:^(NSString *responseString, NSError *error) {
        
    }];
}

@end
