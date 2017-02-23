//
//  ZJNoticeViewController.m
//  农展物联网
//
//  Created by Mac on 17/2/9.
//  Copyright © 2017年 HBNXWLKJ. All rights reserved.
//

#import "ZJNoticeViewController.h"
 
 

@interface ZJNoticeViewController ()

@end

@implementation ZJNoticeViewController
static NSString * Identifier = @"Cell";
- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.tableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    
    // Do any additional setup after loading the view.
//    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:Identifier];
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, -64, ZJScreenW, 64)];
    view.backgroundColor =ZJGreenColor;
    [self.tableView addSubview:view];
    self.navigationController.hidesBarsOnSwipe = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mrak-tableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 3;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:Identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:Identifier];
//        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.text = @"[温度警报]23号玻璃温室空气温度过高";
        cell.detailTextLabel.text = @"2016-11-19 08:03:44";
        cell.imageView.image = [UIImage imageNamed:@"tp-blue"];
    }
    
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 60;
}

 
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 1;
}

-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    
    return [UIView new];
}


@end
