//
//  ViewController.m
//  imageView
//
//  Created by Mac on 16/12/16.
//  Copyright © 2016年 HBNXWLKJ. All rights reserved.
//

#import "ViewController.h"
#import <QuartzCore/QuartzCore.h>
@interface ViewController ()

@end

@implementation ViewController
#define kTextString "Hello From Quartz"
#define kTextStringLength strlen(kTextString)
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    UIImageView * imageView = [[UIImageView alloc]initWithImage:returnImage(@"123")];
    imageView.center = self.view.center;
    [imageView sizeToFit];
    [self.view addSubview:imageView];
}



UIImage * returnImage(NSString * str) {
        UIGraphicsBeginImageContextWithOptions(CGSizeMake(60,60), NO, 0);
    
    CGContextRef context =   UIGraphicsGetCurrentContext();
    
    CGContextSetRGBFillColor(context, 1.0, 1.0, 1.0, 1.0);
    CGContextSetRGBStrokeColor(context, 1.0, 0.0, 0.0, 1.0);
    
    // Some initial setup for our text drawing needs.
    // First, we will be doing our drawing in Helvetica-36pt with the MacRoman encoding.
    // This is an 8-bit encoding that can reference standard ASCII characters
    // and many common characters used in the Americas and Western Europe.
    CGContextSelectFont(context, "Helvetica", 36.0, kCGEncodingMacRoman);
    // Next we set the text matrix to flip our text upside down. We do this because the context itself
    // is flipped upside down relative to the expected orientation for drawing text (much like the case for drawing Images & PDF).
    CGContextSetTextMatrix(context, CGAffineTransformMakeScale(1.0, -1.0));
    // And now we actually draw some text. This screen will demonstrate the typical drawing modes used.
    CGContextSetTextDrawingMode(context, kCGTextFill);
    CGContextShowTextAtPoint(context, 10.0, 30.0, kTextString, kTextStringLength);
    CGContextSetTextDrawingMode(context, kCGTextStroke);
    CGContextShowTextAtPoint(context, 10.0, 70.0, kTextString, kTextStringLength);
    
    UIImage* im = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return im;
}
@end
