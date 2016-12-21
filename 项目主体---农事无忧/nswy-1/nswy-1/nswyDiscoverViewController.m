//
//  nswyDiscoverViewController.m
//  nswy-1
//
//  Created by Mac on 16/12/2.
//  Copyright © 2016年 HBNXWLKJ. All rights reserved.
//

#import "nswyDiscoverViewController.h"
#import "NewPagedFlowView.h"
#import "PGIndexBannerSubiew.h"
#import "nswyTopic.h"
#import "nswySegmentation.h"
#import "PYSearch.h"
#import "PYTempViewController.h"

@interface nswyDiscoverViewController ()<NewPagedFlowViewDelegate,NewPagedFlowViewDataSource,nswyTopicDelegate,nswySegmentationDelegate,PYSearchViewControllerDelegate>
/**滚动条数据源*/
@property (nonatomic,strong) NSMutableArray * imageArr;

@end

@implementation nswyDiscoverViewController

-(BOOL)prefersStatusBarHidden{
    return YES;
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    ZJlogFunction;
    ZJLog(@"%@",self.navigationController.navigationBar);
    self.navigationController.navigationBar.hidden =YES;
}


-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    ZJlogFunction;
    ZJLog(@"%@",self.navigationController.navigationBar);

}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden =NO;
}
- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.navigationController.accessibilityNavigationStyle = UIAccessibilityNavigationStyleSeparate;
    
    self.tableView.contentInset=UIEdgeInsetsMake(ZJScreenW  * 9 / 16 +80, 0, 0, 0);
    [self setUpTopicView];
    [self setupUI];
    // Do any additional setup after loading the view.
}


- (void)setUpTopicView{
    NSArray * arr = @[@"123",@"456",@"789",@"147",@"258",@"369",@"159",@"357"];
    nswyTopic * topic = [[nswyTopic alloc]initWithNumBer:arr];
    topic.topicDelegate = self;
    topic.frame = CGRectMake(0, -80, ZJScreenW, 0);
    [self.tableView addSubview:topic];
    
    
    
}
#pragma mark - nswyTopicDelegate

-(void)didClickItemWith:(UIButton *)button{
    ZJLog(@"点击第%ld个按钮专题",(long)button.tag);
}


#pragma mark - 头部滚动视图


- (void)setupUI {
    
    
    NewPagedFlowView *pageFlowView = [[NewPagedFlowView alloc] initWithFrame:CGRectMake(0,0, ZJScreenW, ZJScreenW  * 9 / 16 )];
    
    pageFlowView.backgroundColor = [UIColor whiteColor];
    pageFlowView.delegate = self;
    pageFlowView.dataSource = self;
    pageFlowView.minimumPageAlpha = 0.1;
    pageFlowView.minimumPageScale =1;
    pageFlowView.orientation = NewPagedFlowViewOrientationHorizontal;
    
    //提前告诉有多少页
    pageFlowView.orginPageCount = 5;
    
    pageFlowView.isOpenAutoScroll = YES;
    
    //初始化pageControl
    UIPageControl *pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, pageFlowView.frame.size.height  -20, ZJScreenW, 8)];
    pageFlowView.pageControl = pageControl;
    [pageFlowView addSubview:pageControl];
    
    /****************************
     使用导航控制器(UINavigationController)
     如果控制器中不存在UIScrollView或者继承自UIScrollView的UI控件
     请使用UIScrollView作为NewPagedFlowView的容器View,才会显示正常,如下
     *****************************/
    
    UIScrollView * scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, - ZJScreenW  * 9 / 16 -80, ZJScreenW, ( ZJScreenW   * 9 / 16) )];
    scrollView.backgroundColor = [UIColor redColor];
    [scrollView addSubview:pageFlowView];
    
    [pageFlowView reloadData];
    
    
    [self.tableView  addSubview: scrollView] ;
    
    
    
}

#pragma mrak-tableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 10;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
         cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.text = @"cell";
        cell.detailTextLabel.text = @"detail";
        cell.imageView.image = [UIImage imageNamed:@"消息.png"];
    }

  
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 60;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    nswySegmentation * seg = [nswySegmentation segmentation];
    seg.segmentationDelegate = self;
    return seg;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}
#pragma mark nswySegmentationDelegate

-(void)didClickSegmentationIndex:(NSInteger)index{
    ZJLog(@"index = %li",(long)index);
}

-(void)didClickSearchBtnfSegmentation{
    // 1.创建热门搜索
    NSArray *hotSeaches = @[@"Java", @"Python", @"Objective-C", @"Swift", @"C", @"C++", @"PHP", @"C#", @"Perl", @"Go", @"JavaScript", @"R", @"Ruby", @"MATLAB"];
    // 2. 创建控制器
    PYSearchViewController *searchViewController = [PYSearchViewController searchViewControllerWithHotSearches:hotSeaches searchBarPlaceholder:@"搜索编程语言" didSearchBlock:^(PYSearchViewController *searchViewController, UISearchBar *searchBar, NSString *searchText) {
        // 开始搜索执行以下代码
        // 如：跳转到指定控制器
        [searchViewController.navigationController pushViewController:[[PYTempViewController alloc] init] animated:YES];
    }];
    // 3. 设置风格
    // 选择热门搜索
    searchViewController.hotSearchStyle = PYHotSearchStyleColorfulTag; // 热门搜索风格根据选择
    searchViewController.searchHistoryStyle = PYHotSearchStyleDefault; // 搜索历史风格为default
    
    // 4. 设置代理
    searchViewController.delegate = self;
    // 5. 跳转到搜索控制器
 
    [self.navigationController pushViewController:searchViewController animated:YES];
    
    ZJlogFunction;
}

-(void)didClickFilterBtnfSegmentation{
    ZJlogFunction;
}

#pragma mark - PYSearchViewControllerDelegate
- (void)searchViewController:(PYSearchViewController *)searchViewController searchTextDidChange:(UISearchBar *)seachBar searchText:(NSString *)searchText
{
    if (searchText.length) { // 与搜索条件再搜索
        // 根据条件发送查询（这里模拟搜索）
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{ // 搜素完毕
            // 显示建议搜索结果
            NSMutableArray *searchSuggestionsM = [NSMutableArray array];
            for (int i = 0; i < arc4random_uniform(5) + 10; i++) {
                NSString *searchSuggestion = [NSString stringWithFormat:@"搜索建议 %d", i];
                [searchSuggestionsM addObject:searchSuggestion];
            }
            // 返回
            searchViewController.searchSuggestions = searchSuggestionsM;
        });
    }
}

#pragma mark NewPagedFlowView Delegate
- (CGSize)sizeForPageInFlowView:(NewPagedFlowView *)flowView {
    return CGSizeMake(ZJScreenW , ZJScreenW  * 9 / 16);
}

- (void)didSelectCell:(UIView *)subView withSubViewIndex:(NSInteger)subIndex {
    
    NSLog(@"点击了第%ld张图",(long)subIndex + 1);
    
    
}

#pragma mark NewPagedFlowView Datasource
- (NSInteger)numberOfPagesInFlowView:(NewPagedFlowView *)flowView {
    
    return self.imageArr.count;
    
}

- (UIView *)flowView:(NewPagedFlowView *)flowView cellForPageAtIndex:(NSInteger)index{
    PGIndexBannerSubiew *bannerView = (PGIndexBannerSubiew *)[flowView dequeueReusableCell];
    if (!bannerView) {
        bannerView = [[PGIndexBannerSubiew alloc] initWithFrame:CGRectMake(0, 0, ZJScreenW , ZJScreenW  * 9 / 16)];
        bannerView.layer.cornerRadius = 0;
        bannerView.layer.masksToBounds = YES;
    }
    //在这里下载网络图片
    //  [bannerView.mainImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:hostUrlsImg,imageDict[@"img"]]] placeholderImage:[UIImage imageNamed:@""]];
    bannerView.mainImageView.image = self.imageArr[index];
    
    return bannerView;
}

- (void)didScrollToPage:(NSInteger)pageNumber inFlowView:(NewPagedFlowView *)flowView {
    
    NSLog(@"ViewController 滚动到了第%ld页",(long)pageNumber);
}


- (NSMutableArray *)imageArr {
	if(_imageArr == nil) {
		_imageArr = [[NSMutableArray alloc] init];
        for (int index = 0; index < 5; index++) {
            UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"Yosemite0%d.jpg",index]];
            [_imageArr addObject:image];
        }

	}
	return _imageArr;
}

@end
