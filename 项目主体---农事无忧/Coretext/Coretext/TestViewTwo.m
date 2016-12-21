//
//  TestViewTwo.m
//  Coretext
//
//  Created by Mac on 16/12/19.
//  Copyright © 2016年 HBNXWLKJ. All rights reserved.
//

#import "TestViewTwo.h"
#import <CoreText/CoreText.h>
@implementation TestViewTwo


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    CFStringRef string = CFSTR("Hello, World! I know nothing in the world that has as much power as a word. Sometimes I write one, and I look at it, until it begins to shine.");
   
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(context, 0, self.frame.size.height);
    
     CGContextScaleCTM(context, 1.0, -1.0);

    // Initialize the string, font, and context
    
    CFStringRef fontName =CFSTR("Papyrus");
    
    CTFontRef  font =
    CTFontCreateWithName(fontName, 15, NULL);
    
    CFStringRef keys[] = { kCTFontAttributeName };
    
    
    CFTypeRef values[] = { font };
    
    
    
    CFDictionaryRef attributes =
    
    CFDictionaryCreate(kCFAllocatorDefault,(const void**)&keys,
                       
                     (const void**)&values, sizeof(keys) / sizeof(keys[0]),
                       
                       &kCFTypeDictionaryKeyCallBacks,

                       &kCFTypeDictionaryValueCallBacks);
    
    
    
    CFAttributedStringRef attrString =
    
    CFAttributedStringCreate(kCFAllocatorDefault, string, attributes);
    
    CFRelease(string);
    
    CFRelease(attributes);
 
    CTLineRef line = CTLineCreateWithAttributedString(attrString);
    
    // Set text position and draw the line into the graphics context
    
    CGContextSetTextPosition(context, 10, 10);
    
    CTLineDraw(line, context);
    
    CFRelease(line);
}


@end
