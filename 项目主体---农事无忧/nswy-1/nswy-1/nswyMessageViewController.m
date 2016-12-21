//
//  nswyMessageViewController.m
//  nswy-1
//
//  Created by Mac on 16/12/2.
//  Copyright © 2016年 HBNXWLKJ. All rights reserved.
//

#import "nswyMessageViewController.h"

@interface nswyMessageViewController ()

@end

@implementation nswyMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"消息";
     self.tableView.showsVerticalScrollIndicator = NO;
    // Do any additional setup after loading the view.
    UIBarButtonItem * item = [[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"消息设置"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(messageSetting:)];
    
    self.navigationItem.rightBarButtonItem = item;

}
- (void)messageSetting:(UIBarButtonItem*)item{
    ZJlogFunction;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mrak-tableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 6;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.font = [UIFont systemFontOfSize:20];
        //cell.textLabel.text = @"cell";
        
        cell.imageView.image = returnImage(indexPath);
    }
    
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 60;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}
//-(NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section{
//    return @"1243";
//}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
UIImage * returnImage(NSIndexPath* indexPath){
    NSArray * arr = [NSArray arrayWithObjects:@"评论",@"邮件",@"投稿请求",@"喜欢",@"关注-消息",@"其他", nil];
    UIImage *image = [UIImage imageNamed:arr[indexPath.row]];
    return image;
}
@end
