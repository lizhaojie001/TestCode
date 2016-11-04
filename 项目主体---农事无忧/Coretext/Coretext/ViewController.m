//
//  ViewController.m
//  Coretext
//
//  Created by Mac on 16/9/24.
//  Copyright © 2016年 HBNXWLKJ. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UILabel *lane = [[UILabel alloc]initWithFrame:CGRectMake(50, 50, 300, 200)];
    lane.numberOfLines =0;
    NSMutableAttributedString* str = [[NSMutableAttributedString alloc]initWithString:@"富文本的学习"];

    NSRange range = NSMakeRange(0, 3);
    //设置背景色

  [str addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:range];

    //设置字体
    
   [str addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"AppleGothic" size:20] range:range];
    //设置段落
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc]init];
    style.headIndent =10;
    style.alignment = NSTextAlignmentLeft;
    style.lineBreakMode = NSLineBreakByCharWrapping;
    style.baseWritingDirection =NSWritingDirectionRightToLeft;
    style.allowsDefaultTighteningForTruncation = YES;
    [str addAttribute:NSParagraphStyleAttributeName value:style range:range];

    //设置颜色
   // [str addAttribute:NSStrokeColorAttributeName value:[UIColor lightGrayColor] range:range];
    //设置下滑线
     [str addAttribute:NSUnderlineColorAttributeName value:[UIColor blueColor] range:range];
         // Do any additional setup after loading the view, typically from a nib.
    [str addAttribute:NSUnderlineStyleAttributeName
value:@(NSUnderlineStyleSingle)
range:range];
    //删除线
     [str addAttribute:NSStrikethroughStyleAttributeName value:@(NSUnderlinePatternSolid | NSUnderlineStyleSingle) range:range];
      [self.view addSubview:lane];
      lane.attributedText =str;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
