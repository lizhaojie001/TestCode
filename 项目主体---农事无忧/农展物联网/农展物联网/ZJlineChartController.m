//
//  ZJlineChartController.m
//  农展物联网
//
//  Created by Mac on 2/20/17.
//  Copyright © 2017 HBNXWLKJ. All rights reserved.
//

#import "ZJlineChartController.h"
#import <MJExtension.h>
#import "ZJLineChartCell.h"
#import "ZJData.h"
#import "HcdDateTimePickerView.h"
#import <MJRefresh.h>
#import "NSDate+ZJExtension.h"
@interface ZJlineChartController ()< UITableViewDelegate,UITableViewDataSource>
 


/**tableView*/
@property (nonatomic,weak) UITableView * tableView;

/**背景视图*/
@property (nonatomic,weak) UIScrollView * scrollView;
/**上一次请求*/
@property (nonatomic,strong) NSURLSessionTask * Task;

/**请求参数*/
@property (nonatomic,strong) NSMutableDictionary * parameters;

@end

@implementation ZJlineChartController
static NSString * Identifier = @"cell";
- (void)viewDidLoad {
    [super viewDidLoad];
   
    
    [self  setupTableView];
    [self setNavigation];
}

- (void)setNavigation{
    self.title = @"实时监测数据";
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor whiteColor],NSFontAttributeName:[UIFont systemFontOfSize:18]}];
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    UIView * view  =[[ UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, 64)];
    view.backgroundColor = ZJGreenColor;
    [self.view addSubview:view];
    
    
    UIBarButtonItem * item =  [[UIBarButtonItem alloc]initWithImage: [[UIImage imageNamed:@"clock"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(clickRightItem)];
    self.navigationItem.rightBarButtonItem = item;

}

-(void)clickRightItem{
  HcdDateTimePickerView*  dateTimePickerView = [[HcdDateTimePickerView alloc] initWithDatePickerMode:DatePickerDateMode defaultDateTime:[[NSDate alloc]initWithTimeIntervalSinceNow:0]];
    dateTimePickerView.clickedOkBtn = ^(NSString * datetimeStr){
        NSString * date = [datetimeStr substringToIndex:10];
        [SVProgressHUD showWithStatus:@"刷新数据"];
        [self loadDataSenceID:self.senceID withTime:date];

    };
    if (dateTimePickerView) {
        [self.view addSubview:dateTimePickerView];
        [dateTimePickerView showHcdDateTimePicker];
    }

}

-(void)loadDataSenceID:(NSString *)senceID withTime:(NSString*)time {
    ZJlogFunction;
    [self.Task cancel];
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSMutableDictionary * parameters =[NSMutableDictionary dictionary];
    parameters[@"sceneID"] = senceID;
    parameters[@"time"] = time;
    NSString * urlString = @"http://123.55.118.66:20036/hbnzzx-service/service/gatherData/data";
    //    NSString * urlString = @"http://123.55.118.66:20036/hbnzzx-service/service/gatherData/data?sceneID=B63513DC-9420-44A9-A2EF-0A97E2E49B41&time=2017-01-14";
    self.parameters = parameters;
 self.Task =    [manager GET:urlString parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        
        if (self.parameters !=parameters) {
            return;
        }
        NSArray *dataArray = [ZJData mj_objectArrayWithKeyValuesArray:responseObject];
        self.data = dataArray;
        if (!self.data.count) {
            [SVProgressHUD showErrorWithStatus:@"无数据返回"];
                [self.tableView reloadData];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [SVProgressHUD dismiss];
            });
            
            return ;
        }
        [self.tableView.mj_header endRefreshing];
        [self.tableView reloadData];
        [SVProgressHUD dismiss];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self.tableView.mj_header endRefreshing];
        [SVProgressHUD dismiss];
        ZJLog(@"%@",error);

    }];
    
}


- (void)setupTableView{
    
    UITableView * table = [[UITableView alloc] initWithFrame:ZJScreenBounds style:UITableViewStyleGrouped];
    [table registerNib:[UINib nibWithNibName:NSStringFromClass([ZJLineChartCell class]) bundle:nil] forCellReuseIdentifier:Identifier];
    self.tableView = table;
    table.showsVerticalScrollIndicator = NO;
    table.delegate =self;
    table.dataSource = self;
    [self.view addSubview:table];
    self.tableView.mj_header = [MJRefreshHeader headerWithRefreshingBlock:^{
        [self loadDataSenceID:self.senceID withTime:[NSDate DateOfToday]];
    }];
    self.tableView.mj_header.ignoredScrollViewContentInsetTop = -10;
    self.tableView.mj_header.hidden = NO;
 
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.Task cancel];
    [SVProgressHUD dismiss];
}
#pragma  mark - UITableViewDelegate

#pragma mrak-tableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.data.count;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ZJLineChartCell * cell = [tableView dequeueReusableCellWithIdentifier:Identifier forIndexPath:indexPath];
  
    ZJData * data = self.data[indexPath.section];
    cell.data = data;
       return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 300;
}


 


#pragma mark-UITableViewDataSource

 @end
