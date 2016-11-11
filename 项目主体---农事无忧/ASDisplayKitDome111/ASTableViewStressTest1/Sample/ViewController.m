//
//  ViewController.m
//  Sample
//
//  Copyright (c) 2014-present, Facebook, Inc.  All rights reserved.
//  This source code is licensed under the BSD-style license found in the
//  LICENSE file in the root directory of this source tree. An additional grant
//  of patent rights can be found in the PATENTS file in the same directory.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
//  FACEBOOK BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
//  ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
//  CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
//

#import "ViewController.h"

#import <AsyncDisplayKit/AsyncDisplayKit.h>
#import <AsyncDisplayKit/ASAssert.h>
#import "NXTATableViewCell.h"
#import "YYFPSLabel.h"
#import "NewPagedFlowView.h"
#import "PGIndexBannerSubiew.h"
#import <AFNetworking.h>
#import "DataModels.h"
#import "SVProgressHUD.h"
#import "NSWYPageNumModel.h"
#import "NSWYContent.h"
#import "MJExtension.h"
#import "author.h"
#import "MJRefresh.h"

#define Width  [UIScreen mainScreen].bounds.size.width
#define Height  [UIScreen mainScreen].bounds.size.height
#define RandomColor  [UIColor colorWithRed:arc4random()%255/255.0 green:arc4random()%255/255.0 blue:arc4random()%255/255.0 alpha:1]
#define URL   @"http://123.85.2.102:8089/nswy-space/a/consultinfo/nswyConsultinfo/ws/look"
typedef enum : NSUInteger {
  ReloadData,
  ReloadRows,
  ReloadSections,
  ReloadTypeMax
} ReloadType;

@interface ViewController () <ASTableViewDataSource, ASTableViewDelegate,NewPagedFlowViewDelegate,NewPagedFlowViewDataSource>
{
 
  NSMutableArray *_sections; // Contains arrays of indexPaths representing rows
  YYFPSLabel * _fpsLabel;
}
/** ASTableView *_tableView;*/
@property (nonatomic,strong) ASTableView * tableView;

 
/**imageArray*/
@property (nonatomic,strong) NSMutableArray * imageArray;
/**ScorllView视图*/
@property (nonatomic,strong) UIScrollView * Sview;

/**数据源*/
@property (nonatomic,strong) NSWYPageNumModel * homeModel;
/**NSWYContent*/
/**数据*/
@property (nonatomic,strong) NSMutableArray * contentArr;

/**评论数*/
@property (nonatomic,strong) NSMutableArray  * total;

/**currentpage*/
@property (nonatomic,assign) NSInteger  page;

@end


@implementation ViewController

- (instancetype)init
{
  if ( self = [super init] )
  {
    
    _Sview = [[UIScrollView alloc]initWithFrame:CGRectZero];
    
    
   _tableView = [[ASTableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
  _tableView.asyncDataSource = self;
  _tableView.asyncDelegate = self;
  _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
  
  }

  return self;
}

- (void)viewDidLoad
{
  [super viewDidLoad];
  
  [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeGradient];
  [SVProgressHUD show];
  //模拟网络延迟
  dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    params[@"pageNum"] = @1;
    params[@"number"] = @10;
    self.page=1;
    
    [[AFHTTPSessionManager manager] GET:URL parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
      
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSWYPageNumModel * model = [NSWYPageNumModel new];
  
      [model mj_setKeyValues:responseObject ];
      self.homeModel = model;
      for (int i =0 ; i<model.content.count; i++) {
        NSWYContent * content = [NSWYContent new];
        [content mj_setKeyValues:model.content[i]];
        [self.contentArr addObject:content];
      }   
      
      [_tableView reloadData];

                [self setTableView];
         [SVProgressHUD dismiss];
            
     
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
      [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"%@" ,error]] ;
    }];
    
  });


}

- (void)setTableView{
  
  [self.view addSubview:_tableView];
  
  
  _fpsLabel = [[YYFPSLabel alloc]initWithFrame:CGRectMake(0, 100, 50, 50)];
  
  [_fpsLabel sizeToFit];
  // _fpsLabel.alpha = 0;
  _fpsLabel.backgroundColor = [UIColor whiteColor];
  [self.view addSubview:_fpsLabel];
  
  _tableView.contentInset = UIEdgeInsetsMake(((Width - 84) * 9 / 16 + 24), 0, 0, 0);
  
  for (int index = 0; index < 5; index++) {
    UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"Yosemite0%d.jpg",index]];
    [self.imageArray addObject:image];
  }
  
  [self setupUI];
  [self setupRefresh];

  
}
#pragma mark 刷新控件
/**
 *  刷新控件
 */
-(void)setupRefresh{
  _tableView.mj_header.frame =CGRectMake(0, -((Width - 84) * 9 / 16 + 24+20), self.view.frame.size.width, self.view.frame.size.height);
  _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshNews)];
  
  _tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
  
  _tableView.mj_footer.hidden =YES;
}
-(void)refreshNews{
  
  //?pageNum=1&number=20
  NSMutableDictionary *params = [NSMutableDictionary dictionary];
  
 // params[@"pageNum"] = @();
  params[@"number"] = @20;
  [[AFHTTPSessionManager manager] GET:URL parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
    
  } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
    
  } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    
  }];
  
   
 

 


}
- (void)loadMoreData{
   
  NSMutableDictionary *params = [NSMutableDictionary dictionary];
  
  params[@"pageNum"] = @(++self.page) ;
  params[@"number"] = @20;
  [[AFHTTPSessionManager manager] GET:URL parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
    
  } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
    NSWYPageNumModel * model = [NSWYPageNumModel new];
     NSIndexPath *indexpath = [NSIndexPath indexPathForRow:self.contentArr.count-2   inSection:([_tableView numberOfSections]-1)];
                 
                               
    [model mj_setKeyValues:responseObject ];
    self.homeModel = model;
    for (int i =0 ; i<model.content.count; i++) {
      NSWYContent * content = [NSWYContent new];
      [content mj_setKeyValues:model.content[i]];
      [self.contentArr addObject:content];
      NSLog(@"%lu",(unsigned long)self.contentArr.count);
         }   
 
    [_tableView reloadDataWithCompletion:^{
     
      
      [_tableView scrollToRowAtIndexPath:indexpath atScrollPosition:UITableViewScrollPositionMiddle animated:NO];
 

    }];
    
      
       if ((int)self.contentArr.count == (int)model.total) {
      [_tableView.mj_footer endRefreshingWithNoMoreData];
    }else{

    [_tableView.mj_footer endRefreshing];
    }
  } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    
  }];

  
  
}

/**
 *  解析评论
 *
 *  @param model 获取评论数目
 */
-(void)parseComment:(NSWYPageNumModel*)model{
  for (int i =0; i<model.content.count  ; i++) 
  {
    
    NSWYContent * content = [NSWYContent new];
    [content mj_setKeyValues:model.content[i]];
    
    
    
    
    NSString * url = [NSString stringWithFormat:@"http://123.85.2.102:8089/nswy-space/a/consultinfo/nswyConsultinfo/ws/look?id=%@",content.ID];
    [[AFHTTPSessionManager manager] GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
      
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
      NSWYPageNumModel * model = [NSWYPageNumModel new];
      [model mj_setKeyValues:responseObject];
      
      [self.total addObject: [NSString stringWithFormat:@"%0.0f" ,model.commentPage.count ]];
      
      
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
      
    }];
    [self.contentArr addObject:content];
  }
}


/**
 *  头部滚动视图
 */

- (void)setupUI {
  
  
  NewPagedFlowView *pageFlowView = [[NewPagedFlowView alloc] initWithFrame:CGRectMake(0,-(( Width - 84) * 9 / 16 + 24), Width, (Width - 84) * 9 / 16 + 24)];
  
  pageFlowView.backgroundColor = [UIColor whiteColor];
  pageFlowView.delegate = self;
  pageFlowView.dataSource = self;
  pageFlowView.minimumPageAlpha = 0.1;
  pageFlowView.minimumPageScale = 0.85;
  pageFlowView.orientation = NewPagedFlowViewOrientationHorizontal;
  
  //提前告诉有多少页
   pageFlowView.orginPageCount = self.imageArray.count;
  
  pageFlowView.isOpenAutoScroll = YES;
  
  //初始化pageControl
  UIPageControl *pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, pageFlowView.frame.size.height - 24 - 8, Width, 8)];
  pageFlowView.pageControl = pageControl;
  [pageFlowView addSubview:pageControl];
  
  /****************************
   使用导航控制器(UINavigationController)
   如果控制器中不存在UIScrollView或者继承自UIScrollView的UI控件
   请使用UIScrollView作为NewPagedFlowView的容器View,才会显示正常,如下
   *****************************/
  
  UIScrollView * scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0,-(( Width - 84) * 9 / 16 + 24), Width, (( Width - 84) * 9 / 16 + 24) )];
  scrollView.backgroundColor = [UIColor redColor];
  [scrollView addSubview:pageFlowView];
  
  [pageFlowView reloadData];
  
 
  [_tableView  addSubview:pageFlowView] ;
  
  
  
}

- (void)viewWillLayoutSubviews
{
 
  
  _tableView.frame =self.view.bounds;// CGRectMake(0, 0 , Width, Height-(( Width - 84) * 9 / 16 + 24) );
  
  
}

 
  
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{//每次刷新表格隐藏
  
  NSInteger count =self. contentArr.count;
  _tableView.mj_footer.hidden = ( count == 0);
  
  return  count;
}

- (ASCellNode *)tableView:(ASTableView *)tableView nodeForRowAtIndexPath:(NSIndexPath *)indexPath
{
  NXTATableViewCell * cell = [[NXTATableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"NXTATableViewCell" WithNewsCellStyle:NewsCellStyleHaveImageAndAuthorWithAvatarAndCategory];
     // cell.backgroundColor = RandomColor;
  NSWYContent * content =self.contentArr[ indexPath.row];
  
  cell.content = content;
  
  return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
  
   
       
   

}
#pragma mark NewPagedFlowView Delegate
- (CGSize)sizeForPageInFlowView:(NewPagedFlowView *)flowView {
  return CGSizeMake(Width - 84, (Width - 84) * 9 / 16);
}

- (void)didSelectCell:(UIView *)subView withSubViewIndex:(NSInteger)subIndex {
  
  NSLog(@"点击了第%ld张图",(long)subIndex + 1);
  
   
}

#pragma mark NewPagedFlowView Datasource
- (NSInteger)numberOfPagesInFlowView:(NewPagedFlowView *)flowView {
  
  return self.imageArray.count;
  
}

- (UIView *)flowView:(NewPagedFlowView *)flowView cellForPageAtIndex:(NSInteger)index{
  PGIndexBannerSubiew *bannerView = (PGIndexBannerSubiew *)[flowView dequeueReusableCell];
  if (!bannerView) {
    bannerView = [[PGIndexBannerSubiew alloc] initWithFrame:CGRectMake(0, 0, Width - 84, (Width - 84) * 9 / 16)];
    bannerView.layer.cornerRadius = 4;
    bannerView.layer.masksToBounds = YES;
  }
  //在这里下载网络图片
  //  [bannerView.mainImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:hostUrlsImg,imageDict[@"img"]]] placeholderImage:[UIImage imageNamed:@""]];
  bannerView.mainImageView.image = self.imageArray[index];
  
  return bannerView;
}

- (void)didScrollToPage:(NSInteger)pageNumber inFlowView:(NewPagedFlowView *)flowView {
  
  NSLog(@"ViewController 滚动到了第%ld页",pageNumber);
}

- (NSMutableArray *)imageArray {
	if(_imageArray == nil) {
    _imageArray = [NSMutableArray array];
    

	}
	return _imageArray;
}

- (NSMutableArray *)contentArr {
	if(_contentArr == nil) {
		_contentArr = [[NSMutableArray alloc] init];
	}
	return _contentArr;
}

@end
