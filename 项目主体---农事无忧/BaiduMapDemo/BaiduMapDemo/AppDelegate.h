//
//  AppDelegate.h
//  BaiduMapDemo
//
//  Created by Mac on 17/1/3.
//  Copyright © 2017年 HBNXWLKJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <BaiduMapAPI_Map/BMKMapView.h>//只引入所需的单个头文件
@interface AppDelegate : UIResponder <UIApplicationDelegate>{
    UINavigationController *navigationController;
    BMKMapManager* _mapManager;
}

@property (strong, nonatomic) UIWindow *window;


@end

