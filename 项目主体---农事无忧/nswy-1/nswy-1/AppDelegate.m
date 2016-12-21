//
//  AppDelegate.m
//  nswy-1
//
//  Created by Mac on 16/12/2.
//  Copyright © 2016年 HBNXWLKJ. All rights reserved.
//

#import "AppDelegate.h"
#import "CYLTabBarController.h"

#import "nswyFollowViewController.h"
#import "nswyMeViewController.h"
#import "nswyMessageViewController.h"
#import "nswyEditorViewController.h"
#import "nswyDiscoverViewController.h"
#import "NXHNaviController.h"
#import "CYLPlusButtonSubclass.h"

@interface AppDelegate ()
/**根控制器*/
@property (nonatomic,strong) CYLTabBarController * tabBarController;

@end

@implementation AppDelegate

/**
 *  tabBarItem 的选中和不选中文字属性、背景图片
 */
- (void)customizeInterface {
    
    // 普通状态下的文字属性
    NSMutableDictionary *normalAttrs = [NSMutableDictionary dictionary];
    normalAttrs[NSForegroundColorAttributeName] = [UIColor grayColor];
    
    // 选中状态下的文字属性
    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    selectedAttrs[NSForegroundColorAttributeName] = [UIColor darkGrayColor];
    
    // 设置文字属性
    UITabBarItem *tabBar = [UITabBarItem appearance];
    [tabBar setTitleTextAttributes:normalAttrs forState:UIControlStateNormal];
    [tabBar setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
    
//    // 设置背景图片
//    UITabBar *tabBarAppearance = [UITabBar appearance];
//    [tabBarAppearance setBackgroundImage:[UIImage imageNamed:@"tabbar_background"]];
}


- (void)setupViewControllers {
    
    nswyFollowViewController *secondViewController = [[nswyFollowViewController alloc] init];
    UIViewController *secondNavigationController = [[NXHNaviController alloc]
                                                    initWithRootViewController:secondViewController];
    
    nswyDiscoverViewController *firstViewController = [[nswyDiscoverViewController alloc] initWithStyle:UITableViewStyleGrouped];
    UIViewController *firstNavigationController = [[NXHNaviController alloc]
                                                   initWithRootViewController:firstViewController];
    
//    UIStoryboard * storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//    nswyEditorViewController *threeViewController = [storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([nswyEditorViewController class])];
//    UIViewController * threeNavi = [[NXHNaviController alloc]initWithRootViewController:threeViewController];
    
    nswyMessageViewController * fourViewController = [[nswyMessageViewController alloc]initWithStyle:UITableViewStylePlain];
    UIViewController * fourNavi = [[NXHNaviController alloc]initWithRootViewController:fourViewController];
    
    nswyMeViewController * fiveViewController = [[nswyMeViewController alloc]initWithStyle:UITableViewStyleGrouped];
    UIViewController * fiveNavi = [[NXHNaviController alloc]initWithRootViewController:fiveViewController];
    
    CYLTabBarController *tabBarController = [[CYLTabBarController alloc] init];
    [self customizeTabBarForController:tabBarController];
    
    [tabBarController setViewControllers:@[secondNavigationController,
                                           firstNavigationController
                                           //,threeNavi,
                                           ,fourNavi,fiveNavi
                                           ]];
    self.tabBarController = tabBarController;
}
/*
 *
 在`-setViewControllers:`之前设置TabBar的属性，
 *
 */
- (void)customizeTabBarForController:(CYLTabBarController *)tabBarController {
    
    NSDictionary *dict1 = @{
                            CYLTabBarItemTitle : @"关注",
                            CYLTabBarItemImage : @"未选中关注",
                            CYLTabBarItemSelectedImage : @"关注",
                            };
    NSDictionary *dict2 = @{
                            CYLTabBarItemTitle : @"发现",
                            CYLTabBarItemImage : @"未选中发现",
                            CYLTabBarItemSelectedImage : @"发现",
                            };
//    NSDictionary *dict3 = @{
//                            CYLTabBarItemTitle : @"写文章",
//                            CYLTabBarItemImage : @"文章",
//                            CYLTabBarItemSelectedImage : @"文章",
//                            };
    NSDictionary *dict4 = @{
                            CYLTabBarItemTitle : @"消息",
                            CYLTabBarItemImage : @"未选中消息",
                            CYLTabBarItemSelectedImage : @"消息",
                            };
    
    NSDictionary *dict5= @{
                            CYLTabBarItemTitle : @"我的",
                            CYLTabBarItemImage : @"未选中我的",
                            CYLTabBarItemSelectedImage : @"我的",
                            };
    NSArray *tabBarItemsAttributes = @[ dict1, dict2,/*dict3*/dict4,dict5];
    tabBarController.tabBarItemsAttributes = tabBarItemsAttributes;
}
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [CYLPlusButtonSubclass registerPlusButton];
    [self setupViewControllers];
    
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
   
    
    self.window.rootViewController = self.tabBarController;
    [self customizeInterface];
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
