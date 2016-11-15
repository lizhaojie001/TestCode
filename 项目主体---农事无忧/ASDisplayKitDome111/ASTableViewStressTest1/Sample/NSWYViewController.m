//
//  NSWYViewController.m
//  Sample
//
//  Created by Mac on 16/11/11.
//  Copyright © 2016年 Facebook. All rights reserved.
//

#import "NSWYViewController.h"
#import "NXTATableViewCell.h"
#import <AsyncDisplayKit/AsyncDisplayKit.h>
#import "MJRefresh.h"
#import "YYFPSLabel.h"
#import "NSWYPageNumModel.h"
#import <SVProgressHUD.h>
#import "AFNetworking.h"
#import "MJExtension.h"
#import "NSWYContent.h"
#import "NewPagedFlowView.h"
#import "PGIndexBannerSubiew.h"
#import "DetialTableViewController.h"
#import "ContentViewController.h"
#define URL   @"http://123.85.2.102:8089/nswy-space/a/consultinfo/nswyConsultinfo/ws/look"
#define Width  [UIScreen mainScreen].bounds.size.width
#define Height  [UIScreen mainScreen].bounds.size.height
@interface NSWYViewController ()<ASTableDelegate,ASTableDataSource,NewPagedFlowViewDelegate,NewPagedFlowViewDataSource>

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

/**currentPage*/
@property (nonatomic,assign) NSInteger  currentPage;





/**tableView*/
@property (nonatomic,strong) ASTableNode * tableNode;
/**count*/
@property (nonatomic,assign) NSInteger  count;
/**num*/
@property (nonatomic,assign) NSInteger  num;
/**<#注释#>*/
@property (nonatomic,strong) YYFPSLabel * fpsLabel;
/**注释*/
@property (nonatomic,assign) BOOL  footer;
/**是否inter完成*/
@property (nonatomic,assign) BOOL  isCompleteInter;

@end

@implementation NSWYViewController
-(instancetype)init{
  _tableNode= [[ASTableNode alloc]initWithStyle:UITableViewStylePlain];
  self = [super initWithNode:_tableNode];
  
  if (self ) {
    _tableNode.view.asyncDelegate =self;
    _tableNode.view.asyncDataSource = self;
  }
  return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
  //临时图片
  _tableNode.view.contentInset = UIEdgeInsetsMake(((Width - 84) * 9 / 16 + 24), 0, 0, 0);
  
  for (int index = 0; index < 5; index++) {
    UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"Yosemite0%d.jpg",index]];
    [self.imageArray addObject:image];
  }
  

  [self setupUI];
    
     MJWeakSelf;
     _tableNode.view.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
   if (self.contentArr.count< self.homeModel.total) {
       [_tableNode.view.mj_footer endRefreshing];
   }else{
      [ _tableNode.view.mj_footer endRefreshingWithNoMoreData ];
     }
    }];
  _tableNode.view.mj_footer.hidden =NO;
  
  _tableNode.view.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
  
    [self.contentArr removeAllObjects];
    [self setupRefresh];
        
  }];
  _tableNode.view.mj_header.ignoredScrollViewContentInsetTop = ((Width - 84) * 9 / 16 + 24);  
  [_tableNode.view.mj_header beginRefreshing];
 
  
  
  
}
-(void)setupRefresh{
  
 
  NSMutableDictionary *params = [NSMutableDictionary dictionary];
  
  params[@"pageNum"] = @1;
  params[@"number"] = @20;
  self.currentPage=1;
  
  [[AFHTTPSessionManager manager] GET:URL parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
    
  } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
    
        NSWYPageNumModel * model = [NSWYPageNumModel new];
    self.num =self.contentArr.count;
    [model mj_setKeyValues:responseObject ];
    self.homeModel = model;
    for (int i =0 ; i<model.content.count; i++) {
      NSWYContent * content = [NSWYContent new];
      [content mj_setKeyValues:model.content[i]];
      [self.contentArr addObject:content];
     
          }   
  
   [_tableNode.view reloadData];
      _isCompleteInter =YES;
    dispatch_async(dispatch_get_main_queue(), ^{
      [_tableNode.view.mj_header endRefreshing];
    });
    
    
  } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    
  }];
  
  
  
}
- (void)loadMoreData: (void(^)())complete withContext:(ASBatchContext*)context{
  
  if (!_isCompleteInter) {
    [context cancelBatchFetching];
    return;
  }
  NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"pageNum"] = @(++self.currentPage) ; 
 
  params[@"number"] = @10;
  [[AFHTTPSessionManager manager] GET:URL parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
    
  } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
    NSWYPageNumModel * model = [NSWYPageNumModel new];
    self.num = self.contentArr.count;   
    if ((int)self.num == (int)model.content.count) {
      [context cancelBatchFetching];

      return ;
    }
     _isCompleteInter = NO;
    [model mj_setKeyValues:responseObject ];
    self.homeModel = model;
    for (int i =0 ; i<model.content.count; i++) {
      NSWYContent * content = [NSWYContent new];
      [content mj_setKeyValues:model.content[i]];
      [content.fcontent writeToFile:[self dataFilePath:content] atomically:YES encoding:NSUTF8StringEncoding error:nil];
      [self.contentArr addObject:content];
          
      
      
      NSLog(@"self.contentArr.count---%lu",(unsigned long)self.contentArr.count);
     
    }   
    if (complete) {
      complete();
    }
      } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"%@",error]];
     _isCompleteInter = NO;
  }];
  
  
  
}
/**
 *  数据存储路径
 *
 *  @return l路径
 */
- (NSString *)dataFilePath:(NSWYContent*)content{
  NSArray * paths =NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
  NSString * path = [paths objectAtIndex:0];
  
 
  NSString * name = [NSString stringWithFormat:@"%@%@",content.ID,content.fcreatetime];
  
  return  [path stringByAppendingPathComponent: [NSString stringWithFormat:@"%@.html",name]];
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
  pageFlowView.orginPageCount = 5;
  
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
  
  
  [_tableNode.view  addSubview:pageFlowView] ;
  
  
  
}




/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
#pragma mark - ASTableDelegate methods

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
  
 // ContentViewController * detial = [ContentViewController new];
//  detial.content = self.contentArr[indexPath.row];
  
//  [self presentViewController:detial animated:YES completion:nil];
  
}
#pragma mark - ASTableDataSource methods
 
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
  return self.contentArr.count;
}

 
- (ASCellNodeBlock)tableView:(ASTableView *)tableView nodeBlockForRowAtIndexPath:(NSIndexPath *)indexPath{
  ASCellNode *(^ASCellNodeBlock)() = ^ASCellNode *() {
    NXTATableViewCell *cellNode = [[NXTATableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil WithNewsCellStyle:4];
    cellNode.content = self.contentArr[indexPath.row];
   // cellNode.titleLabel.attributedText = [[NSAttributedString alloc]initWithString:[NSString stringWithFormat:@"indexPath.row===>%ld",(long)indexPath.row]];
    
    return cellNode;
  };
  
  return ASCellNodeBlock;

}
- (BOOL)shouldBatchFetchForTableView:(ASTableView *)tableView{
  if ([tableView.mj_footer isRefreshing]) {
    if (_isCompleteInter) {
      return YES;
    }
    return NO;
  }
      return NO;
 
}
-(void)tableView:(ASTableView *)tableView willBeginBatchFetchWithContext:(ASBatchContext *)context{
  [context beginBatchFetching];
  [self insertNewRowsInTableNode:context];
  
}
 
 
- (void)insertNewRowsInTableNode:(ASBatchContext*)context 
{
  
   
   
  [self loadMoreData:^{
    _isCompleteInter =NO;
    NSUInteger newTotalNumberOfPhotos = self.contentArr.count;
    NSLog(@"self.contentArr.count----%ld-------num --%ld",self.contentArr.count,self.num);
    if ((int)self.num == (int)self.contentArr.count) {
      [context cancelBatchFetching];
      return ;
    }
    
    NSInteger section = 0;
    NSMutableArray *indexPaths = [NSMutableArray array];

    for (NSUInteger row = 0; row < newTotalNumberOfPhotos-self.num; row++) {
      NSIndexPath *path = [NSIndexPath indexPathForRow:self.num+ row inSection:section];
      [indexPaths addObject:path];
      
    }
    @synchronized (self) {
      dispatch_async(dispatch_get_main_queue(), ^{
        [_tableNode.view insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationNone];
        _isCompleteInter = YES;
        NSLog(@"%s",__FUNCTION__);
      });
      
    }

  } withContext:context];
 
 [context completeBatchFetching:YES];
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

//-(ASDisplayNode*);
 - (NSMutableArray *)contentArr {
	if(_contentArr == nil) {
		_contentArr = [[NSMutableArray alloc] init];
	}
	return _contentArr;
}
- (NSMutableArray *)imageArray {
  if(_imageArray == nil) {
    _imageArray = [NSMutableArray array];
    
    
  }
  return _imageArray;
}

@end
