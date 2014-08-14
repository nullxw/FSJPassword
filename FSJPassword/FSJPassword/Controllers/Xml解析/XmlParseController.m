//
//  XmlParseController.m
//  FSJPassword
//
//  Created by yto on 14-8-14.
//  Copyright (c) 2014年 yto_yewankun. All rights reserved.
//

#import "XmlParseController.h"
#import "XMLParser.h"

@interface XmlParseController ()

@end

@implementation XmlParseController

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
    NSString *xml = [NSString stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"b" ofType:@"xml"] encoding:NSUTF8StringEncoding error:nil];
    NSData *xmlData = [xml dataUsingEncoding:NSUTF8StringEncoding];
    XMLParser *xmlParser = [[XMLParser alloc] init];
    [xmlParser parseData:xmlData
				 success:^(id parsedData) {
                     NSLog(@"parsedData >>> %@",parsedData);
                     t_array = [[parsedData objectForKey:@"contact"] objectForKey:@"phonesArray"];
                     [v_table reloadData];
				 }
				 failure:^(NSError *error) {
					 NSLog(@"Error : %@", error);
                     
				 }];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [t_array count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *XMLCellIdentifier = @"XMLCellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:XMLCellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:XMLCellIdentifier];
    }
    int row = [indexPath row];
    NSDictionary *aDict = [t_array objectAtIndex:row];
    cell.textLabel.text = [NSString stringWithFormat:@"%@ --- %@",[aDict objectForKey:@"type"],[aDict objectForKey:@"content"]];
    return cell;
}

#pragma mark - UITableViewDelegate
@end
