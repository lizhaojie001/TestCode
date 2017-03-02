//
//  ZJlineChartController.m
//  农展物联网
//
//  Created by Mac on 2/20/17.
//  Copyright © 2017 HBNXWLKJ. All rights reserved.
//

#import "ZJlineChartController.h"

#import "ZJLineChartCell.h"
#import "ZJData.h"
@interface ZJlineChartController ()< UITableViewDelegate,UITableViewDataSource>
 


/**tableView*/
@property (nonatomic,weak) UITableView * tableView;

/**背景视图*/
@property (nonatomic,weak) UIScrollView * scrollView;

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
}
- (void)setupTableView{
    
    UITableView * table = [[UITableView alloc] initWithFrame:ZJScreenBounds style:UITableViewStyleGrouped];
    [table registerNib:[UINib nibWithNibName:NSStringFromClass([ZJLineChartCell class]) bundle:nil] forCellReuseIdentifier:Identifier];
    self.tableView = table;
    table.showsVerticalScrollIndicator = NO;
    table.delegate =self;
    table.dataSource = self;
    [self.view addSubview:table];
 
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
