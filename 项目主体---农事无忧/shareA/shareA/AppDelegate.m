//
//  AppDelegate.m
//  shareA
//
//  Created by Mac on 17/1/10.
//  Copyright © 2017年 HBNXWLKJ. All rights reserved.
//

#import "AppDelegate.h"
#import <TencentOpenAPI/TencentOAuth.h>
#import "WXApiManager.h"
#import "WXApi.h"

@interface AppDelegate ()<TencentSessionDelegate,TencentLoginDelegate >
@property(nonatomic,strong) TencentOAuth * tencentOAuth;
@property(nonatomic,strong) NSArray * permissions;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [WXApi registerApp:@"wx0838a91efcf1214a"];
  
    NSString * path =  NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
 
    
    NSString * flie = [path stringByAppendingPathComponent:plistFlie];
      NSDictionary* dic =  [NSDictionary dictionaryWithContentsOfFile:flie];
        if (dic&& dic[@"_accessToken"])
        {
            NSDate * date = dic[@"_expirationDate"];
            NSTimeInterval second = [date timeIntervalSinceDate:[NSDate date]];
            if   (7776000-second) {
              _tencentOAuth = [[TencentOAuth alloc]initWithAppId:ID andDelegate:self];
                _tencentOAuth.accessToken = dic[@"_accessToken"];
                _tencentOAuth.openId = dic[@"_openId"];
                _tencentOAuth.expirationDate = dic[@"_expirationDate"];
                _tencentOAuth.appId = dic[@"_appId"];
            }else
            {
                _tencentOAuth = [[TencentOAuth alloc]initWithAppId:ID andDelegate:self];
                _permissions =  [NSArray arrayWithObjects:
                                 kOPEN_PERMISSION_GET_USER_INFO,
                                 kOPEN_PERMISSION_GET_SIMPLE_USER_INFO,
                                 kOPEN_PERMISSION_ADD_SHARE,   kOPEN_PERMISSION_GET_INFO, kOPEN_PERMISSION_ADD_TOPIC,
                                 nil];
                
                
                BOOL Oauth =  [_tencentOAuth authorize:_permissions inSafari:NO];
                _tencentOAuth.sessionDelegate = self;
                if (Oauth)
                {
                                        ZJLog(@"Oauth %i",Oauth);
                    ZJlogFunction;
                    
                }
            }
        
    }else{
        
            _tencentOAuth = [[TencentOAuth alloc]initWithAppId:ID andDelegate:self];
            _permissions =  [NSArray arrayWithObjects:
                             kOPEN_PERMISSION_GET_USER_INFO,
                           //  kOPEN_PERMISSION_GET_SIMPLE_USER_INFO,
                          //   kOPEN_PERMISSION_ADD_SHARE,//  kOPEN_PERMISSION_GET_INFO,//kOPEN_PERMISSION_ADD_TOPIC,
                             nil];
            
            
            BOOL Oauth =  [_tencentOAuth authorize:_permissions inSafari:NO];
            if (Oauth)
            {
                
                ZJLog(@"Oauth %i",Oauth);
                ZJlogFunction;
                
            }
 
    }
    
    //    2.获取当前所处时区
//    NSDate * date = [NSDate date];
//    NSTimeZone *zone = [NSTimeZone systemTimeZone];
//    ZJLog(@"now = %@", zone);
//    
//    //    3.获取当前时区和指定时间差
//    NSInteger seconds = [zone secondsFromGMTForDate:date];
//    ZJLog(@"seconds = %lu", seconds);
//    
//    NSDate *nowDate = [date dateByAddingTimeInterval:seconds];
//    ZJLog(@"nowDate = %@", nowDate);
    
 
    return YES;
}


-(BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options{
    ZJlogFunction;
    ZJLog(@"url:%@",url);
    ZJLog(@"options: %@",options);
    if (YES == [TencentApiInterface canOpenURL:url delegate:self])
    {
        [TencentApiInterface handleOpenURL:url delegate:self];
    }
    if (YES ==[WXApi handleOpenURL:url delegate:[WXApiManager sharedManager]]   ) {
        return YES;
    }
    return [TencentOAuth HandleOpenURL:url];
}
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url{
    if (YES == [TencentApiInterface canOpenURL:url delegate:self])
    {
        [TencentApiInterface handleOpenURL:url delegate:self];
    }
#if __QQAPI_ENABLE__
    [QQApiInterface handleOpenURL:url delegate:(id)[QQAPIDemoEntry class]];
#endif
    if (YES == [TencentOAuth CanHandleOpenURL:url])
    {
        return [TencentOAuth HandleOpenURL:url];
    }
    return YES;
 
}
-(BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation{
    return [WXApi handleOpenURL:url delegate:[WXApiManager sharedManager]];
}

-(void)tencentDidLogin{
    QQVersion  version =[TencentOAuth iphoneQQVersion];
    /**
     *  NSMutableDictionary* _apiRequests;
     NSString* _accessToken;
     NSDate* _expirationDate;
     id<TencentSessionDelegate> _sessionDelegate;
     NSString* _localAppId;
     NSString* _openId;
     NSString* _redirectURI;
     NSArray* _permissions;
     */
    ZJLog(@"_accessToken:%@ \n_expirationDate :%@\n _localAppId:%@\n _openId:%@\n _redirectURI:%@\n _permissions:%d",_tencentOAuth.accessToken,_tencentOAuth.expirationDate,_tencentOAuth.localAppId,_tencentOAuth.openId,_tencentOAuth.redirectURI,_tencentOAuth.authMode);
    ZJLog(@"version:%d",version);
    
    NSString * path =  NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
    path = [path stringByAppendingPathComponent:plistFlie];
    NSMutableDictionary* dic =  [NSMutableDictionary dictionary ];
    ZJLog(@"%@",path);
//    NSString * path =  NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
//    
//   NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    
    dic[@"_accessToken"]= _tencentOAuth.accessToken;
    dic[@"_expirationDate"]= _tencentOAuth.expirationDate;
    dic[@"_openId"]= _tencentOAuth.openId;
    dic[@"_appId"]=_tencentOAuth.appId;
//    path = [path stringByAppendingPathComponent:plistFlie];
    [dic writeToFile:path atomically:YES];
   // NSDictionary *resultDic = [NSDictionary dictionaryWithContentsOfFile:path];

 
   
    ZJlogFunction;
    
}
-(void)tencentDidNotLogin:(BOOL)cancelled{
    ZJlogFunction;
    if (cancelled)
    {
      ZJLog( @"用户取消登录");
    }
    else
    {
        ZJLog( @"登录失败");
    }

    
}

-(void)tencentDidNotNetWork{
    ZJlogFunction;
    ZJLog(@"无网络连接，请设置网络");
}

-(NSArray *)getAuthorizedPermissions:(NSArray *)permissions withExtraParams:(NSDictionary *)extraParams{
    ZJLog(@"permissions:%@",permissions);
    ZJlogFunction;
    return nil;
}
- (void)getUserInfoResponse:(APIResponse*) response{
    
    ZJlogFunction;
    ZJLog(@"response.message:%@",response.message);
}/**
  * 分享到QZone回调
  * \param response API返回结果，具体定义参见sdkdef.h文件中\ref APIResponse
  * \remarks 正确返回示例: \snippet example/addShareResponse.exp success
  *          错误返回示例: \snippet example/addShareResponse.exp fail
  */
- (void)addShareResponse:(APIResponse*) response{
    ZJlogFunction;
}

- (BOOL)addTopicWithParams:(NSMutableDictionary *)params{
    ZJLog(@"%@",params);
    ZJlogFunction;
    return  YES;
}


@end
