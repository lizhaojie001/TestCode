//
//  nswyEditorViewController.m
//  nswy-1
//
//  Created by Mac on 16/12/2.
//  Copyright © 2016年 HBNXWLKJ. All rights reserved.
//

#import "nswyEditorViewController.h"
#import <WebKit/WebKit.h>
@interface nswyEditorViewController ()

@property (weak, nonatomic) IBOutlet WKWebView *webView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomLayoutConstraint;

@end

@implementation nswyEditorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"编辑器";
    self.webView.scrollView.bounces =NO;
    self.automaticallyAdjustsScrollViewInsets = NO;
    NSError * error ;

    NSString * path = [[NSBundle mainBundle] pathForResource:@"editor" ofType:@"html"];
    NSString * html = [[NSString alloc]initWithContentsOfFile:path encoding:NSUTF8StringEncoding error:&error];
    if (error) {
        ZJLog(@"%s",__func__);
        
        return  ;
    }
    [self.webView loadHTMLString:html baseURL:[[NSBundle mainBundle] bundleURL]];
    // 将WKWebView添加到当前View
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(show:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hide:) name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:UIKeyboardWillHideNotification object:nil];
    
}

-(void)viewDidLayoutSubviews{
  
}
- (void)show:(NSNotification*) notification{
    
    CGRect frame =  [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    CGFloat H = frame.size.height;
     [UIView animateWithDuration:0.5 animations:^{
         self.bottomLayoutConstraint.constant = H;
         
     }];
}

- (void)hide:(NSNotification*) notification{
  
    [UIView animateWithDuration:0.5 animations:^{
        self.bottomLayoutConstraint.constant = 0;
        
    }];

}
@end
