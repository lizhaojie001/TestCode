//
//  ViewController.m
//  shareA
//
//  Created by Mac on 17/1/10.
//  Copyright © 2017年 HBNXWLKJ. All rights reserved.
//

#import "ViewController.h"
#import <TencentOpenAPI/QQApiInterfaceObject.h>
#import <TencentOpenAPI/QQApiInterface.h>
#import <TencentOpenAPI/TencentOAuth.h>

#import "AFNetworking.h"

#import "WXApi.h"
#import "WXApiObject.h"
@interface ViewController ()

@end

@implementation ViewController
- (IBAction)shareWeixin:(UIButton *)sender {
    WXMediaMessage *message = [WXMediaMessage message];
    //缺少缩略图图片处理
    [message setThumbImage:[UIImage imageNamed:@"image.png"]];
    //缩略图
    WXImageObject * imageObject = [WXImageObject object];
    NSString* filePath = [[NSBundle mainBundle] pathForResource:@"image" ofType:@"png"];
    imageObject.imageData = [NSData dataWithContentsOfFile:filePath];
    message.mediaObject = imageObject;
    
    SendMessageToWXReq *req = [[SendMessageToWXReq alloc]init];
    req.bText =NO;
    req.message = message;
    req.scene= WXSceneTimeline;
    [WXApi sendReq:req];
    ZJlogFunction;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    // Do any additional setup after loading the view, typically from a nib.
}
- (IBAction)share:(UIButton *)sender {
    //开发者分享的文本内容
//    QQApiTextObject *txtObj = [QQApiTextObject objectWithText:self.text.text];
//    SendMessageToQQReq *req = [SendMessageToQQReq reqWithContent:txtObj];\
    //分享新闻! http://7xux50.com2.z0.glb.clouddn.com/20170106148367081880539.jpg?imageView2/0/format/jpg
//    QQApiNewsObject * news = [QQApiNewsObject objectWithURL:[NSURL URLWithString:@"http://7xntys.com1.z0.glb.clouddn.com/WeChatSight1.mp4"] title:@"test" description:@"This is a test DemoThis is a test DemoThis is a test DemoThis is a test DemoThis is a test Demo" previewImageURL:[NSURL URLWithString:@"http://7xux50.com2.z0.glb.clouddn.com/20170106148367081880539.jpg?imageView2/0/format/jpg"]];
//    SendMessageToQQReq * req = [SendMessageToQQReq reqWithContent:news];
//    QQApiAudioObject * audio = [QQApiAudioObject objectWithURL:[NSURL URLWithString:@"http://7xntys.com1.z0.glb.clouddn.com/Secret%20Garden-Adagio.mp3"] title:@"audio Test" description:@"audio test Demo" previewImageURL:[NSURL URLWithString:@"http://7xux50.com2.z0.glb.clouddn.com/20170106148367081880539.jpg?imageView2/0/format/jpg"]];
//    SendMessageToQQReq * req = [SendMessageToQQReq reqWithContent:audio];
//    //    QQApiSendResultCode sent = [QQApiInterface sendReq:req];
//    QQApiSendResultCode sent= [ QQApiInterface SendReqToQZone:req];
    NSString * file = [[NSBundle mainBundle] pathForResource:@"image" ofType:@"png"];
    NSData * data = [NSData dataWithContentsOfFile:file];
    QQApiImageArrayForQZoneObject* image = [[QQApiImageArrayForQZoneObject alloc]initWithImageArrayData:@[data] title:@"图片分享测试"];
    SendMessageToQQReq * req = [SendMessageToQQReq reqWithContent:image];
//            QQApiSendResultCode sent = [QQApiInterface sendReq:req];
        QQApiSendResultCode sent= [ QQApiInterface SendReqToQZone:req];

    ZJLog(@"sent%d",sent);
}
- (IBAction)deliver:(UIButton *)sender {
    [self.view endEditing:YES];
    //发表说说 https://graph.qq.com/shuoshuo/add_topic?oauth_consumer_key=100330589&access_token=AD3E4037FD3470EC2E37DF561AC70760&openid=DE610F6145F93F6C53CB32BA3C5AED96&format=json&con=test时间戳1484125724251
   AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    NSString * urlString =@"https://graph.qq.com/shuoshuo/add_topic";
//    NSURLRequest * request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"https://graph.qq.com/shuoshuo/add_topic"]];
    
    
    NSString * path =  NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
     NSString * flie = [path stringByAppendingPathComponent:plistFlie];
    NSDictionary* dic =  [NSDictionary dictionaryWithContentsOfFile:flie];
    
    
    NSMutableDictionary * dicS = [NSMutableDictionary dictionary];
    ZJLog(@" _accessToken :%@",dic[@"_accessToken"]);
    dicS[@"oauth_consumer_key"] =dic[@"_appId"];
    dicS[@"access_token"]=dic[@"_accessToken"];
    dicS[@"openid"]= dic[@"_openId"];
    dicS[@"con"]= @"_123";
    
    

    ZJLog(@"%@",dicS);
  
    [manager POST:urlString parameters:dicS success:^(NSURLSessionDataTask *task, id responseObject) {
        ZJLog(@"%@",responseObject);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        ZJLog(@"失败");
    }];
    
    
}
 

@end
