//
//  nswyCategaryHeaderCell.m
//  nswy-1
//
//  Created by Mac on 16/12/31.
//  Copyright © 2016年 HBNXWLKJ. All rights reserved.
//

#import "nswyCategaryHeaderCell.h"

@implementation nswyCategaryHeaderCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.label.backgroundColor = [UIColor colorWithRed:0.9 green:0.9 blue:0.8 alpha:1.0 ];
        self.label.textColor =[UIColor blackColor];
    }
    return self;
}

+(UIFont *)defaultFont{
    return [UIFont preferredFontForTextStyle:UIFontTextStyleHeadline];
}
@end
