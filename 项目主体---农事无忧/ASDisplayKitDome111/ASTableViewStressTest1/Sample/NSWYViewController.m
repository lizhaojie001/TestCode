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

@interface NSWYViewController ()<ASTableDelegate,ASTableDataSource>
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

@end

@implementation NSWYViewController
-(instancetype)init{
  _tableNode= [[ASTableNode alloc]initWithStyle:UITableViewStylePlain];
  self = [super initWithNode:_tableNode];
  
  if (self ) {
    _tableNode.dataSource =self;
    _tableNode.delegate = self;
  }
  return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
  self.count = 20;
 /* _tableNode.view.mj_footer = [MJRefreshBackNormalFooter  footerWithRefreshingBlock:^{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
      self.count+=5;
      [_tableNode.view.mj_footer endRefreshing];
      [_tableNode.view reloadData];
    });
   
     }];
   */
  _tableNode.view.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
    if (self.count<200) {
      [_tableNode.view.mj_footer endRefreshing];
    }else{
    [ _tableNode.view.mj_footer endRefreshingWithNoMoreData ];
    }
  }];
  _fpsLabel = [[YYFPSLabel alloc]initWithFrame:CGRectMake(0, 100, 50, 50)];
  
  [_fpsLabel sizeToFit];
  // _fpsLabel.alpha = 0;
  _fpsLabel.backgroundColor = [UIColor whiteColor];
  [self.node.view addSubview:_fpsLabel];
  [self.node.view bringSubviewToFront:_fpsLabel];
   
  NSLog(@"%@",_fpsLabel.text);

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
  return self.count;
}

 
- (ASCellNodeBlock)tableView:(ASTableView *)tableView nodeBlockForRowAtIndexPath:(NSIndexPath *)indexPath{
  ASCellNode *(^ASCellNodeBlock)() = ^ASCellNode *() {
    NXTATableViewCell *cellNode = [[NXTATableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil WithNewsCellStyle:4];
    cellNode.titleLabel.attributedText = [[NSAttributedString alloc]initWithString:[NSString stringWithFormat:@"%ld",indexPath.row]];
    
    return cellNode;
  };
  
  return ASCellNodeBlock;

}
-(void)tableView:(ASTableView *)tableView willBeginBatchFetchWithContext:(ASBatchContext *)context{
  [context beginBatchFetching];
  [self insertNewRowsInTableNode:context];
  }
 
 
- (void)insertNewRowsInTableNode:(ASBatchContext*)content 
{
  NSInteger section = 0;
  NSMutableArray *indexPaths = [NSMutableArray array];
  self.num = self.count;
    if (self.count ==200) {
    return;
  }
   self.footer= NO;
  NSUInteger newTotalNumberOfPhotos = (self.count+=5);
  for (NSUInteger row = 0; row < newTotalNumberOfPhotos-self.num; row++) {
    NSIndexPath *path = [NSIndexPath indexPathForRow:self.num+ row inSection:section];
    [indexPaths addObject:path];
  }
  dispatch_sync(dispatch_get_main_queue(), ^{
    [_tableNode.view insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationNone];
  
  });
   [content completeBatchFetching:YES];
}
 
//-(ASDisplayNode*);
 @end
