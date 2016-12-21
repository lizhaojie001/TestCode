//
//  ManualLineBreaking.m
//  Coretext
//
//  Created by Mac on 16/12/20.
//  Copyright © 2016年 HBNXWLKJ. All rights reserved.
//

#import "ManualLineBreaking.h"
#import <CoreText/CoreText.h>
@implementation ManualLineBreaking


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    double width; CGContextRef context; CGPoint textPosition; CFAttributedStringRef attrString;
    // Initialize those variables.
     CFStringRef string = CFSTR("Hello, World! I know nothing in the world that has as much power as a word. Sometimes I write one, and I look at it, until it begins to shine.");
    //冲掉150字节后面的字符串
    width = 150.0;
    context = UIGraphicsGetCurrentContext();
    
    CGContextTranslateCTM(context, 0, self.frame.size.height);
    
    CGContextScaleCTM(context, 1.0, -1.0);
    
   //起始位置
    textPosition = CGPointMake(10.0, 50.0);
    //字形
    CFStringRef fontName =CFSTR(/*"Papyrus"*/"HanziPenSC-W3");
    
    CTFontRef  font =
    CTFontCreateWithName(fontName, 15, NULL);
    //笔调重描痕迹
    CGFloat number = 3.0;
    
    CFNumberRef strokeWidth = CFNumberCreate(kCFAllocatorDefault, kCFNumberCGFloatType, &number  );
    //笔调颜色重描痕迹
    CGColorSpaceRef space =   CGColorSpaceCreateDeviceRGB();
    CGFloat components[] = {1.0,0.0,0.0,0.8};
    CGColorRef color = CGColorCreate(space, components);
    // Controls vertical text positioning
    CGFloat superScriptnumber = -1.0;
    
    CFNumberRef superScript = CFNumberCreate(kCFAllocatorDefault, kCFNumberCGFloatType, &superScriptnumber  );
    //kCTUnderlineStyleAttributeName
    /**
     *    kCTUnderlineStyleNone           = 0x00,
     kCTUnderlineStyleSingle         = 0x01,
     kCTUnderlineStyleThick          = 0x02,
     kCTUnderlineStyleDouble         = 0x09
     */
    CGFloat UnderlineStylenumber =kCTUnderlinePatternDash| kCTUnderlineStyleDouble;
    
    CFNumberRef UnderlineStyle = CFNumberCreate(kCFAllocatorDefault, kCFNumberCGFloatType, &UnderlineStylenumber  );
    //kCTUnderlineColorAttributeName
    CGColorSpaceRef Underlinespace =   CGColorSpaceCreateDeviceRGB();
    CGFloat Underlinecomponents[] = {0.0,0.5,0.5,1};
    CGColorRef Underlinecolor = CGColorCreate(Underlinespace, Underlinecomponents);
    //kCTVerticalFormsAttributeName 文字方向
    CFBooleanRef t = kCFBooleanFalse;
    
 /*   //kCTGlyphInfoAttributeName  字形信息
    CFStringRef glyphName = CFSTR("lessequal");
    CFStringRef baseString = CFSTR("Hello");
    CFStringRef GlyphInfofontName =CFSTR("HanziPenSC-W3");
    
    CTFontRef  GlyphInfofont =
    CTFontCreateWithName(GlyphInfofontName, 30, NULL);
    CTGlyphInfoRef info = CTGlyphInfoCreateWithGlyphName(glyphName, GlyphInfofont, string);
  */
    CFStringRef keys[] = { kCTFontAttributeName,kCTStrokeWidthAttributeName ,kCTStrokeColorAttributeName,kCTSuperscriptAttributeName,kCTUnderlineColorAttributeName,kCTUnderlineStyleAttributeName,kCTVerticalFormsAttributeName/*,kCTGlyphInfoAttributeName*/ };
   
    CFTypeRef values[] = { font ,strokeWidth,color,superScript,Underlinecolor, UnderlineStyle  ,t/*,info*/};
    
    
    
    CFDictionaryRef attributes =
    
    CFDictionaryCreate(kCFAllocatorDefault,(const void**)&keys,
                       
                       (const void**)&values,sizeof(keys)/sizeof(keys[0]) ,
                       
                       &kCFTypeDictionaryKeyCallBacks,
                       
                       &kCFTypeDictionaryValueCallBacks);
    
   
    
      attrString =   CFAttributedStringCreate(kCFAllocatorDefault, string, attributes);
  
    // Create a typesetter using the attributed string.
    CTTypesetterRef typesetter = CTTypesetterCreateWithAttributedString(attrString);
    
    // Find a break for line from the beginning of the string to the given width.
    CFIndex start = 0;
    CFIndex count = CTTypesetterSuggestLineBreak(typesetter, start, width);
    
    // Use the returned character count (to the break) to create the line.
    CTLineRef line = CTTypesetterCreateLine(typesetter, CFRangeMake(start, count));
    
    // Get the offset needed to center the line.
    float flush = 0.5; // centered
    double penOffset = CTLineGetPenOffsetForFlush(line, flush, width);
    
    // Move the given text drawing position by the calculated offset and draw the line.
    CGContextSetTextPosition(context, textPosition.x + penOffset, textPosition.y);
    CTLineDraw(line, context);
    
    // Move the index beyond the line break.
    start += count;
        CGColorRelease(color);
    CGColorRelease(Underlinecolor);
    CGColorSpaceRelease(Underlinespace);
      CGColorSpaceRelease(space);
}


@end
