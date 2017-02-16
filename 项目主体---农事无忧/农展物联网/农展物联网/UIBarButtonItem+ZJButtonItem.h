//
//  UIBarButtonItem+ZJButtonItem.h
//  农展物联网
//
//  Created by Mac on 17/2/9.
//  Copyright © 2017年 HBNXWLKJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (ZJButtonItem)
+ (instancetype)itemWithImage:(NSString *)image highImage:(NSString *)highImage title:(NSString *)title target:(id)target action:(SEL)action;
@end
