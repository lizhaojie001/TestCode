//
//  DisplayView.m
//  Coretext
//
//  Created by Mac on 16/9/24.
//  Copyright © 2016年 HBNXWLKJ. All rights reserved.
//

#import "DisplayView.h"
#import  "CoreText/CoreText.h"
@implementation DisplayView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code

        [super drawRect:rect];

        // 步骤 1     得到当前绘制画布的上下文，用于后续将内容绘制在画布上。
        CGContextRef context = UIGraphicsGetCurrentContext();

        // 步骤 2    将坐标系上下翻转。对于底层的绘制引擎来说，屏幕的左下角是（0, 0）坐标。而对于上层的 UIKit 来说，左上角是 (0, 0) 坐标。所以我们为了之后的坐标系描述按 UIKit 来做，所以先在这里做一个坐标系的上下翻转操作。翻转之后，底层和上层的 (0, 0) 坐标就是重合的了。
        CGContextSetTextMatrix(context, CGAffineTransformIdentity);
        CGContextTranslateCTM(context, 0, self.bounds.size.height);
        CGContextScaleCTM(context, 1.0, -1.0);

        // 步骤 3
        CGMutablePathRef path = CGPathCreateMutable();
   //     CGPathAddRect(path, NULL, self.bounds);
    CGPathAddEllipseInRect(path, NULL, self.bounds);
        // 步骤 4
    NSAttributedString *attString = [[NSAttributedString alloc] initWithString:@"**Important**: Core Text is intended for developers who must do text layout and font handling at a low level, such as developers of layout engines. You should develop your app using a higher-level framework if possible—that is, use Text Kit in iOS \(see Text Programming Guide for iOS) or the Cocoa text system in OS X \(see a target=" " Cocoa Text Architecture Guide/a). Core Text is the technology underlying those text systems, so they share in its speed and efficiency. In addition, Text Kit and the Cocoa text system provide rich text editing, full-featured page layout engines, and other infrastructure that your app would otherwise need to provide if it used Core Text alone."];
        CTFramesetterRef framesetter =
        CTFramesetterCreateWithAttributedString((CFAttributedStringRef)attString);
        CTFrameRef frame =
        CTFramesetterCreateFrame(framesetter,
                                 CFRangeMake(0, [attString length]), path, NULL);

        // 步骤 5
        CTFrameDraw(frame, context);
        
        // 步骤 6
        CFRelease(frame);
        CFRelease(path);
        CFRelease(framesetter);
    }




@end
