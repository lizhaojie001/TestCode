//
//  ViewController.m
//  YYKitDome--TextAttribute 1
//
//  Created by Mac on 16/11/3.
//  Copyright © 2016年 HBNXWLKJ. All rights reserved.
//

#import "ViewController.h"
#import <YYKit.h>
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSMutableAttributedString * str = [NSMutableAttributedString new];
    
[str appendString:@"\n我是标题"];
    [str appendString:@"\n\n"];
    
    
    NSMutableAttributedString * text = [[NSMutableAttributedString alloc]initWithString:@"哈哈哈哈"];
    
    text.font = [UIFont boldSystemFontOfSize:50];
    
    text.color = [UIColor redColor];
    
    YYTextShadow  * shadow = [YYTextShadow new];
    shadow.color = [UIColor blueColor];
    shadow.radius = 3;
    
    text.textShadow =shadow;
    YYTextHighlight * highlight = [YYTextHighlight new];
    [highlight setColor:[UIColor yellowColor]];
    highlight.tapAction =^ (UIView *containerView, NSAttributedString *text, NSRange range, CGRect rect){
        [self showMessage:[text.string substringWithRange:range]];
    };
  [  text setTextHighlight:highlight range:text.rangeOfAll];
    
    
    
    [str appendAttributedString:text];
    str.font = [UIFont boldSystemFontOfSize:25];
    YYLabel * label = [YYLabel new];
    label.attributedText = str;
    label.width = self.view.width;
    label.height = self.view.height;
    label.numberOfLines = 0;
    label.textContainerInset = UIEdgeInsetsMake(10, 10, 10, 10);
    label.textAlignment = NSTextAlignmentLeft;
    label.textVerticalAlignment = YYTextVerticalAlignmentTop;
    label.backgroundColor = [UIColor redColor];
    
    [self.view addSubview:label];
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)showMessage:(NSString *)msg {
    CGFloat padding = 10;
    
    YYLabel *label = [YYLabel new];
    label.text = msg;
    label.font = [UIFont systemFontOfSize:16];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
    label.backgroundColor = [UIColor colorWithRed:0.033 green:0.685 blue:0.978 alpha:0.730];
    label.width = self.view.width;
    label.textContainerInset = UIEdgeInsetsMake(padding, padding, padding, padding);
    label.height = [msg heightForFont:label.font width:label.width] + 2 * padding;
    
    label.bottom = (kiOS7Later ? 64 : 0);
    [self.view addSubview:label];
    [UIView animateWithDuration:0.3 animations:^{
        label.top = (kiOS7Later ? 64 : 0);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.2 delay:2 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            label.bottom = (kiOS7Later ? 64 : 0);
        } completion:^(BOOL finished) {
            [label removeFromSuperview];
        }];
    }];
}

@end
