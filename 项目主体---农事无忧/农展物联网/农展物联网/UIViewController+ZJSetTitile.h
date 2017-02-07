//
//  UIViewController+ZJSetTitile.h
//  农展物联网
//
//  Created by Mac on 17/1/19.
//  Copyright © 2017年 HBNXWLKJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (ZJSetTitile)

-(void)zj_setTitle:(NSString *)title font:(CGFloat )size color:(UIColor *)color;

- (void)zj_setTip:(NSString*)tip;
@end
