//
//  ZJTableViewController.m
//  农展物联网
//
//  Created by Mac on 17/2/6.
//  Copyright © 2017年 HBNXWLKJ. All rights reserved.
//

#import "ZJTableViewController.h"
#import "ZJMeController.h"
#import "ZJMapController.h"
#import "ZJSenceController.h"
#import "ZJNaviController.h"

@interface ZJTableViewController ()<UIScrollViewDelegate,UIGestureRecognizerDelegate>
/**button*/
@property (nonatomic,weak) UIButton * button;
@property (weak, nonatomic) IBOutlet UIButton *mapButton;
@property(nonatomic,strong) NSMutableArray<__kindof UIViewController *> *childViewControllers ;
/** 底部的所有内容 */
//@property (nonatomic, weak) UIScrollView *contentView;
@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *trailingToSuperView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomToSuperView;

@property (weak, nonatomic)   UIScrollView *contentView;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *Items;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightOfBottom;

@end

@implementation ZJTableViewController

-(void)viewDidLayoutSubviews{
    self.heightOfBottom.constant =ZJBottomHeight;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.mapButton .selected = YES;
    self.button = self.mapButton;
    //    //初始化自控制器
    [self setupChildVces];
    //设置底部scrollow
    [self setupContentView];
}
- (IBAction)selectBar:(UIButton *)sender {
    self.button.selected = NO;
    sender.selected=YES;
    self.button = sender;
    
    ZJlogFunction;
    //滚动
    CGPoint offset = self.contentView.contentOffset;
    
    offset.x = (sender.tag/20-1)*self.contentView.width;
    [self.contentView setContentOffset:offset animated:YES];
}


/**
 * 设置顶部的标签栏
 */
- (void)setupTitlesView
{
    //    UIButton *btn = [UIButton buttonWithType:UIButtonTypeContactAdd];
    //    btn.y = 64;
    //    [self.view addSubview:btn];
    
    // 标签栏整体
    UIView *titlesView = [[UIView alloc] init];
    //    titlesView.backgroundColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.5];
    //    titlesView.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.5];
    titlesView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
    titlesView.width = self.view.width;
    titlesView.height = 60;
    titlesView.y =self.view.height-60;
    [self.view addSubview:titlesView];
    
    // 内部的子标签
    NSArray *titles = @[@"全部全部", @"视频", @"声音", @"图片", @"段子"];
    CGFloat width = titlesView.width / titles.count;
    CGFloat height = titlesView.height;
    for (NSInteger i = 0; i<titles.count; i++) {
        UIButton *button = [[UIButton alloc] init];
        button.height = height;
        button.width = width;
        button.x = i * width;
        [button setTitle:titles[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        [button addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
        [titlesView addSubview:button];
    };
    
    
}


/**
 * 初始化子控制器
 */
- (void)setupChildVces
{
    ZJMapController * vc = [ZJMapController new];
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    ZJSenceController * Sence = [[ZJSenceController alloc]initWithCollectionViewLayout:layout];
    ZJNaviController * sence = [[ZJNaviController alloc]initWithRootViewController:Sence];
    
    UIStoryboard * storyBorad = [UIStoryboard  storyboardWithName:@"Main" bundle:nil];
    ZJMeController * me = [storyBorad instantiateViewControllerWithIdentifier:NSStringFromClass([ZJMeController class])];
    ZJNaviController *navi = [[ZJNaviController alloc]initWithRootViewController:me];
    ZJNaviController *Map = [[ZJNaviController alloc]initWithRootViewController:vc];
     [self.childViewControllers addObjectsFromArray:@[Map,sence,navi ]] ;
}
/**
 * 底部的scrollView
 */
- (void)setupContentView
{
    // 不要自动调整inset
    //self.automaticallyAdjustsScrollViewInsets = NO;
    
    UIScrollView *contentView = [[UIScrollView alloc] init];
    contentView.frame = ZJScreenBounds;
    contentView.bounces =NO;
    contentView.delegate = self;
    contentView.pagingEnabled = YES;
    
    [self.view insertSubview:contentView atIndex:0];
    contentView.contentSize = CGSizeMake(contentView.width * self.childViewControllers.count, 0);
    contentView.contentInset = UIEdgeInsetsMake(0, 0, ZJBottomHeight, 0);
    self.contentView = contentView;
    
    // 添加第一个控制器的view
    [self scrollViewDidEndScrollingAnimation:contentView];
}
#pragma mark - <UIScrollViewDelegate>
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    // 当前的索引
    NSInteger index = scrollView.contentOffset.x / scrollView.width;
    
    // 取出子控制器
    UIViewController *vc = self.childViewControllers[index];
    CGFloat X=scrollView.contentOffset.x;
    vc.view.x = X;
    vc.view.y = 0; // 设置控制器view的y值为0(默认是20)
    vc.view.height = scrollView.height; // 设置控制器view的height值为整个屏幕的高度(默认是比屏幕高度少个20)
    //    vc.view.width = scrollView.width;
    
    // 设置内边距
    // CGFloat bottom = self.tabBarController.tabBar.height;
    
    // vc.view.contentInset = UIEdgeInsetsMake(0, 0, bottom, 0);
    //    // 设置滚动条的内边距
    //    vc.view.scrollIndicatorInsets = vc.view.contentInset;
    [scrollView addSubview:vc.view];
    
    //发出通知 监控view的X
    NSDictionary * dic = @{ZJValueOfoffset: @(X)};
    
    [[NSNotificationCenter defaultCenter] postNotificationName:ZJValueOfoffset object:self userInfo:dic];
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self scrollViewDidEndScrollingAnimation:scrollView];
    
    // 点击按钮
    NSInteger index = scrollView.contentOffset.x / scrollView.width;
    [self selectBar:self.Items[index]];
    ZJlogFunction;
}



- (NSMutableArray<__kindof UIViewController *> *)childViewControllers  {
    if(_childViewControllers   == nil) {
        _childViewControllers   = [[NSMutableArray<__kindof UIViewController *> alloc] init];
    }
    return _childViewControllers ;
}
/**
 *  视图生命周期
 */
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getUerInfo:) name:ZJIsOrNotRootController object:nil];
    
}
- (void)getUerInfo:(NSNotification*)noti{
    NSDictionary * dic =noti.userInfo;
    NSInteger count = [dic[ZJIsOrNotRootController] integerValue];
    ZJLog(@"count--%li",(long)count);
    if (count>=1) {
        [UIView animateWithDuration:0.25 animations:^{
             self.bottomToSuperView.constant=-ZJBottomHeight;
        
        }];
        self.contentView.scrollEnabled =NO;
    }else{
        [UIView animateWithDuration:0.25 animations:^{
            self.bottomToSuperView.constant =0;
          

        }];
        self.contentView.scrollEnabled =YES;

           }
    ZJlogFunction;
    
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:ZJIsOrNotRootController object:nil];
}


@end
