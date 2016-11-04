//
//  ViewController.m
//  UIimage
//
//  Created by Mac on 16/10/16.
//  Copyright © 2016年 HBNXWLKJ. All rights reserved.
//

#import "ViewController.h"
#import <ImageIO/ImageIO.h>
#import <MobileCoreServices/MobileCoreServices.h>
@interface ViewController ()

@end
/**
 *  imageWithname imageWithData
    png 无损 + 透明 jpg 有损+ 质量因子
 */
@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
//    UIImage * image = [UIImage imageNamed:@"103-160Q509544OC.jpg"];
//    UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
    [self decompositionGif];
    [self displayGif];
    self.view.backgroundColor = [UIColor lightGrayColor];
    
}

-(void)jpgTopng {

    UIImage * image = [UIImage imageNamed:@"123.jpg"];
    NSData *data = UIImagePNGRepresentation(image);
    UIImage * imagePng = [UIImage imageWithData:data];
    UIImageWriteToSavedPhotosAlbum(imagePng, nil, nil, nil);
}
- (void)jpgToJpg{
    UIImage * image = [UIImage imageNamed:@"123.jpg"];
    /**
     *  图片转换成数据
     *
     *  @param image 原始图片
     *  @param 0.4   质量因子
     *
     *  @return 
     */
    NSData * data = UIImageJPEGRepresentation(image, 0.4);
    UIImage *imageJpg = [UIImage imageWithData:data];
    UIImageWriteToSavedPhotosAlbum(imageJpg, nil, nil, nil);

    
    
}
/**
 *  gif
 */
/**
 *  1.拿到GIF 
    2.将gif图片分解(decomposition)
    3.将单帧转化为uiimage
    4.将图片保存
 */
- (void)decompositionGif{
   // 1.拿到GIF 
    NSString * pathSource= [[NSBundle mainBundle]pathForResource:@"123" ofType:@"gif"];
    NSData * data = [NSData dataWithContentsOfFile:pathSource];
    CGImageSourceRef source =CGImageSourceCreateWithData((__bridge CFDataRef) data, NULL);
//    2.将gif图片分解(decomposition)
    size_t count = CGImageSourceGetCount(source);
    NSMutableArray * tempArray = [NSMutableArray array];
    for (int i = 0; i < count; i ++) {
        CGImageRef imageCG = CGImageSourceCreateImageAtIndex(source, i, NULL);
        
        //    3.将单帧转化为uiimage
        UIImage * image = [UIImage imageWithCGImage:imageCG scale:[UIScreen mainScreen].scale orientation:UIImageOrientationUp];
        [tempArray addObject:image];
        CGImageRelease(imageCG);
    }
    CFRelease(source);

//    4.将图片保存
    int i =0;
    for (UIImage *image   in tempArray) {
        NSData * data = UIImagePNGRepresentation(image);
        NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString * gifpath = path.firstObject;
        NSString * pathNum = [gifpath stringByAppendingString:[NSString stringWithFormat:@"/%d.png",i]];
        i++;
        [data writeToFile:pathNum atomically:YES];
    }
}
/**
 *  gif展示
 */
- (void)displayGif{
    NSMutableArray * tempArray = [NSMutableArray array];
    UIImageView * iamgeView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 100, 400, 220)];
    [self.view addSubview:iamgeView];
    for (int i = 0; i < 12; i++) {
        UIImage * image = [UIImage imageNamed:[NSString stringWithFormat:@"%d",i]];
        [tempArray addObject:image];
    }
    [iamgeView setAnimationImages:tempArray];
    [iamgeView setAnimationDuration:2];
    [iamgeView setAnimationRepeatCount:10];
    [iamgeView startAnimating];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
