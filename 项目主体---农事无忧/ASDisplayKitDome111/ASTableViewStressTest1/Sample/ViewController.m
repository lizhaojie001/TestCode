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

#define Width  [UIScreen mainScreen].bounds.size.width
#define Height  [UIScreen mainScreen].bounds.size.height
#define RandomColor  [UIColor colorWithRed:arc4random()%255/255.0 green:arc4random()%255/255.0 blue:arc4random()%255/255.0 alpha:1]
typedef enum : NSUInteger {
  ReloadData,
  ReloadRows,
  ReloadSections,
  ReloadTypeMax
} ReloadType;

@interface ViewController () <ASTableViewDataSource, ASTableViewDelegate,NewPagedFlowViewDelegate,NewPagedFlowViewDataSource>
{
  ASTableView *_tableView;
  NSMutableArray *_sections; // Contains arrays of indexPaths representing rows
  YYFPSLabel * _fpsLabel;
}
/**imageArray*/
@property (nonatomic,strong) NSMutableArray * imageArray;
/**ScorllView视图*/
@property (nonatomic,strong) UIScrollView * Sview;

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
  
  [self.view addSubview:_tableView];
 
    
    _fpsLabel = [[YYFPSLabel alloc]initWithFrame:CGRectMake(0, 100, 50, 50)];
    
    [_fpsLabel sizeToFit];
    // _fpsLabel.alpha = 0;
    _fpsLabel.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_fpsLabel];
  _tableView.backgroundColor = RandomColor;
_tableView.contentInset = UIEdgeInsetsMake(((Width - 84) * 9 / 16 + 24), 0, 0, 0);
//  UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0,-(( Width - 84) * 9 / 16 + 24), Width, (( Width - 84) * 9 / 16 + 24) )] ;
//  view.backgroundColor = [UIColor blackColor];
//  [_tableView addSubview:view];
  for (int index = 0; index < 5; index++) {
    UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"Yosemite0%d.jpg",index]];
    [self.imageArray addObject:image];
  }

  [self setupUI];

  
}
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
{
  return 1000;
}

- (ASCellNode *)tableView:(ASTableView *)tableView nodeForRowAtIndexPath:(NSIndexPath *)indexPath
{
  NXTATableViewCell * cell = [[NXTATableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"NXTATableViewCell" WithNewsCellStyle:arc4random()%5];
   cell.backgroundColor = RandomColor;
   
  
  return cell;
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

@end
