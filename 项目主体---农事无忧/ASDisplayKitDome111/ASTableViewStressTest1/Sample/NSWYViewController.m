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
#define URL   @"http://123.85.2.102:8089/nswy-space/a/consultinfo/nswyConsultinfo/ws/look"
@interface NSWYViewController ()<ASTableDelegate,ASTableDataSource>

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
   [self setupRefresh];
  
  MJWeakSelf;
   
  _tableNode.view.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
   if (self.contentArr.count< self.homeModel.total) {
       [_tableNode.view.mj_footer endRefreshing];
   }else{
      [ _tableNode.view.mj_footer endRefreshingWithNoMoreData ];
     }
    // [weakSelf loadMoreData];

      }];
  
  
  
  _fpsLabel = [[YYFPSLabel alloc]initWithFrame:CGRectMake(0, 100, 50, 50)];
  
  [_fpsLabel sizeToFit];
  // _fpsLabel.alpha = 0;
  _fpsLabel.backgroundColor = [UIColor whiteColor];
  [self.node.view addSubview:_fpsLabel];
  [self.node.view bringSubviewToFront:_fpsLabel];
   
  NSLog(@"_fpsLabel.text---%@",_fpsLabel.text);

}
-(void)setupRefresh{
  [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
  [SVProgressHUD show];
 
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
    [SVProgressHUD dismiss];
    
    
  } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"%@" ,error]] ;
  }];
  
  
  
}
- (void)loadMoreData: (void(^)())complete {
  
  if (!_isCompleteInter) {
    if (complete) {
      complete();
    }
    return;
  }
  NSMutableDictionary *params = [NSMutableDictionary dictionary];
 
    params[@"pageNum"] = @(++self.currentPage) ; 
  params[@"number"] = @10;
  [[AFHTTPSessionManager manager] GET:URL parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
    
  } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
    NSWYPageNumModel * model = [NSWYPageNumModel new];
    self.num = self.contentArr.count;   
    if (self.num == model.content.count) {
      return ;
    }
     _isCompleteInter = NO;
    [model mj_setKeyValues:responseObject ];
    self.homeModel = model;
    for (int i =0 ; i<model.content.count; i++) {
      NSWYContent * content = [NSWYContent new];
      [content mj_setKeyValues:model.content[i]];
      [self.contentArr addObject:content];
     
      NSLog(@"self.contentArr.count---%lu",(unsigned long)self.contentArr.count);
    }   
    if (complete) {
      complete();
      

    }
      } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
     _isCompleteInter = NO;
  }];
  
  
  
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
#pragma mark - ASTableDataSource methods
 
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
  return self.contentArr.count;
}

 
- (ASCellNodeBlock)tableView:(ASTableView *)tableView nodeBlockForRowAtIndexPath:(NSIndexPath *)indexPath{
  ASCellNode *(^ASCellNodeBlock)() = ^ASCellNode *() {
    NXTATableViewCell *cellNode = [[NXTATableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil WithNewsCellStyle:4];
   // cellNode.content = self.contentArr[indexPath.row];
    cellNode.titleLabel.attributedText = [[NSAttributedString alloc]initWithString:[NSString stringWithFormat:@"indexPath.row===>%ld",(long)indexPath.row]];
    
    return cellNode;
  };
  
  return ASCellNodeBlock;

}
- (BOOL)shouldBatchFetchForTableView:(ASTableView *)tableView{
  if ([tableView.mj_footer isRefreshing]) {
    return YES;
  }
      return NO;
 
}
-(void)tableView:(ASTableView *)tableView willBeginBatchFetchWithContext:(ASBatchContext *)context{
  [context beginBatchFetching];
  [self insertNewRowsInTableNode:context];
  
}
 
 
- (void)insertNewRowsInTableNode:(ASBatchContext*)content 
{
  NSInteger section = 0;
  NSMutableArray *indexPaths = [NSMutableArray array];
 
  NSLog(@"num----%ld",self.num);
 //   if (self.num == (long)self.homeModel.total) {
  //  return;
 // }
   self.footer= NO;
 
   
  [self loadMoreData:^{
    NSUInteger newTotalNumberOfPhotos = self.contentArr.count;
    NSLog(@"self.contentArr.count----%ld-------num --%ld",self.contentArr.count,self.num);
    if (self.num == self.contentArr.count) {
      return ;
    }
    for (NSUInteger row = 0; row < newTotalNumberOfPhotos-self.num; row++) {
      NSIndexPath *path = [NSIndexPath indexPathForRow:self.num+ row inSection:section];
      [indexPaths addObject:path];
      
    }
        dispatch_async(dispatch_get_main_queue(), ^{
       
    
      [_tableNode.view insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationNone];
        _isCompleteInter = YES;
      NSLog(@"%s",__FUNCTION__);
    });
    

  }];
 
 [content completeBatchFetching:YES];
}
 
//-(ASDisplayNode*);
 - (NSMutableArray *)contentArr {
	if(_contentArr == nil) {
		_contentArr = [[NSMutableArray alloc] init];
	}
	return _contentArr;
}

@end
