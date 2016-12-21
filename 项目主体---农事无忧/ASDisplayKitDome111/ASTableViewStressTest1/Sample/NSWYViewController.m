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

#import <SVProgressHUD.h>
#import "AFNetworking.h"
#import "MJExtension.h"
 
#import "NewPagedFlowView.h"
#import "PGIndexBannerSubiew.h"
#import "DetialTableViewController.h"
#import "ContentViewController.h"

#import <AssetsLibrary/AssetsLibrary.h>
#import <Photos/Photos.h>
#import <ImageIO/ImageIO.h>
#import "DataModels.h"

#define URL   @"http://123.85.2.102:8089/nswy-space/a/consultinfo/nswyConsultinfo/ws/look"
#define Width  [UIScreen mainScreen].bounds.size.width
#define Height  [UIScreen mainScreen].bounds.size.height
#define DeviceVersion [[UIDevice currentDevice].systemVersion floatValue]
@interface NSWYViewController ()<ASTableDelegate,ASTableDataSource,NewPagedFlowViewDelegate,NewPagedFlowViewDataSource>

/** ASTableView *_tableView;*/
@property (nonatomic,strong) ASTableView * tableView;


/**imageArray*/
@property (nonatomic,strong) NSMutableArray * imageArray;
/**ScorllView视图*/
@property (nonatomic,strong) UIScrollView * Sview;

/**数据源*/
@property (nonatomic,strong) RLMRealm * realm;
/**NSWYContent*/
/**数据*/
@property (nonatomic,strong) RLMResults   * allContents;

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

@property (nonatomic,strong) NSDictionary * params;
@end

@implementation NSWYViewController
-(instancetype)init{
  _tableNode= [[ASTableNode alloc]initWithStyle:UITableViewStylePlain];
  self = [super initWithNode:_tableNode];
  
  if (self ) {
    _tableNode.view.asyncDelegate =self;
    _tableNode.view.asyncDataSource = self;
    _tableNode.view.separatorStyle = UITableViewCellSeparatorStyleNone;
  }
  return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
  NSLog(@"%s",__func__);
  //临时图片
  _tableNode.view.contentInset = UIEdgeInsetsMake(((Width - 84) * 9 / 16 + 24), 0, 0, 0);
  
  for (int index = 0; index < 5; index++) {
    UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"Yosemite0%d.jpg",index]];
    [self.imageArray addObject:image];
  }
   
  [self setupUI];
    
     MJWeakSelf;
     _tableNode.view.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
       }];
  _tableNode.view.mj_footer.hidden =NO;
  
  _tableNode.view.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
  
 //   [weakSelf.contentArr removeAllObjects];
    [weakSelf setupRefresh];
        
  }];
  _tableNode.view.mj_header.ignoredScrollViewContentInsetTop = ((Width - 84) * 9 / 16 + 24);  
  [_tableNode.view.mj_header beginRefreshing];
 
  
  
  
}

#pragma mrak -- 如果你没有网络,就就不发送网络请求 待处理
-(void)setupRefresh{
  
 
  NSMutableDictionary *params = [NSMutableDictionary dictionary];
  
  params[@"pageNum"] = @1;
  params[@"number"] = @20;
  self.currentPage=1;
 
  [[AFHTTPSessionManager manager] GET:URL parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
    
  } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
 
   NSLog(@"%@",[NSThread currentThread]);
    NSError * error;
    [self.realm transactionWithBlock:^{
      [DataModels createOrUpdateInRealm:self.realm withValue:responseObject];
    } error:&error];
    if (error) {
      NSLog(@"%@",error);
    }
     self.allContents = [NSWYContent allObjects];
      NSLog(@"%@",NSHomeDirectory());
    
//        NSWYPageNumModel * model = [NSWYPageNumModel new];
    
     self.num =self.allContents.count;
//    [model mj_setKeyValues:responseObject ];
//    self.homeModel = model;
   for (int i =0 ; i<self.allContents.count; i++) {
     NSWYContent * content = self.allContents[i];
     NSString *parten =  @"<img [^>]*src=\"([^\"]+)[^>]*>";
      NSString * fcontent =   [self dealWithContent:content.fcontent withParten:parten];
      
    //  NSString *str = [NSString stringWithFormat:@"<html><head><meta name=\"viewport\" content=\"width=device-width; user-scalable=0\" /> <link rel=\"stylesheet\" href=\"chrome://global/skin/aboutReader.css\" type=\"text/css\"/>\
   </head><body> \
                        <p style = \"text-align:center; font-size :30px\">%@</p>  " , content.ftitle];
      NSString * str = [NSString stringWithFormat: @"<html><head><meta name=\"viewport\" content=\"initial-scale=1.0,maximum-scale=1,user-scalble=no\"/>  <link rel=\"stylesheet\" href=\"chrome://global/skin/aboutReader.css\" type=\"text/css\"/>  <style>                         img \
                        {\
                        margin:3px;\
                        border:1px solid #bebebe;\
                        height:auto;\
                        width:auto;\
                          float:left;\
                          text-align:center;\
                        }   \
                        body, span, div, p\
      { \
                        padding: 1px   ;\
                        background-color:#C8C8C8 !important;\
                        text-align:left; font-size:20px\
                        }\
                        </style> </head><body> \
                        <p style = \"text-align:center; font-size :30px\">%@</p>  " , content.ftitle];
      str =   [str stringByAppendingString:@" <body>"];
     str =    [str stringByAppendingString: fcontent? fcontent:@"无内容,不应该啊"];
      str = [str stringByAppendingString:@" </body></html>"];
      NSLog(@"%@",str);
      [str writeToFile:[self dataFilePath:content] atomically:YES encoding:NSUTF8StringEncoding error:nil];
          }
    
   [_tableNode.view reloadData];
      _isCompleteInter =YES;
    
      [_tableNode.view.mj_header endRefreshing];
   
    
    
  } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    
      NSLog(@"currentThread:%@",[NSThread currentThread]);
      [_tableNode.view.mj_header endRefreshing];
    
    
  }];
  
 
  
}
/*
- (void)loadMoreData: (void(^)())complete withContext:(ASBatchContext*)context{
  
  if (!_isCompleteInter) {
    [context cancelBatchFetching];
    return;
  }
  NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"pageNum"] = @(++self.currentPage) ; 
 
  params[@"number"] = @10;
  self.params = params;
  [[AFHTTPSessionManager manager] GET:URL parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
    NSLog(@"%f",downloadProgress.completedUnitCount*1.0/downloadProgress.totalUnitCount);
    
  } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
       [NSWYPageNumModel mj_setupObjectClassInArray:^NSDictionary *{
      return  @{ @"content": @"NSWYContent" };
    }];
    NSWYPageNumModel * model =   [NSWYPageNumModel mj_objectWithKeyValues:responseObject];

    
    int count = (int)model.content.count;
    if ((int)self.num == count) {
      [context cancelBatchFetching];

      return ;
    }
     _isCompleteInter = NO;
  //    self.homeModel = model;
    
     for (int i = 0; i <  count; i ++) {
      NSWYContent * content =model.content[i];
       NSString *parten =  @"<img [^>]*src=['\"]([^'\"]+)[^>]*>";

    NSString * fcontent =   [self dealWithContent:content.fcontent withParten:parten];
      // NSString *str = [NSString stringWithFormat:@"<html><head><meta name=\"viewport\" content=\"width=device-width; user-scalable=0\" />  <link rel=\"stylesheet\" href=chrome://global/skin/aboutReader.css\" type=\"text/css\"/>\
                        </head><body>\
                        <p style = \"text-align:center; font-size :30px\">%@</p>  " , content.ftitle];
       NSLog(@"%lu",(unsigned long)self.contentArr.count);
      NSString * str = [NSString stringWithFormat: @"<html><head><meta name=\"viewport\" content=\"initial-scale=1.0,maximum-scale=1,user-scalble=no\"/>  <style>                         \
                        img  \
                         {\
                                                   border:1px solid #bebebe;\
                         height:200px;\
                         width:%0.0fpx;\
                         float:left  !important;\
                         text-align:center;\
                         }   \
                         body, span, div, p\
                         { \
                         padding: 1px   ;\
                         background-color:#C8C8C8 !important;\
                         text-align:left; \
                         font-size:20px\
                         }\
                         </style> </head><body> \
                         <p style = \"text-align:center; font-size :30px\">%@</p>  " ,Width-20, content.ftitle];        str =   [str stringByAppendingString:@" <body>"];
       
      
       
       str =    [str stringByAppendingString:fcontent?fcontent:@"无内容,不应该啊"];
       str = [str  stringByAppendingString:@" </body></html>"];
       
       [str writeToFile:[self dataFilePath:content] atomically:YES encoding:NSUTF8StringEncoding error:nil];
     }
    
   
    [self.contentArr addObjectsFromArray:model.content];
    
    if (self.contentArr.count<self.homeModel.total) {
      [_tableNode.view.mj_footer endRefreshing];
    }else{
      [ _tableNode.view.mj_footer endRefreshingWithNoMoreData ];
    }

    if (complete) {
      complete();
    }
      } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"%@",error]];
     _isCompleteInter = NO;
  }];
  
  
  
}
 */
#pragma mark - 更改宽度高度适应,由于上传可能没有高度只有宽度,在进行图片下载到本地处理

- (NSString *)dealWithContent:(NSString*)content withParten:(NSString *)parten {
 
  if (content.length == 0) {
    return content;
  }
    NSString *staString = [NSString stringWithUTF8String: [content UTF8String]];
  NSArray* match = getArr(staString, parten);
    if (match.count != 0)
    {
       for (NSTextCheckingResult *matc in match)
      {
      
        
     NSRange range = [matc range];
     NSString *str = [staString substringWithRange:range];
        NSLog(@"----------------%@",str);
        if (!([str containsString:@"height"]&&[str containsString:@"width"])) {
#warning 图片下载处理
   NSString * imageP= returnLocImage(str);
          
        }
        
        
        
        NSString * originalStr = [str copy];
        
        NSString *partenH =  @"height=\"[0-9]{1,3}\"";
        NSString * partenW = @"width=\"[0-9]{1,3}\"";
        NSString*partenHH =@"height:.?[0-9]{1,3}px";
        NSString * partenWW = @"width:.?[0-9]{1,3}px";
        
        CGFloat H1 =getInt(str, partenH, YES);
        CGFloat H2 =getInt(str, partenHH, YES);
        /**
         *  避免没有宽度设置 临时使用
         */
        if (H1||H2) {
          H1=200;
        }
        CGFloat H = H1>H2?H1:H2;
       
        CGFloat W1 = getInt(str, partenW, NO);
        CGFloat W2 = getInt(str, partenWW, NO);
        CGFloat W = W1>W2?W1:W2;
        
        if (H&&W) {
          
          CGFloat replaceH = (Width-20)*H*1.0/W;
          CGFloat replaceW = Width-20;
          NSString * originalHeight = [NSString stringWithFormat:@"height=\"%0.0f\"",H1];
          NSString * originalWidth = [NSString stringWithFormat:@"width=\"%0.0f\"",W1];
          NSTextCheckingResult * matc = getArr(str, partenHH).firstObject;
          NSRange range = [matc range];
          NSString * originalHEight = [str substringWithRange:range];
          NSTextCheckingResult * matc2 = getArr(str, partenWW).firstObject;
          NSRange range2 = [matc2 range];
          NSString * originalWIdth = [str substringWithRange:range2];
          NSString * replaceHeight = [NSString stringWithFormat:@"height=\"%0.0f\"",replaceH];
          NSString * replaceWidth = [NSString stringWithFormat:@"width=\"%0.0f\"",replaceW];
          NSString * replaceHEight = [NSString stringWithFormat:@"height:%dpx",(int)replaceH];
          NSString * replaceWIdth = [NSString stringWithFormat:@"width:%0.0fpx",replaceW];
      
          str = [str stringByReplacingOccurrencesOfString:originalHEight withString:replaceHEight];
          NSLog(@"%@" ,str);
          str = [str stringByReplacingOccurrencesOfString:originalWIdth withString:replaceWIdth];
                 NSLog(@"%@" ,str);
          str = [str stringByReplacingOccurrencesOfString:originalHeight withString:replaceHeight];
          str = [str stringByReplacingOccurrencesOfString:originalWidth withString:replaceWidth];
          staString = [staString stringByReplacingOccurrencesOfString:originalStr withString:str];
          NSLog(@"\n%@\n",str);
        }
       

            }
     
    }
  
  
  
  return staString;
}
/**
 *  获取匹配后的集合
 *
 *  @param str    <#str description#>
 *  @param parten <#parten description#>
 *
 *  @return <#return value description#>
 */

NSArray * getArr(NSString * str , NSString*parten){
  NSError * error = NULL;
  NSRegularExpression *reg = [NSRegularExpression regularExpressionWithPattern:parten options:NSRegularExpressionCaseInsensitive error:&error];
  NSArray* match = [reg matchesInString:str options:NSMatchingReportCompletion range:NSMakeRange(0, [str length])];
  
  
  return match;
}
/**
 *  返回截取的宽度或者高度的int值
 *
 *  @param str    <#str description#>
 *  @param parten <#parten description#>
 *  @param HorW   <#HorW description#>
 *
 *  @return <#return value description#>
 */
int getInt( NSString * str ,NSString * parten ,BOOL HorW){
  
  int lenth =  HorW?12:11;
  int beginLoc = HorW?8:7;
  
  int result =0;
  
  NSArray* match =getArr(str,parten);
  
  
  if (match.count != 0)
  {
    for (NSTextCheckingResult *matc in match)
    {
      NSRange range = [matc range];
      NSString * a = [str substringWithRange:range];
    
      if ([a hasSuffix:@"px"]) {
        
        if (a.length>lenth) {
          beginLoc++;
          lenth= (int)a.length ;
        }
        NSLog(@"%@",a);
        if (a.length ==lenth)
        {
          NSRange range = {beginLoc-1,3};
          a =    [a substringWithRange:range];
          
        }else if (a.length ==(lenth-1))
        {
          NSRange range = {beginLoc-1,2};
          a =    [a substringWithRange:range];
          
        }else
        {
          NSRange range = {beginLoc-1,1};
          a =    [a substringWithRange:range];
          
        }
     
      } else{
      if (a.length ==lenth)
      {
        NSRange range = {beginLoc,3};
        a =    [a substringWithRange:range];
        
      }else if (a.length ==(lenth-1))
      {
        NSRange range = {beginLoc,2};
        a =    [a substringWithRange:range];
        
      }else
      {
        NSRange range = {beginLoc,1};
        a =    [a substringWithRange:range];
        
      }
      }
      result = [a floatValue ];
      
    }
    
  }
  return  result ;
}

/**
 *  数据存储路径
 *
 *  @return l路径
 */


- (NSString *)dataFilePath:(NSWYContent*)content{
  NSArray * paths =NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
  NSString * path = [paths objectAtIndex:0];
  
 
  NSString * name = [NSString stringWithFormat:@"%@%@",content.id,content.fcreatetime];
  path =  [path stringByAppendingPathComponent: [NSString stringWithFormat:@"%@.html",name]];
 // NSLog(@"path: %@",path);
  
  return path;
}
#pragma mark -图片下载处理
/**
 *  获取本地图片<img scr="">的形式 下载写入本地  demo将图片直接写在document下
 *
 *  @param urlImage <img scr="远程地址">
 *
 *  @return 处理好的图片地址 <img scr="本地地址">
 */
NSString * returnLocImage(NSString * urlImage){
  NSString *parten = @"src=\".[^\"]*\"";
  NSArray * match = getArr(urlImage, parten);
  NSString* str = getInterceptStr(urlImage,match);
  NSString* partenT = @"(?<==)\".[^\"]*\"";
  NSArray * match1 = getArr(str, partenT);
  //图片远程地址
  NSString* urlStr = getInterceptStr(str,match1);
  
#pragma  mark  先根据名字从本地取,没有再去下载
  UIImage * image = fetchImageWithDirectorystringByAppendingPathComponent(urlStr);
  if (image) {
    NSArray*paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *documentsDirectory=[paths objectAtIndex:0];
    //本地路径
    NSString *locationPath=[documentsDirectory stringByAppendingPathComponent:urlStr];
    //将原来的网络地址替换
    NSString  *finalResult = [urlStr stringByReplacingOccurrencesOfString:urlStr withString:locationPath  ];
    return finalResult;
    
  }
  NSURL *imageUrl = [NSURL URLWithString:urlStr];
 
  NSURLRequest *request = [NSURLRequest requestWithURL:imageUrl];
  NSURLSession *session = [NSURLSession sharedSession];
 //子线程下载
  dispatch_async(dispatch_get_global_queue(0, 0), ^{
    NSURLSessionDownloadTask *downTask = [session downloadTaskWithRequest:request completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error) {
      
      NSArray*paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
      
      NSString *documentsDirectory=[paths objectAtIndex:0];
      //将图片的的scr="链接",链接设置为图片名字 本地路径:/.../.../../http://1264651654564fa.jpg
      NSString *savedImagePath=[documentsDirectory stringByAppendingPathComponent:urlStr];
      
      //文件下载会被先写入到一个 临时路径 location,我们需要将下载的文件移动到我们需要地方保存
      NSURL *savePath = [NSURL fileURLWithPath:savedImagePath];
      if (location!=nil) {
        [[NSFileManager defaultManager] moveItemAtURL:location toURL:savePath error:nil];

      }
      
      
    }];
    
    [downTask resume];
    

  });
  
  
  
  
  //在下载完成之前返回原来的urlImage ,交给展示页去下载图片修改图片
  
  return urlImage;
}

UIImage * fetchImageWithDirectorystringByAppendingPathComponent (NSString * urlStr){
  NSArray*paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
  
  NSString *documentsDirectory=[paths objectAtIndex:0];
  NSString *aPath3=[documentsDirectory stringByAppendingPathComponent:urlStr];
  UIImage *imgFromUrl3=[[UIImage alloc]initWithContentsOfFile:aPath3];
 // UIImageView* imageView3=[[UIImageView alloc]initWithImage:imgFromUrl3];
  return imgFromUrl3;
}

/**
 *  根据匹配对象获取截取的字符串
 *
 *  @return
 */
NSString * getInterceptStr(NSString* str,  NSArray * match){
  
  NSTextCheckingResult * matc = match.firstObject;
  NSRange range = [matc range];
  NSString * aStr  = [str substringWithRange:range];
 
  return aStr;
}
#pragma mark - 头部滚动视图


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

#pragma mark - 获取图片信息,压缩图片大小

#pragma mark - Exif Getter
/**
 *  获取图片信息,压缩图片大小
 *
 *  @param url 图片路径
 *
 *  @return 返回CGSize
 */
- (CGSize)accessExifDictionaryFromMediaInfo:(NSURL *)url
{
  __weak typeof(self) weakSelf = self;
 __block CGFloat H,W;
   if (DeviceVersion < 9.0) {
    
    
    ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
    [library assetForURL:url resultBlock:^(ALAsset *asset) {
      NSDictionary *imageInfo = [asset defaultRepresentation].metadata;
  
      NSLog(@"%d",[imageInfo[@"PixelHeight"] intValue]);
      H = [imageInfo[@"PixelHeight"] floatValue];
      W = [imageInfo[@"PixelWidth"] floatValue];
      
      
    } failureBlock:^(NSError *error) {
      
          }];
  }else{
    PHFetchOptions * options = [PHFetchOptions new];
    
    PHFetchResult *result= [PHAsset fetchAssetsWithALAssetURLs:@[url] options:options];
    
    NSLog(@"%@",[result.firstObject class]);
    
    PHAsset *asset = result.firstObject;
    NSLog(@"pixelWidth%lu\npixelHeight%lu",(unsigned long)asset.pixelWidth,(unsigned long)asset.pixelHeight);
    H = asset.pixelHeight;
    W =asset.pixelWidth;
    
  }
 
  CGFloat replaceW = Width-20;
  CGFloat replaceH = (Width-20)*H*1.0/W;
  
  return CGSizeMake(replaceW, replaceH);
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}h
*/
#pragma mark - ASTableDelegate methods

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
  
   ContentViewController * detial = [ContentViewController new];
   detial.content = self.allContents[indexPath.row];
  
   [self presentViewController:detial animated:YES completion:nil];
  
}
#pragma mark - ASTableDataSource methods
 
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
  NSLog(@"%s",__func__);
  NSLog(@"%@",[NSThread currentThread]);
 // RLMResults <NSWYContent *>* content = [NSWYContent allObjects];
    return self.allContents.count;
}

 
- (ASCellNodeBlock)tableView:(ASTableView *)tableView nodeBlockForRowAtIndexPath:(NSIndexPath *)indexPath{
  NSWYContent* content = [NSWYContent allObjects][indexPath.row];
  ASCellNode *(^ASCellNodeBlock)() = ^ASCellNode *() {
    NXTATableViewCell *cellNode = [[NXTATableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil WithNewsCellStyle:4];
    cellNode.content = content;
    // cellNode.titleLabel.attributedText = [[NSAttributedString alloc]initWithString:[NSString stringWithFormat:@"indexPath.row===>%ld",(long)indexPath.row]];
    
    return cellNode;
  };
  
  return ASCellNodeBlock;

}
/*
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
     self.num = self.contentArr.count;
      dispatch_async(dispatch_get_main_queue(), ^{
        [_tableNode.view insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationNone];
        _isCompleteInter = YES;
        NSLog(@"%s",__FUNCTION__);
      });
      
    
  } withContext:context];
 
 [context completeBatchFetching:YES];
}
 */
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
// - (NSMutableArray *)contentArr {
//	if(_contentArr == nil) {
//		_contentArr = [[NSMutableArray alloc] init];
//	}
//	return _contentArr;
//}
- (NSMutableArray *)imageArray {
  if(_imageArray == nil) {
    _imageArray = [NSMutableArray array];
    
    
  }
  return _imageArray;
}

- (RLMRealm *)realm {
	if(_realm == nil) {
    //配置realm
    RLMRealmConfiguration *config = [RLMRealmConfiguration defaultConfiguration];
    
    // 使用默认的目录，但是使用用户名来替换默认的文件名
    config.fileURL = [[[config.fileURL URLByDeletingLastPathComponent]
                       URLByAppendingPathComponent:@"资讯"]
                      URLByAppendingPathExtension:@"realm"];
    
    // 将这个配置应用到默认的 Realm 数据库当中
    [RLMRealmConfiguration setDefaultConfiguration:config];
    _realm = [RLMRealm realmWithConfiguration:config error:nil];
	}
	return _realm;
}

@end
