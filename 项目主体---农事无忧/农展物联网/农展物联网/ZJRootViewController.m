//
//  ZJRootViewController.m
//  农展物联网
//
//  Created by Mac on 17/2/9.
//  Copyright © 2017年 HBNXWLKJ. All rights reserved.
//

#import "ZJRootViewController.h"

@interface ZJRootViewController ()

@end

@implementation ZJRootViewController
-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}
-(void)viewDidLoad{
    [super viewDidLoad];
      self.navigationController.navigationBar.titleTextAttributes = @{NSFontAttributeName: [UIFont systemFontOfSize:20],NSForegroundColorAttributeName :[UIColor whiteColor]};
}
 @end
