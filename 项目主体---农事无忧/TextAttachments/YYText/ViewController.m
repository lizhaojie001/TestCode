//
//  ViewController.m
//  YYText
//
//  Created by Mac on 16/11/4.
//  Copyright © 2016年 HBNXWLKJ. All rights reserved.
//
 
#import "ViewController.h"
#import <YYKit.h>
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIFont *font = [UIFont systemFontOfSize:16];

    NSMutableAttributedString * str = [[NSMutableAttributedString alloc]initWithString:@" 你不在我身边\n" attributes:@{NSFontAttributeName  :[ UIFont boldSystemFontOfSize:20]}];
    UIImage *image = [UIImage imageNamed:@"favicon"];
    NSLog(@"%@",NSStringFromCGSize(image.size));
     image = [UIImage imageWithCGImage:image.CGImage scale:20 orientation:UIImageOrientationUp];
    NSLog(@"%@",NSStringFromCGSize(image.size));

    
    NSMutableAttributedString * attachText = [NSMutableAttributedString attachmentStringWithContent:image contentMode:UIViewContentModeCenter attachmentSize:image.size alignToFont:font alignment:(YYTextVerticalAlignmentCenter)];
    [str appendAttributedString:attachText];
    [str appendString:@"  风花雪月  "];
    NSMutableAttributedString* str1=[[NSMutableAttributedString alloc]initWithString:@"作者" attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:12],NSForegroundColorAttributeName:[UIColor redColor]}];
   // [str appendAttributedString:str1];
    YYTextBorder * border = [YYTextBorder new];
    border.cornerRadius = 3;
    border.insets = UIEdgeInsetsMake(0,-5, 0, -5);
    border.strokeWidth = 1;
    border.strokeColor = str1.color;
    border.lineStyle = YYTextLineStyleSingle;
//    YYTextShadow *shadow = [YYTextShadow new];
//    shadow.color = [UIColor blueColor];
//    shadow.offset = CGSizeMake(0, 1);
//    shadow.radius = 5;
    str1.textBackgroundBorder = border;
    
    
//    str1.textShadow = shadow;    YYTextBorder *highlightBorder = border.copy;
//    highlightBorder.strokeWidth = 0;
//     highlightBorder.strokeColor = str1.color;
//     highlightBorder.fillColor = str1.color;
  
    
    YYTextHighlight *highlight = [YYTextHighlight new];
    [highlight setColor:[UIColor whiteColor]];
   // [highlight setBackgroundBorder:highlightBorder];
    __weak typeof(self) _self = self;

    highlight.tapAction = ^(UIView *containerView, NSAttributedString *text, NSRange range, CGRect rect) {
//        [_self showMessage:[NSString stringWithFormat:@"Tap: %@",[text.string substringWithRange:range]]];
        NSLog(@"+++++");
        
    };
    [attachText setTextHighlight:highlight range:attachText.rangeOfAll];    
    [str appendAttributedString:str1];
    
    [str  appendAttributedString:[self padding]];
    NSAttributedString* str2 = [[NSAttributedString alloc]initWithString:@"safhioasfafiopppppppppppppppppfafafa4f65a4f56a156ag4156ad1ga65sf1a65sf1a561fa56f1af651af" attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:20]}];
    [str appendAttributedString:str2];
    YYLabel *label = [YYLabel new];
    
    label.attributedText = str;
  
    label.width = self.view.width;
    label.height = self.view.height - (kiOS7Later ? 64 : 44);
    label.top = (kiOS7Later ? 64 : 0);
    label.textAlignment = NSTextAlignmentLeft;
    label.textVerticalAlignment = YYTextVerticalAlignmentTop;
    label.numberOfLines = 0;
    label.textContainerInset = UIEdgeInsetsMake(0, 10,
                                                0, 10);
    label.backgroundColor = [UIColor colorWithWhite:0.933 alpha:1.000];
    [self.view addSubview:label];
    
    
    
    
    
    // Do any additional setup after loading the view, typically from a nib.
}
- (NSAttributedString *)padding {
    NSMutableAttributedString *pad = [[NSMutableAttributedString alloc] initWithString:@"\n\n"];
    pad.font = [UIFont systemFontOfSize:4];
    return pad;
}

-(void)click{
    
    NSLog(@"----------");
}

@end
