//
//  AppDelegate.m
//  农展物联网
//
//  Created by Mac on 17/1/12.
//  Copyright © 2017年 HBNXWLKJ. All rights reserved.
//

#import "AppDelegate.h"
#import "NMBottomTabBarController.h"
#import "ViewController.h"
#import "ZJNaviController.h"
#import "ZJTableViewController.h"

@interface AppDelegate ()<NMBottomTabBarControllerDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    /*
    UIStoryboard * storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    ViewController*oneController = [storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([ViewController class])];
    ZJNaviController * navi = [[ZJNaviController alloc]initWithRootViewController:oneController];
    
    
    oneController.view.backgroundColor = ZJBGColor;
    UIViewController *twoController = [UIViewController new];
     ZJNaviController * navi2 = [[ZJNaviController alloc]initWithRootViewController:twoController];
    twoController.view.backgroundColor =ZJBGColor;
    UIViewController *threeController = [UIViewController new];
     ZJNaviController * navi3 = [[ZJNaviController alloc]initWithRootViewController:threeController];
    threeController.view.backgroundColor =ZJBGColor;
    UIViewController *fourController = [UIViewController new];
    fourController.view.backgroundColor = [UIColor orangeColor];
    NMBottomTabBarController *tabBarController = (NMBottomTabBarController *)self.window.rootViewController;
    
    
    tabBarController.tabBar.separatorImage = [UIImage imageNamed:@"间隔线"];
    
    tabBarController.controllers = [NSArray arrayWithObjects:navi,navi2,navi3,  nil];
    tabBarController.delegate = self;
    [tabBarController.tabBar configureTabAtIndex:0 andTitleOrientation :kTitleToRightOfIcon  withUnselectedBackgroundImage:[UIImage imageNamed:@"unselected.jpeg"] selectedBackgroundImage:[UIImage imageNamed:@"地标选中"] iconImage:[UIImage imageNamed:@"地标"]  andText:@"地标"andTextFont:[UIFont systemFontOfSize:20.0] andFontColour:[UIColor whiteColor]];
    [tabBarController.tabBar configureTabAtIndex:1 andTitleOrientation : kTitleToRightOfIcon withUnselectedBackgroundImage:[UIImage imageNamed:@"unselected.jpeg"] selectedBackgroundImage:[UIImage imageNamed:@"监控场景选中"] iconImage:[UIImage imageNamed:@"监控场景"]  andText:@"场景" andTextFont:[UIFont systemFontOfSize:20.0] andFontColour:[UIColor whiteColor]];
    [tabBarController.tabBar configureTabAtIndex:2 andTitleOrientation : kTitleToRightOfIcon withUnselectedBackgroundImage:[UIImage imageNamed:@"unselected.jpeg"] selectedBackgroundImage:[UIImage imageNamed:@"我的选中"] iconImage:[UIImage imageNamed:@"我的"]  andText:@"我的" andTextFont:[UIFont systemFontOfSize:20.0] andFontColour:[UIColor whiteColor]];
//    [tabBarController.tabBar configureTabAtIndex:3 andTitleOrientation : kTitleToRightOfIcon withUnselectedBackgroundImage:[UIImage imageNamed:@"unselected.jpeg"] selectedBackgroundImage:[UIImage imageNamed:@"selected.jpeg"] iconImage:[UIImage imageNamed:@"calendar"]  andText:@"Calendar" andTextFont:[UIFont systemFontOfSize:12.0] andFontColour:[UIColor whiteColor]];
    
    [tabBarController selectTabAtIndex:0];
*/
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    
    
    ZJTableViewController * table = [[ZJTableViewController alloc]init];
    self.window.rootViewController = table;
    [self.window makeKeyAndVisible];
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
