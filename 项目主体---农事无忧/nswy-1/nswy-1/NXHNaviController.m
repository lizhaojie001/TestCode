//
//  NXHNaviController.m
//  农事无忧
//
//  Created by Mac on 16/8/31.
//  Copyright © 2016年 HBNXWLKJ. All rights reserved.
//

#import "NXHNaviController.h"

@interface NXHNaviController ()<UINavigationControllerDelegate,UIGestureRecognizerDelegate>

@end

@implementation NXHNaviController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.interactivePopGestureRecognizer.delegate= self;

 
}

+ (void)initialize
{
    //设置全局导航栏颜色
   //[[UINavigationBar appearance] setBarTintColor:[UIColor colorWithRed:39/255.0 green:158/255.0 blue:76/255.0 alpha:0.8]];
     [[UINavigationBar appearance] setBarTintColor:[UIColor whiteColor]];
    
}



- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.childViewControllers.count) { // 不是根控制器
        
        viewController.hidesBottomBarWhenPushed = YES;
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
//        [btn setTitle:@"返回" forState:UIControlStateNormal];
//        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btn setImage:[[UIImage imageNamed:@"返回"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]forState:UIControlStateNormal];
    
        [btn sizeToFit];
        
        [btn addTarget:self action:@selector(popToPre) forControlEvents:UIControlEventTouchUpInside];
        
       
        UIBarButtonItem *left = [[UIBarButtonItem  alloc]initWithCustomView:btn];
       //btn.contentEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0);
        // 设置导航条的按钮
         viewController.navigationItem.leftBarButtonItem = left;
        viewController.hidesBottomBarWhenPushed = YES;
        

           }
    
    [super pushViewController:viewController animated:animated];

    
}
 
- (void)popToPre
{     
    [self popViewControllerAnimated:YES];
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{

    return self.viewControllers.count>1;
}

@end
