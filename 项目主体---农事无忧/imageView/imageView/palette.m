//
//  palette.m
//  imageView
//
//  Created by Mac on 16/12/21.
//  Copyright © 2016年 HBNXWLKJ. All rights reserved.
//

#import "palette.h"

@implementation palette


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
     NSLog(@"%s",__func__);
    
     UIGraphicsBeginImageContext(rect.size);
     UIRectFill(rect);
    
}
 
- (void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx{
    NSLog(@"%s",__func__);
    [super drawLayer:layer inContext:ctx];
    
}
@end
