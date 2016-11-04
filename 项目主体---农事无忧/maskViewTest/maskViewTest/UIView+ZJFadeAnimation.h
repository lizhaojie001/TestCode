//
//  UIView+ZJFadeAnimation.h
//  maskViewTest
//
//  Created by Mac on 16/9/21.
//  Copyright © 2016年 HBNXWLKJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (ZJFadeAnimation)
#define  MAXDURATION 1.2
#define  MINDURATION .2
#define  MULTIPLED .25
/**image*/
@property (nonatomic,strong) UIImage * image;

/**是否停止*/
@property (nonatomic ) BOOL  stop;

/**轮播图片*/
@property (nonatomic,strong) NSArray * bannerImages;

/**contentView
*/
@property (nonatomic,strong) UIView * contentView;

/*!
 * @brief 视图是否隐藏
 */
@property (nonatomic, assign ) BOOL isFade;
/*!
 * @brief 是否处在动画中   未完善
 */
@property (nonatomic, assign ) BOOL isFading;
/*!
 * @brief 垂直方块个数。默认为3
 */
@property (nonatomic, assign) NSInteger verticalCount;
/*!
 * @brief 水平方块个数。默认为18
 */
@property (nonatomic, assign) NSInteger horizontalCount;
/*!
 * @brief 速度系数
 */
@property (nonatomic, assign) double ratio;
/*!
 * @brief 每个方块隐藏的动画时间0.05~0.3，默认为0.175
 */
@property (nonatomic, assign) NSTimeInterval fadeAnimationDuration;

- (void)configurateWithVerticalCount: (NSInteger)verticalCount horizontalCount: (NSInteger)horizontalCount ratio: (double)ratio duration: (NSTimeInterval)fadeAnimationDuration withContentView:(UIView*) contentView;

- (void)reverseWithComplete: (void(^)(void))complete  ;
- (void)animateFadeWithComplete: (void(^)(void))complete   ;
- (void)reverseWithoutAnimate;
- (void)animateFadeWithComplete:(void (^)(void))complete twoFoward:(BOOL)istwoFoward;
@end
