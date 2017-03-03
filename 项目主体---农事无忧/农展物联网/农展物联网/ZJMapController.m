//
//  ZJMapController.m
//  农展物联网
//
//  Created by Mac on 17/2/6.
//  Copyright © 2017年 HBNXWLKJ. All rights reserved.
//

#import "ZJMapController.h"

#import "NSString+ZJDeviceModelName.h"
#import "ZJPopView.h"
#import "ZJDisplayController.h"
#import "ZJPavilion.h"
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#import "MJExtension.h"

#endif

@interface ZJMapController ()<ZJPopViewDelegate,UIScrollViewDelegate,NSURLSessionTaskDelegate>
/**uiimageView*/
@property (nonatomic,weak) UIImageView * imageView;
/**横坐标集合*/
@property (nonatomic,strong) NSArray * Xs;
/**纵坐标集合*/
@property (nonatomic,strong) NSArray * Ys;

/**pop*/
@property (nonatomic,strong) ZJPopView * popView;

/**button*/
@property (nonatomic,weak)  UIButton * button;
@property (weak, nonatomic)  UIView *zoomView;

/**scrollView*/
@property (nonatomic,weak) UIScrollView * scrollView;


/**zoomScale*/
@property (nonatomic,assign) CGFloat zoomSclae;
/**上一次请求*/

/**<#注释#>*/
@property (nonatomic,weak) NSURLSessionDataTask * Task;


@property (nonatomic,weak) NSDictionary * parameters;

/**消息标记*/
@property (nonatomic,weak) NSNotification * notification;



@end
static NSString * reusedCell = @"Cell";
static CGFloat const offset  = 100.0;
@implementation ZJMapController




#pragma mark- 请求数据

-(void)getPavilion:(int)tag{
    [self hidenPopView];
    [SVProgressHUD dismiss];

    [SVProgressHUD showWithStatus:@"加载中....."];
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    NSMutableDictionary * parameters =[NSMutableDictionary dictionary];
    parameters[@"sid"] = @(tag);
   
    //    NSURL *url = [NSURL URLWithString:URL];
    //    NSString * str = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:nil];
    manager.responseSerializer.acceptableContentTypes =[NSSet setWithObjects:@"application/json", @"text/html", @"text/json", @"text/javascript",@"text/plain", nil]; //设置相应内容类型
    //     manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    //    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    ZJweakSelf;
    self.parameters = parameters;
    
    
  self.Task =   [manager POST:BaseIPA parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
    
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
    
        
        if (parameters !=weakSelf.parameters) {
            
            return ;
        }
        if ( [weakSelf.notification.userInfo[ZJValueOfoffset] doubleValue] ) {
          
            self.popView = nil;
           
            return;
        }
       
    
         //   self.popView.pavilion = nil;
            NSDictionary * dic = responseObject[@"rows"][0];
            ZJPavilion *pavilion = [[ZJPavilion alloc]init];
            pavilion  = [ZJPavilion mj_objectWithKeyValues:dic];
            
            weakSelf.popView.pavilion  =pavilion;
            [weakSelf showPopView];
           [SVProgressHUD dismiss];
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
          [SVProgressHUD dismiss];
        
    }];
    
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        if ([SVProgressHUD isVisible]) {
//            [SVProgressHUD dismiss];
//        }
//    });
}
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask
    didReceiveData:(NSData *)data{
    ZJlogFunction;
}
//放大
- (IBAction)zoomIn:(UIButton *)sender {
    self.zoomSclae+=0.2;
    if (self.zoomSclae>2.0) {
        self.zoomSclae-=0.2;
    }
    [self.scrollView setZoomScale:self.zoomSclae animated:YES];
    
}
//缩小
- (IBAction)zoomOut:(id)sender {
    self.zoomSclae-=0.2;
    if (self.zoomSclae<1.0) {
        self.zoomSclae+=0.2;
    }
    [self.scrollView setZoomScale:self.zoomSclae animated:YES];
}
#pragma mark- ScrollViewDelegate
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    
    // NSLog(@"viewForZoomingInScrollView");
    return  self.imageView;
    
}




-(void)viewDidLayoutSubviews{
    self.scrollView.frame =ZJScreenBounds;
    self.popView.frame =CGRectMake(0, ZJScreenBounds.size.height ,0, 0);
    self.zoomView.frame = CGRectMake(ZJScreenW-60, ZJScreenH-150, 40, 81);
    
}



- (void)setZoomBtn{
    UIView * view = [[NSBundle mainBundle] loadNibNamed:@"zoom" owner:self options:nil].firstObject;
    
    self.zoomView = view;
    [self.view addSubview:view];
    
    
    
}
- (void)setupScrollowView{
    UIScrollView *sc =[[UIScrollView alloc]init];
    sc.bounces =NO;
    sc.maximumZoomScale = 2.0;
    sc.minimumZoomScale = 1.0;
    sc.bouncesZoom = YES;
    sc.delegate = self;
    //添加图片
    
    // NSString * path = [[NSBundle mainBundle] pathForResource:@"map-" ofType:@"jpg"];
    
    UIImageView * imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"map-(1).jpg"]];
    //imageView.backgroundColor= ZJGreenColor;
    [imageView sizeToFit];
    imageView.userInteractionEnabled =YES;
    //   imageView.contentMode = UIViewContentModeScaleAspectFit;
    
    [sc addSubview:imageView];
    self.imageView = imageView;
    sc.backgroundColor = [UIColor blackColor];
    
    
    
    if (imageView.width<ZJScreenBounds.size.width) {
        imageView.width = ZJScreenBounds.size.width;
    }
    // imageView.centerX = sc.centerX;
    sc.contentSize = imageView.size;
    sc.contentInset = UIEdgeInsetsMake(0, 0,ZJBottomHeight, 0);
    self.scrollView = sc;
    [self.view addSubview:sc];
    
    //给imageview添加手势
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleTap:)];
    [imageView addGestureRecognizer:tap];
}
- (void)handleTap:(UITapGestureRecognizer *)sender
{
    if (sender.state == UIGestureRecognizerStateEnded)
    {
        [self.Task cancel];
        [self hidenPopView];
        self.button.selected =NO;
        self.button.size =CGSizeMake(30, 30);
     
        ZJlogFunction;
        
    }
}

/**
 *  设置点击button
 */
-(void)setupButton{
    CGSize size =CGSizeMake(30, 30);
    
    for (int i =0 ; i<31; i++) {
        
        UIButton * button1 = [UIButton buttonWithType:UIButtonTypeCustom];
        button1.size = size;
        button1.tag = i+1;
        //  button1.backgroundColor =ZJRomColor;
        [button1 setImage:[UIImage imageNamed:[NSString stringWithFormat:@"map%d",i+1]] forState:UIControlStateNormal];
        [button1 setImage:[UIImage imageNamed:[NSString stringWithFormat:@"map%d_selected",i+1] ]forState:UIControlStateSelected];
        CGFloat X= [self.Xs[i] doubleValue];
        CGFloat Y= [self.Ys[i] doubleValue];
        if ([[NSString deviceModelName] isEqualToString:iPhone7PlusGSM]|[[NSString deviceModelName] isEqualToString:iPhone7PlusCDMA]) {
            X=1.02*X;
            
        }
        button1.center =CGPointMake(X, Y);
        [button1 addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
        [self.imageView addSubview:button1];
        
    }
    
    
    
    
}

-(void)clickButton:(UIButton*)button{
    
 
    [self getPavilion:(int)button.tag];
    self.button.size =CGSizeMake(30, 30);
    self.button.selected =NO;
    
    button.size =CGSizeMake(40, 40 );
    button.selected = YES;
    
    ZJLog(@"%ld",(long)button.tag);
    
    ZJlogFunction;
    self.button = button;
    
    
    //通知
    //  [ZJMapController createLocalizedUserNotification];
    
}
//定时推送
+ (void)createLocalizedUserNotification{
    
    // 设置触发条件 UNNotificationTrigger
    UNTimeIntervalNotificationTrigger *timeTrigger = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:5.0f repeats:NO];
    
    // 创建通知内容 UNMutableNotificationContent, 注意不是 UNNotificationContent ,此对象为不可变对象。
    UNMutableNotificationContent *content = [[UNMutableNotificationContent alloc] init];
    content.title = @"温度异常";
    content.subtitle = [NSString stringWithFormat:@" "];
    content.body = @"警告!温度36度,超过设定最高温度";
    content.badge = @1;
    content.sound = [UNNotificationSound defaultSound];
    content.userInfo = @{@"key1":@"value1",@"key2":@"value2"};
    
    // 创建通知标示
    NSString *requestIdentifier = @"Dely.X.time";
    
    // 创建通知请求 UNNotificationRequest 将触发条件和通知内容添加到请求中
    UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:requestIdentifier content:content trigger:timeTrigger];
    
    UNUserNotificationCenter* center = [UNUserNotificationCenter currentNotificationCenter];
    // 将通知请求 add 到 UNUserNotificationCenter
    [center addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error) {
        if (!error) {
            NSLog(@"推送已添加成功 %@", requestIdentifier);
            //你自己的需求例如下面：
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"本地通知" message:@"成功添加推送" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
            [alert addAction:cancelAction];
            [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alert animated:YES completion:nil];
            //此处省略一万行需求。。。。
        }
    }];
    
}
-(void)showPopView{
    [UIView animateWithDuration:0.25 animations:^{
        self.popView.y = ZJScreenH-80;
        
    }];
    NSDictionary * dic = @{ZJValueOfPopViewY:@(self.popView.y), ZJPOPView:self.popView};
    [[NSNotificationCenter defaultCenter] postNotificationName:ZJValueOfPopViewY object:self userInfo:dic];

    
}
-(void)hidenPopView{
    
    [UIView animateWithDuration:0.25 animations:^{
        self.popView.y=    ZJScreenH;
    }];
    self.button.selected =NO;
    
    
}

- (NSArray *)Xs {
    if(_Xs == nil) {
        _Xs = @[@220,@182,@165,@175,@290,@151,@298,@191,@153,@198,
                @179,@192,@192,@178,@88,@120,@77,@77,@24,@90,
                @99,@93,@60,@45,@59,@233,@17,@17,@30,@146,
                @280];
    }
    return _Xs;
}

- (NSArray *)Ys {
    if(_Ys == nil) {
        _Ys = @[@46,@58,@234,@293,@280,@430,@469,@534,@579,@598,
                @723,@848,@930,@980,@1027,@1170,@1140,@1182,@1169,@1300,
                @1332,@1364,@1370,@1338,@1307,@1332,@1380,@1446,@1516,@1528,
                @1531];
    }
    return _Ys;
}

- (ZJPopView *)popView {
    if(_popView == nil) {
        _popView = [ZJPopView sharePopView];
        
        _popView.PopDelegate =self;
    }
    return _popView;
}

#pragma mark -ZJPopViewDelegate

- (void)ZJPopView:(ZJPopView *)ZJPopView didSelectedDetial:(UIButton *)button{
    [self hidenPopView];
    ZJDisplayController * display = [[ZJDisplayController alloc]init];
    display.pavilion = self.popView.pavilion;
    [self.navigationController pushViewController:display animated:YES];
    ZJlogFunction;
    
}
/**
 *  生命周期
 *
 *  @param animated <#animated description#>
 */

- (void)viewDidLoad {
    [super viewDidLoad];
    self.zoomSclae = 1.0;
    self.automaticallyAdjustsScrollViewInsets =NO;
    
    [self setupScrollowView];
    //设置坐标点点击事件
    [self setupButton];
    //设置放大缩小
    [self setZoomBtn];
    
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getOffsetSuccess:) name:ZJValueOfoffset object:nil];
    self.navigationController.navigationBarHidden = YES;
    ZJlogFunction;
    
}

-(BOOL)getOffsetSuccess:(NSNotification*)notification{
    CGFloat X = [notification.userInfo[ZJValueOfoffset] doubleValue];
   
    if (X!=0) {
         self.notification =notification;
        [self hidenPopView];
        self.button.selected = NO;
            [self.Task cancel];
        [SVProgressHUD dismiss];
        ZJlogFunction;
        return YES;
    }
      ZJLog(@"%f",X);
    return NO;
  
    
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:ZJValueOfoffset object:nil];
//    self.navigationController.navigationBar.hidden =NO;
     self.navigationController.navigationBarHidden = NO;
    //停止请求 ,
    
}



@end
