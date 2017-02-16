//
//  ZJMemberCenterViewController.m
//  农展物联网
//
//  Created by Mac on 17/2/9.
//  Copyright © 2017年 HBNXWLKJ. All rights reserved.
//

#import "ZJMemberCenterViewController.h"
#import "ZJPrivilegeController.h"
#import "ZJNoticeViewController.h"
#import "UIBarButtonItem+ZJButtonItem.h"

@interface ZJMemberCenterViewController ()

@end

@implementation ZJMemberCenterViewController
- (IBAction)more {
    ZJPrivilegeController * privilege = [[ZJPrivilegeController alloc]initWithNibName:NSStringFromClass([ZJPrivilegeController class]) bundle:nil];
    [self.navigationController pushViewController:privilege animated:YES];
    
}
- (void)notice {
    ZJNoticeViewController * notice = [[ZJNoticeViewController alloc]initWithStyle:UITableViewStylePlain];
    [self.navigationController pushViewController:notice animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor =ZJBGColor;
    self.title = @"会员中心";
    // Do any additional setup after loading the view.
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImage:@"通知" highImage:nil title:nil target:self action:@selector(notice)];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
