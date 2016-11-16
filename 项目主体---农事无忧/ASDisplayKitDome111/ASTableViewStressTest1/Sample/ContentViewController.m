//
//  ContentViewController.m
//  Sample
//
//  Created by Mac on 16/11/14.
//  Copyright © 2016年 Facebook. All rights reserved.
//

#import "ContentViewController.h"
#import <WebKit/WebKit.h>
@interface ContentViewController ()<WKNavigationDelegate,WKUIDelegate>
/**<#注释#>*/
@property (nonatomic,strong) WKWebView * webView;
/**UIActivityIndicatorView * */
@property (nonatomic,strong) UIActivityIndicatorView *  indicator;

@end

@implementation ContentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
  //评论框
  
  
  
  
  //加载指示
  UIActivityIndicatorView * dicator = [[UIActivityIndicatorView alloc]initWithFrame:CGRectMake(0, 0, 50, 50)];
  dicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhite ;
  dicator.center = CGPointMake(self.view.center.x, self.view.center.y);
 // dicator.color= [UIColor redColor];
  self.indicator = dicator;
  
  [self.view addSubview:dicator];
  [self.indicator startAnimating];
  UIButton * button = [UIButton buttonWithType:UIButtonTypeSystem];
  button.frame =CGRectMake(0, 0, 50, 50);
  [button setBackgroundColor:[UIColor blueColor]];
  [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
  [self.view addSubview:button];
 
  
  
  NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
  
  NSString *documentsDirectory = [paths objectAtIndex:0]; 
  
  NSString *filepath = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@%@.html",self.content.ID,self.content.fcreatetime]];
  NSLog(@"path -----:%@",filepath);
  // JS发送POST的Flag，为真的时候会调用JS的POST方法（仅当第一次的时候加载本地JS）
  WKWebViewConfiguration * configuration = [[WKWebViewConfiguration alloc]init];
  //允许在线播放
  configuration.allowsInlineMediaPlayback = YES;
  //允许播放视频
  configuration.allowsAirPlayForMediaPlayback = YES;
  self.view.backgroundColor = [UIColor whiteColor];
  
  // 创建WKWebView
  self.webView = [[WKWebView alloc]initWithFrame:[UIScreen mainScreen].bounds configuration:configuration];
  self.webView.scrollView.showsVerticalScrollIndicator =NO;
  self.webView.scrollView.contentInset = UIEdgeInsetsMake(64,0,
                                                           0, 0);
  UIView *signtureView = [[UIView alloc]initWithFrame:CGRectMake(0, -64, self.view.bounds.size.width, 64)];
  signtureView.backgroundColor = [UIColor redColor];
   [self.webView.scrollView addSubview:signtureView];
  //self.webView.backgroundColor = [UIColor colorWithDisplayP3Red:176/255.0 green:176/255.0 blue:176/255.0 alpha:1];
  //设置代理
  self.webView.navigationDelegate = self;
   
  // 获得html内容
  NSError * error ;
  NSString *html = [[NSString alloc] initWithContentsOfFile:filepath encoding:NSUTF8StringEncoding error:&error];
  // 加载js有错误返回
  
  if (error) {
    NSLog(@"%s",__func__);
    
    return  ;
  }
  [self.webView loadHTMLString:html baseURL:[[NSBundle mainBundle] bundleURL]];
  // 将WKWebView添加到当前View
  [self.view addSubview:self.webView];
  [self.view bringSubviewToFront:button];
  [self.view bringSubviewToFront:self.indicator];
  
  
  
 }

-(void)back{
  [self dismissViewControllerAnimated:YES completion:nil];
}
//接收到服务器跳转请求
//-(void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(WKNavigation *)navigation{
  
//}

//决定跳转的代理
//-(void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler{
  
//}

//决定是否跳转代理
//- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler{
  
//}

- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation{
  NSLog(@"%s",__func__);
}
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
  NSLog(@"%s",__func__);

}
-(void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
  [self.indicator stopAnimating];
  NSLog(@"%s",__func__);

}

@end
