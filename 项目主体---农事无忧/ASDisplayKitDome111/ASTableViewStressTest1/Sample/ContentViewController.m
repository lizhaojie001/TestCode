//
//  ContentViewController.m
//  Sample
//
//  Created by Mac on 16/11/14.
//  Copyright © 2016年 Facebook. All rights reserved.
//

#import "ContentViewController.h"
#import <WebKit/WebKit.h>
#import "MJRefresh.h"
#import "CommentsTool.h"


#define ScreenWidth  [UIScreen mainScreen].bounds.size.width
#define Screenheight   [UIScreen mainScreen].bounds.size.height

@interface ContentViewController ()<WKNavigationDelegate,WKUIDelegate, CommentsToolDelegate>
/**<#注释#>*/
@property (nonatomic,strong) WKWebView * webView;
/**UIActivityIndicatorView * */
@property (nonatomic,strong) UIActivityIndicatorView *  indicator;
/**tableView*/
@property (nonatomic,strong) UITableView * tableView;
/**防止二次添加评论界面*/
@property (nonatomic,assign) NSInteger flag;
/**评论框*/
@property (nonatomic,strong) CommentsTool * commentsTool;

@end

@implementation ContentViewController

#pragma mark - <CommentsToolDelegate>
-(void)CommentTool:(CommentsTool *)CommentsTool didClickButton:(ZJButtonType)item{
  
}


-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    [self popup];
  return YES;
}

-(void)viewWillLayoutSubviews{
  
 self.commentsTool.frame = CGRectFromString(@"0,0,0,0");
}

- (void)viewDidLoad {
    [super viewDidLoad];
   NSLog(@"%s",__func__);
  
  
  
  //加载指示
  UIActivityIndicatorView * dicator = [[UIActivityIndicatorView alloc]initWithFrame:CGRectMake(0, 0, 50, 50)];
  dicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhite ;
  dicator.center = CGPointMake(self.view.center.x, self.view.center.y);
 // dicator.color= [UIColor redColor];
  self.indicator = dicator;
  
  [self.view addSubview:dicator];
  [self.indicator startAnimating];
  UIButton * button = [UIButton buttonWithType:UIButtonTypeSystem];
  button.frame =CGRectMake(0, 100, 50, 50);
  [button setBackgroundColor:[UIColor blueColor]];
  [button setImage:[[UIImage imageNamed:@"redheat"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateSelected];
  [ button setImage:[[UIImage imageNamed:@"心"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]forState:UIControlStateNormal];
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
  CGRect frame = CGRectMake(0, 0, ScreenWidth, Screenheight-33);
  self.webView = [[WKWebView alloc]initWithFrame:frame configuration:configuration];
  self.webView.scrollView.showsVerticalScrollIndicator =NO;
  self.webView.scrollView.contentInset = UIEdgeInsetsMake(64,0,
                                                           0, 0);
  
 
  
  UIView *signtureView = [[UIView alloc]initWithFrame:CGRectMake(0, -64, ScreenWidth, 64)];
  signtureView.backgroundColor = [UIColor redColor];
   [self.webView.scrollView addSubview:signtureView];
   self.webView.backgroundColor = [UIColor colorWithDisplayP3Red:176/255.0 green:176/255.0 blue:176/255.0 alpha:1];
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
 // [self.view addSubview:view];
  
   //添加上拉弹出评论界面
  
  MJRefreshAutoNormalFooter * footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(popup)];
  
  
  // Set title
  [footer setTitle:@"上拉加载评论" forState:MJRefreshStateIdle];
  [footer setTitle:@"加载中..." forState:MJRefreshStateRefreshing];
  //[footer setTitle:@"" forState:MJRefreshStateNoMoreData];
  NSLog(@"%s %u",__func__,self.webView.scrollView.mj_footer.hidden);
  // Set font
  footer.stateLabel.font = [UIFont systemFontOfSize:17];
  
  // Set textColor
  footer.stateLabel.textColor = [UIColor blueColor];
 // footer.userInteractionEnabled = NO;
//  footer.ignoredScrollViewContentInsetBottom = 33;
  self.webView.scrollView.mj_footer =footer;
 
 }
/**
 *  推出评论窗口
 */
-(void)popup{
  NSLog(@"%s",__func__);
  self.flag++;
  if (self.flag>1) {
    [self.webView.scrollView.mj_footer endRefreshing];

    return;
    
  }
  UITableView * view = [[UITableView alloc]initWithFrame:CGRectMake(0, Screenheight-33, ScreenWidth, 0)];
  //view.contentInset = UIEdgeInsetsMake(50, 0, 0, 0);
  
  view.backgroundColor = [UIColor redColor];
  
  MJRefreshNormalHeader * header = [MJRefreshNormalHeader  headerWithRefreshingTarget:self refreshingAction:@selector(pulldown)];
  [header setTitle:@"下拉加载资讯" forState:MJRefreshStateIdle];
  [header setTitle:@"下拉加载资讯" forState:MJRefreshStatePulling];
  [header setTitle:@"下拉加载资讯" forState:MJRefreshStateRefreshing];
  
  header.lastUpdatedTimeLabel.hidden =YES;
  header.pullingPercent = 0.1;
  header.automaticallyChangeAlpha = NO;
  
  view.mj_header =header;
   // Hide the time
     self.tableView = view;
  [self.view addSubview:self.tableView];
  MJWeakSelf;
  [UIView animateWithDuration:0.5 animations:^{
    
  weakSelf.tableView.frame = CGRectMake(0, 64, ScreenWidth,Screenheight-64-33  );
    
  } completion:^(BOOL finished) {
    
    NSLog(@"finished");
  }];
  
  
  
  [self.webView.scrollView.mj_footer endRefreshing];

}
-(void)back{
  [self dismissViewControllerAnimated:YES completion:nil];
}
/**
 *  下拉加载文章界面
 */
-(void)pulldown{
  MJWeakSelf;
  
  [UIView animateWithDuration:0.5 animations:^{
    weakSelf.tableView.frame =CGRectMake(0, Screenheight-33, ScreenWidth, 0);
  } completion:^(BOOL finished) {
    NSLog(@"完成");
    [weakSelf.tableView removeFromSuperview];
    self.flag=0;
  }];
  
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
  
  NSLog(@"%s %u",__func__,self.webView.scrollView.mj_footer.hidden);

}

- (CommentsTool *)commentsTool {
	if(_commentsTool == nil) {
    _commentsTool = [CommentsTool tool];
  //  CommentTool * window =[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([CommentTool class]) owner:nil options:nil].firstObject;
   // window.windowLevel =UIWindowLevelAlert;
   // _commentTool =window;
 
  }
	return _commentsTool;
}

@end
