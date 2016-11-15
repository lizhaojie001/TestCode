//
//  ContentViewController.m
//  Sample
//
//  Created by Mac on 16/11/14.
//  Copyright © 2016年 Facebook. All rights reserved.
//

#import "ContentViewController.h"
#import <WebKit/WebKit.h>
@interface ContentViewController ()<WKNavigationDelegate>
/**<#注释#>*/
@property (nonatomic,strong) WKWebView * webView;

@end

@implementation ContentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
  
  NSString *documentsDirectory = [paths objectAtIndex:0]; 
  
  NSString *fileD = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@%@.html",self.content.ID,self.content.fcreatetime]];
  
  // JS发送POST的Flag，为真的时候会调用JS的POST方法（仅当第一次的时候加载本地JS）
   
  // 创建WKWebView
  self.webView = [[WKWebView alloc] initWithFrame:[UIScreen mainScreen].bounds];
  //设置代理
  self.webView.navigationDelegate = self;
  // 获取JS所在的路径
  NSString *path = [[NSBundle mainBundle] pathForResource:@"JSPOST" ofType:@"html"];
  // 获得html内容
  NSString *html = [[NSString alloc] initWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
  // 加载js
  [self.webView loadHTMLString:html baseURL:[[NSBundle mainBundle] bundleURL]];
  // 将WKWebView添加到当前View
  [self.view addSubview:self.webView];
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
