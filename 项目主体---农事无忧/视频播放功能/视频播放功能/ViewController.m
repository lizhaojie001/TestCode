//
//  ViewController.m
//  视频播放功能
//
//  Created by Mac on 16/11/3.
//  Copyright © 2016年 HBNXWLKJ. All rights reserved.
//

#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <AVKit/AVKit.h>
#import <MediaPlayer/MediaPlayer.h>
 #define version [[UIDevice currentDevice].systemVersion  doubleValue]
@interface ViewController ()
/**AVPlayer*/
@property (nonatomic,strong) AVPlayer * player;

@end

@implementation ViewController
-(UIImage *)FirstImage{
    NSURL *videoURL = [NSURL URLWithString:@"http://v1.mukewang.com/a45016f4-08d6-4277-abe6-bcfd5244c201/L.mp4"];
    
    AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:videoURL options:nil];
    NSParameterAssert(asset);
    AVAssetImageGenerator *assetImageGenerator = [[AVAssetImageGenerator alloc] initWithAsset:asset];
    assetImageGenerator.appliesPreferredTrackTransform = YES;
    assetImageGenerator.apertureMode = AVAssetImageGeneratorApertureModeEncodedPixels;
         CGImageRef thumbnailImageRef = NULL;  
    CFTimeInterval thumbnailImageTime = 0;  
    NSError *thumbnailImageGenerationError = nil;  
    thumbnailImageRef = [assetImageGenerator copyCGImageAtTime:CMTimeMake(thumbnailImageTime, 15) actualTime:NULL error:&thumbnailImageGenerationError];  
    
    
    if (!thumbnailImageRef)  
        NSLog(@"thumbnailImageGenerationError %@", thumbnailImageGenerationError);  
    
    UIImage *thumbnailImage = thumbnailImageRef ?  [[UIImage alloc] initWithCGImage:thumbnailImageRef]   : nil;  
    //NSData *imageData = UIImagePNGRepresentation(thumbnailImage);
    CGImageRelease(thumbnailImageRef);
    return thumbnailImage;

}
- (void)viewDidLoad {
    [super viewDidLoad];
    
     
    UIImageView * imageView =[[ UIImageView alloc]initWithImage:[self FirstImage]];
    imageView.userInteractionEnabled =YES;
    
    imageView.frame = CGRectMake(50, 200, 300, 200);
    imageView.contentMode = UIViewContentModeScaleToFill;
    
    
    
    UIButton * buton = [UIButton buttonWithType:UIButtonTypeCustom];
    CGSize size = imageView.bounds.size;
    [buton setFrame:CGRectMake(0, 0, 40, 40   )];
    [buton setCenter:CGPointMake(size.width/2.0, size.height/2.0)];
    [buton setImage:[UIImage imageNamed:@"播放"] forState:UIControlStateNormal];
    [buton setImage:[UIImage imageNamed:@"暂停"] forState:UIControlStateHighlighted];
    
    
    [buton addTarget:self action:@selector(play:) forControlEvents:UIControlEventTouchUpInside];
    [imageView addSubview:buton];
    
    
    
    
    UITapGestureRecognizer * ge = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(play:)];
    ge.numberOfTapsRequired = 1;
    [imageView addGestureRecognizer:ge];
    
    
    [self.view addSubview:imageView];
    
    
    // Do any additional setup after loading the view, typically from a nib.
    //[self.player play];
}
- (void)play:(UIButton*)sender {
    
    AVPlayerViewController *pa = [[AVPlayerViewController alloc]init];
    
    pa.player  = self.player;
    
//    
//    CATransition * animation = [CATransition animation];
//   
//    animation.duration = 0.5;    //  时间
//    
//    /**  type：动画类型
//     *  pageCurl       向上翻一页
//     *  pageUnCurl     向下翻一页
//     *  rippleEffect   水滴
//     *  suckEffect     收缩
//     *  cube           方块
//     *  oglFlip        上下翻转
//     */
//    animation.type = @"pageCurl";
//    
//    /**  type：页面转换类型
//     *  kCATransitionFade       淡出
//     *  kCATransitionMoveIn     覆盖
//     *  kCATransitionReveal     底部显示
//     *  kCATransitionPush       推出
//     */
//    animation.type = kCATransitionPush;
//    
//    //PS：type 更多效果请 搜索： CATransition
//    
//    /**  subtype：出现的方向
//     *  kCATransitionFromRight       右
//     *  kCATransitionFromLeft        左
//     *  kCATransitionFromTop         上
//     *  kCATransitionFromBottom      下
//     */
//    animation.subtype = kCATransitionFromTop;
//    
//    [self.view.window.layer addAnimation:animation forKey:nil];  
    
    
   
    if (version<9.0) {
        
        
        NSString *urlStr = @"http://v1.mukewang.com/a45016f4-08d6-4277-abe6-bcfd5244c201/L.mp4";  
        urlStr = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];  
        NSURL *url1 = [NSURL URLWithString:urlStr];  
    MPMoviePlayerController *movie_Player = [[MPMoviePlayerController alloc]initWithContentURL:url1];  
    //movieName 是视频名，mp4是视频格式，此处也可以是其他IPHONE支持的格式
    
    
    movie_Player.scalingMode = MPMovieScalingModeAspectFit;
        movie_Player.controlStyle = MPMovieControlStyleDefault;
        
        movie_Player.view.frame = self.view.bounds;
        [self.view addSubview:movie_Player.view];
     
    [self.view setBackgroundColor:[UIColor clearColor]];
    
    [movie_Player prepareToPlay];    
    [movie_Player play];

    }else{
 
    
   /*
        UIModalTransitionStyleCoverVertical = 0, 垂直覆盖
        UIModalTransitionStyleFlipHorizontal __TVOS_PROHIBITED,水平翻转
        UIModalTransitionStyleCrossDissolve, 及时替换
        UIModalTransitionStylePartialCurl NS_ENUM_AVAILABLE_IOS(3_2) __TVOS_PROHIBITED,翻页效果
    */

    
    pa.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    //pa.modalPresentationStyle = UIModalPresentationOverFullScreen;
    
    [self presentViewController:pa animated:YES completion:nil];
     }
    
    
    
}
- (void)pause:(id)sender {
    [self.player pause];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (AVPlayer *)player
{
    if (_player == nil) {
        // 1.获取URL(远程/本地)
        // NSURL *url = [[NSBundle mainBundle] URLForResource:@"01-知识回顾.mp4" withExtension:nil];
        NSURL *url = [NSURL URLWithString:@"http://v1.mukewang.com/a45016f4-08d6-4277-abe6-bcfd5244c201/L.mp4"];
        
        // 2.创建AVPlayerItem
        AVPlayerItem *item = [AVPlayerItem playerItemWithURL:url];
        
        // 3.创建AVPlayer
        _player = [AVPlayer playerWithPlayerItem:item];
        
        // 4.添加AVPlayerLayer
       // AVPlayerLayer *layer = [AVPlayerLayer playerLayerWithPlayer:self.player];
       // layer.frame = CGRectMake(0, 200, self.view.bounds.size.width, self.view.bounds.size.width * 9 / 16);
        //[self.view.layer addSublayer:layer];
    }
    return _player;
}
@end
