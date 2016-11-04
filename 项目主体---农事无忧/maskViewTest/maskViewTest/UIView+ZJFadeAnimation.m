//
//  UIView+ZJFadeAnimation.m
//  maskViewTest
//
//  Created by Mac on 16/9/21.
//  Copyright © 2016年 HBNXWLKJ. All rights reserved.
//

#import "UIView+ZJFadeAnimation.h"
#import <objc/runtime.h>

 
//在iOS中，在category中声明的所有属性编译器都不会自动绑定getter和setter方法，这意味着我们需要重写这两种方法，而且还不能使用下划线+变量名的方式直接访问变量。因此我们需要导入objc/runtime.h文件使用动态时提供的objc_associateObject机制来为视图动态增加属性:

@implementation UIView (ZJFadeAnimation)


- (void)reverseWithoutAnimate{

    if (self.isFading) {
        NSLog(@"It's animating!");
        return;
    }
    for (UIView * subview in self.maskView.subviews) {
        subview.alpha = 1;
    }
}


-(void)reverseWithComplete:(void (^)(void))complete  {
    NSLog(@"----------");

    long  a = self.horizontalCount*self.verticalCount;
    int b =0;
    for (NSInteger line = 0; line < self.horizontalCount; line ++) {
        for (NSInteger row = 0; row < self.verticalCount; row++) {
            NSInteger idx =a --;
            NSLog(@"%lD",(long)idx);
            UIView * fadeView = [self.contentView.maskView viewWithTag:idx];
            NSLog(@"%@",fadeView);
            NSLog(@"fadeVIew = %lu",fadeView.tag);
            double delay =self.fadeAnimationDuration*(b++)*0.5;
            [UIView animateWithDuration:self.fadeAnimationDuration delay:delay  options: UIViewAnimationOptionCurveLinear animations: ^{
                fadeView.alpha = 1;
            } completion: nil]; }
    }
            }

- (void)configurateWithVerticalCount:(NSInteger)verticalCount horizontalCount:(NSInteger)horizontalCount ratio:(double)ratio duration:(NSTimeInterval)fadeAnimationDuration withContentView:(UIView *)contentView{
    self.contentView =contentView;
    self.horizontalCount =horizontalCount;
    self.verticalCount = verticalCount;
    self.ratio = ratio;
    self.fadeAnimationDuration= fadeAnimationDuration;
    int a = 1;
   
    UIView * maskView = [[UIView alloc]initWithFrame:self.contentView.bounds];

    
    const CGFloat fadeWidth = CGRectGetWidth(maskView.frame) / horizontalCount;
    const CGFloat fadeHeight = CGRectGetHeight(maskView.frame) / verticalCount;

    for (NSInteger line = 0; line < horizontalCount; line ++) {
        for (NSInteger row = 0; row < verticalCount; row++) {

            CGRect frame = CGRectMake(line*fadeWidth, row*fadeHeight, fadeWidth, fadeHeight);
            UIView * fadeView = [[UIView alloc] initWithFrame: frame];
            fadeView.tag = a++;
            NSLog(@"fadeView.tag%lu",fadeView.tag);
            fadeView.backgroundColor = [UIColor whiteColor];
            [maskView addSubview: fadeView];
        }
    }
    self.contentView.maskView =maskView;


}

-(void)animateFadeWithComplete:(void (^)(void))complete  {
    int  a = 1;
    long fadeCount =self.verticalCount*self.horizontalCount;
    for (NSInteger line = 0; line < self.horizontalCount; line ++) {
        for (NSInteger row = 0; row < self.verticalCount; row++) {
            NSInteger idx =a ++;
            NSLog(@"%lD",(long)idx);
            UIView * fadeView = [self.contentView.maskView viewWithTag:idx];
            NSLog(@"fadeVIew = %lu",fadeView.tag);
            double delay =self.fadeAnimationDuration*idx*0.5;
            __block NSInteger timeCount =0;
        [UIView animateWithDuration:self.fadeAnimationDuration delay:delay usingSpringWithDamping:0.7 initialSpringVelocity:2.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                    
       
                fadeView.alpha = 0;
        } completion: ^(BOOL finished){
            if (++timeCount == fadeCount) {
                self.isFade =NO;
                self.isFading =NO;

                if (complete) {
                    complete();
            }



            }
        }]; }
                                 }
}
 
-(void)animateFadeWithComplete:(void (^)(void))complete  twoFoward:(BOOL)istwoFoward{

    if (istwoFoward) {


          int  a = 1;
    for (NSInteger line = 0; line < self.horizontalCount/2+1; line ++) {
        for (NSInteger row = 0; row < self.verticalCount; row++) {
            NSInteger idx =a ++;
            NSLog(@"%lD",(long)idx);
            UIView * fadeView = [self.contentView.maskView viewWithTag:idx];
            NSLog(@"fadeVIew = %lu",fadeView.tag);
            double delay =self.fadeAnimationDuration*idx*self.ratio;
            [UIView animateWithDuration:self.fadeAnimationDuration delay:delay  options: UIViewAnimationOptionCurveLinear animations: ^{
                fadeView.alpha = 0;
            } completion: nil]; }
    }

    long  a1 = self.horizontalCount*self.verticalCount;
    int b =0;
    for (NSInteger line = 0; line < self.horizontalCount/2; line ++) {
        for (NSInteger row = 0; row < self.verticalCount; row++) {
            NSInteger idx =a1 --;
            NSLog(@"%lD",(long)idx);
            UIView * fadeView = [self.contentView.maskView viewWithTag:idx];
            NSLog(@"%@",fadeView);
            NSLog(@"fadeVIew = %lu",fadeView.tag);
            double delay =self.fadeAnimationDuration*(b++)*self.ratio;
            [UIView animateWithDuration:self.fadeAnimationDuration delay:delay  options: UIViewAnimationOptionCurveLinear animations: ^{
                fadeView.alpha = 0;
            } completion: nil]; }
    }


        return;
    }
    [self reverseWithComplete:complete ];





}
static char * kTempImageKey;
// 获取动态绑定临时展示的UIImageView
- (UIImageView *)associateTempBannerWithImage: (UIImage *)image
{
    UIImageView * tempBanner = objc_getAssociatedObject(self, kTempImageKey);
    if (!tempBanner) {
        tempBanner = [[UIImageView alloc] initWithFrame: self.frame];
        objc_setAssociatedObject(self, kTempImageKey, tempBanner, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        [self.superview insertSubview: tempBanner belowSubview: self];
    }
    tempBanner.image = image;
    return tempBanner;
}
static char * kPageControlKey;
- (void)associatePageControlWithCurrentIdx: (NSInteger)idx
{
    UIPageControl * pageControl = objc_getAssociatedObject(self, kPageControlKey);
    if (!pageControl) {
        pageControl = [[UIPageControl alloc] initWithFrame: CGRectMake(self.frame.origin.x, CGRectGetHeight(self.frame) - 37 + self.frame.origin.y, CGRectGetWidth(self.frame), 37)];
        [self.superview addSubview: pageControl];
        pageControl.numberOfPages = self.bannerImages.count;
        objc_setAssociatedObject(self, kPageControlKey, pageControl, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    pageControl.currentPage = idx;
}
static char *kCompleteBlockKey;
- (void)fadeBanner{
NSParameterAssert(self.superview);
UIImageView * tempBanner = [self associateTempBannerWithImage: [UIImage imageNamed: self.bannerImages[1]]];
   self.stop = NO;
__block NSInteger idx = 0;
__weak typeof(self) weakSelf = self;
[self associatePageControlWithCurrentIdx: idx];

void (^complete)() = ^{
    NSInteger updateIndex = [weakSelf updateImageWithCurrentIndex: ++idx tempBanner: tempBanner];
    idx = updateIndex;
    [weakSelf associatePageControlWithCurrentIdx: idx];
};
// 保存block并执行动画
objc_setAssociatedObject(self, kCompleteBlockKey, complete, OBJC_ASSOCIATION_COPY_NONATOMIC);
[self animateFadeWithComplete: ^{
    if (!self.stop) {
        complete();
    }
}];
}

// 更新展示的图片，并且返回下一次要展示的图片下标
- (NSInteger)updateImageWithCurrentIndex: (NSInteger)idx tempBanner: (UIImageView *)tempBanner
{
    if (idx >= self.bannerImages.count) { idx = 0; }
    self.image = [UIImage imageNamed: self.bannerImages[idx]];
    [self reverseWithoutAnimate];
    NSInteger nextIdx = idx + 1;
    if (nextIdx >= self.bannerImages.count) { nextIdx = 0; }
    tempBanner.image = [UIImage imageNamed: self.bannerImages[nextIdx]];
    [self animateFadeWithComplete: ^{
        if (!self.stop) {
            void (^complete)() = objc_getAssociatedObject(self, kCompleteBlockKey);
            complete();
        }
    }];
    return idx;
}

static char ZJImageKey;
- (UIImage *)image{
    return  objc_getAssociatedObject( self, &ZJImageKey);
}
- (void)setImage:(UIImage *)image{

    objc_setAssociatedObject(self, &ZJImageKey, (UIImage*)image, OBJC_ASSOCIATION_RETAIN);
}
static char ZJStopKey;
- (BOOL)stop{
    return [objc_getAssociatedObject(self, &ZJStopKey) boolValue];
}
-(void)setStop:(BOOL)stop{
    return objc_setAssociatedObject(self, &ZJStopKey, @(stop), OBJC_ASSOCIATION_ASSIGN);
}
static char ZJcontentView;

-(UIView *)contentView{
    NSLog(@"%@++++++++++", objc_getAssociatedObject(self, &ZJcontentView) );
    return  objc_getAssociatedObject(self, &ZJcontentView)  ;

}
static char ZJRatio;
- (double)ratio
{
    return [objc_getAssociatedObject(self, &ZJRatio) doubleValue];
}


static char kIsFadeKey;
- (BOOL)isFade
{
    return [objc_getAssociatedObject(self, &kIsFadeKey) boolValue];
}
// other getAssociatedObject method
static char ZJHorizontalCount;
- (NSInteger)horizontalCount{
    return [objc_getAssociatedObject(self, &ZJHorizontalCount) integerValue];
}
static char ZJIntervalDuration;
- (NSTimeInterval)intervalDuration{
    return [objc_getAssociatedObject(self, &ZJIntervalDuration) doubleValue];
    
}
static char ZJVerticalCount
;
- (NSInteger)verticalCount{
    return [objc_getAssociatedObject(self, &ZJVerticalCount ) integerValue];
}
static char ZJIsFading;
- (BOOL)isFading{
    return [objc_getAssociatedObject(self, &ZJIsFading) boolValue];
}

static char ZJFadeAnimationDuration;
- (NSTimeInterval)fadeAnimationDuration{
    return [objc_getAssociatedObject( self, &ZJFadeAnimationDuration) doubleValue];
}



// other setAssociatedObject method
- (void)setContentView:(UIView *)contentView{
    NSLog(@"%@----------",contentView);
    objc_setAssociatedObject(self, &ZJcontentView, (UIView*)contentView, OBJC_ASSOCIATION_RETAIN);
    
}
- (void)setRatio:(double)ratio{
    objc_setAssociatedObject(self, &ZJRatio, @(ratio), OBJC_ASSOCIATION_ASSIGN);
}
- (void)setFadeAnimationDuration:(NSTimeInterval)fadeAnimationDuration{
    if (!fadeAnimationDuration) {
        fadeAnimationDuration =0.175;
    }
    if (fadeAnimationDuration>0.05 &&fadeAnimationDuration < 0.3) {
objc_setAssociatedObject(self, &ZJFadeAnimationDuration, @(fadeAnimationDuration), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }

}
- (void)setIsFading:(BOOL)isFading{
    objc_setAssociatedObject(self, &ZJIsFading, @(isFading), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
-(void)setVerticalCount:(NSInteger)verticalCount{
    if (!verticalCount) {
        verticalCount = 3;
    }
    objc_setAssociatedObject(self, &ZJVerticalCount, @(verticalCount), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setIntervalDuration:(NSTimeInterval)intervalDuration{
    if (!intervalDuration) {
        intervalDuration = 0.7;
    }
    if (intervalDuration>MINDURATION && intervalDuration < MAXDURATION) {
  objc_setAssociatedObject(self, &ZJIntervalDuration, @(intervalDuration), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }

}

- (void)setIsFade: (BOOL)isFade
{
    objc_setAssociatedObject(self, &kIsFadeKey, @(isFade), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (void)setHorizontalCount:(NSInteger)horizontalCount{
    if (!horizontalCount) {
        horizontalCount = 18;
    }
    objc_setAssociatedObject(self, &ZJHorizontalCount, @(horizontalCount), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
