//
//  ZJPopView.h
//  农展物联网
//
//  Created by Mac on 17/2/8.
//  Copyright © 2017年 HBNXWLKJ. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZJPopView;

@protocol ZJPopViewDelegate <NSObject>

@optional
- (void)ZJPopView:(ZJPopView*)ZJPopView didSelectedDetial:(UIButton *)button;

@end
@interface ZJPopView : UIWindow
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *detial;
@property (weak, nonatomic) IBOutlet UIImageView *imageVIew;

+ (instancetype)sharePopView;

/**代理*/
@property (nonatomic,weak) id<ZJPopViewDelegate> PopDelegate;

@end
