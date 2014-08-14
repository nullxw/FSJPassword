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
    NSString *jsonStr = @"{'data':{'savants':[{'summary':'        现担任中华医学会重症医学分会主任委员，中国病理生理学会危重病医学专业委员会常委，江苏省医学会重症医学分会主任委员等多项职务。 东南大学急诊与危重病医学研究所所长;卫生部有突出贡献中青年专家，江苏省优秀重点人才。\r\n        相继承担国家自然科学基金等数十项省部级以上课题；获得国家科技奖、中华医学科技奖、江苏省医学科技奖、江苏省科技进步二等奖等省级以上科研奖励20余项。','id':25,'name':'邱海波','job':'教授/主任医师 博士生导师 副院长/重症医学科主任','head':'/upload/c5c58e094c9059f47b629160b471183e.jpg'},{'summary':'        原全军重症医学专业委员会主任委员；中国病理生理学会危重病医学专业委员会 副主任委员；中华医学会重症医学分会常委。\r\n        主持北京市科委“乌司他丁、胸腺肽α1联合治疗严重脓毒症的免疫调理治疗新策略”、“早期低分子肝素治疗严重脓毒症”、“促进我军重症医学及学科建设规范化发展的研究”等科研课题。获得国家，军队重大奖项4次。荣立三等功1次。','id':24,'name':'林洪远','job':'教授/主任医师 原急危重症中心主任','head':'/upload/2.png'},{'summary':'       现任中华医学会重症医学分会常委、中国医师协会重症医学医师分会副会长、中国病理生理暨危重病医学会常委。四川省医学会重症医学专业委员会主任委员、四川省医师协会重症医师专科委员会主任委员、四川省重症医学质量控制中心主任。中华医学会重症医师资质培训委员会委员、资质培训班授课专家。《中国危重病急救医学》及《中国呼吸与危重监护杂志》编委。\r\n      获发明专利三项。曾获“亚洲医院管理奖”、“中华医学科技二等奖”、“四川省科技进步一等奖” 等奖项。','id':23,'name':'康焰','job':'教授/主任医师 博士生导师 重症医学科主任','head':'/upload/3.png'}],'pagination':{'total':3,'pageCount':1,'currPage':1,'maxCount':5,'pageIndex':0}},'code':0,'msg':null}";
    
    NSDictionary *dict = [jsonStr JSONValue];
    NSArray *resultArr = [[dict objectForKey:@"data"] objectForKey:@"savants"];
    NSArray *cArray = [RMMapper mutableArrayOfClass:[ProfessorModel class] fromArrayOfDictionary:resultArr];
    NSLog(@"cArray >>>> %d",[cArray count]);
}

@end
