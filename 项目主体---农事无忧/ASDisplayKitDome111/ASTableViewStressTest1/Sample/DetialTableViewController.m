//
//  DetialTableViewController.m
//  DetialText
//
//  Created by Mac on 16/11/7.
//  Copyright © 2016年 HBNXWLKJ. All rights reserved.
//

#import "DetialTableViewController.h"
#import "author.h"
#import "SVProgressHUD.h"
#import "AFNetworking.h"
 
#import "NSWYDetialCell.h"
#import "MJExtension.h"
#import <UITableView+FDTemplateLayoutCell.h>
#import "DataModels.h"
#import "NSWYDetialCell.h"
/**
 *  分页查询
 *
 *  @return  
 */
#define URL   @"http://123.85.2.102:8089/nswy-space/a/consultinfo/nswyConsultinfo/ws/look?fcreatorid%20=1&pageNum=1&number=2" 

@interface DetialTableViewController ()
 
/**文章源数据*/
/**content*/
//@property (nonatomic,strong) NSWYContent * content;


@end

@implementation DetialTableViewController
static NSString * const reuseIdentifier = @"reuseIdentifier";
- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.automaticallyAdjustsScrollViewInsets =NO;
    self.tableView.contentInset =UIEdgeInsetsMake(64, 0, 0, 0);
   // [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:reuseIdentifier];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([NSWYDetialCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([NSWYDetialCell class])];
  /**     __weak __typeof__(self) weakSelf = self;
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    [SVProgressHUD show];
    //模拟网络延迟
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
   
    [[AFHTTPSessionManager manager] GET:URL parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
            
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@",responseObject);
        NSWYPageNumModel * model = [NSWYPageNumModel new];
        NSWYContent * content = [NSWYContent new];
       [model mj_setKeyValues:responseObject ];
        [content mj_setKeyValues:model.content[1]];    
        self.content =content;
       
        author* a =  [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([author class]) owner:nil options:nil].firstObject;
    
        a.frame = CGRectMake(0, -44, self.view.frame.size.width, 44);
        
        self.tableView.backgroundColor = [UIColor  redColor];
        
        a.model =self.content;
        [self.tableView reloadData];
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf.tableView addSubview:a];
        });
        [SVProgressHUD dismiss];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"%@" ,error]] ;
    }];
    
     });
     */ 
  
  author* a =  [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([author class]) owner:nil options:nil].firstObject;
  
  a.frame = CGRectMake(0, -44, self.view.frame.size.width, 44);
  
  self.tableView.backgroundColor = [UIColor  redColor];
  
  a.model =self.content;
 
 
    [self.tableView  addSubview:a];
   

  
    UIButton * button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.frame =CGRectMake(0, 0, 50, 50);
    [button setBackgroundColor:[UIColor blueColor]];
    [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}
-(void)back{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return 1;
}

 
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSWYDetialCell *cell = [tableView dequeueReusableCellWithIdentifier: NSStringFromClass([NSWYDetialCell class])  forIndexPath:indexPath];
    cell.fd_enforceFrameLayout = NO; 
    cell.entity = self.content;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
   // cell.textLabel.text =self.data.content;
    
    return cell;
}
 
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
   // return [tableView fd_heightForCellWithIdentifier:NSStringFromClass([NSWYDetialCell class]) configuration:^(NSWYDetialCell* cell) {
   //      cell.fd_enforceFrameLayout = NO; 
   //     cell.entity = self.content;
  //  }];
  return 200;
}
 
@end
