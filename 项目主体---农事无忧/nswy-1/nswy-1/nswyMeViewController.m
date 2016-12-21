//
//  nswyMeViewController.m
//  nswy-1
//
//  Created by Mac on 16/12/2.
//  Copyright © 2016年 HBNXWLKJ. All rights reserved.
//

#import "nswyMeViewController.h"


@interface nswyMeViewController ()
@property (strong, nonatomic) IBOutlet UITableViewCell *CardCell;

@end

@implementation nswyMeViewController
static NSString * Cell = @"CardCell";
static NSString * reusedCell = @"IdentifierCell";
- (void)viewDidLoad {
    [super viewDidLoad];
     
      // [self.navigationController.navigationBar setShadowImage:[[UIImage alloc]init]];
    self.view.backgroundColor =     [UIColor whiteColor];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:reusedCell];
    UIBarButtonItem * item = [[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"设置"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal ]style:UIBarButtonItemStylePlain target:self action:@selector(setting:)];
    self.navigationItem.rightBarButtonItem = item;
    
   }

 
- (void)setting:(UIBarButtonItem * )item {
    ZJlogFunction;
    
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //去掉navigation的分割线
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc]init] forBarMetrics:UIBarMetricsDefault];
    
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc]init]];
 }

-(void)viewDidLayoutSubviews{
    
    
    self.tableView.contentInset = UIEdgeInsetsMake(44, 0, 0, 0);
}


#pragma mrak-tableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return section?6:1;
}

//- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
//    if (indexPath.section==1) {
//        CGRect newFrame = CGRectMake(cell.frame.origin.x, cell.frame.origin.y+20, cell.frame.size.width, cell.frame.size.height);
//        cell.frame = newFrame;
//    }
//
//    
//}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell * cell;
    switch (indexPath.section) {
        case 0:{
             cell = [tableView dequeueReusableCellWithIdentifier:Cell];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            NSArray * nib = [[NSBundle mainBundle] loadNibNamed:@"nswyCardCell" owner:self options:nil];
            if (nib.count>0) {
                self.CardCell = nib.firstObject;
                cell= self.CardCell;
            }
            CGRect newFrame = CGRectMake(0, 0, cell.frame.size.width, cell.frame.size.height);
            cell.frame = newFrame;

            break;
        }
        default:
            
        {
            cell = [tableView dequeueReusableCellWithIdentifier:reusedCell forIndexPath:indexPath];
          
          //  cell.separatorInset = UIEdgeInsetsMake(0, 5, 0, 20);
            cell.imageView.contentMode = UIViewContentModeCenter;
                 cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            
            switch (indexPath.row) {
                case 0:
                    cell.textLabel.text = @"动态";
                 
                    cell.imageView.image = [UIImage imageNamed:@"动态"];

                    break;
                case 1:
                    
                    cell.textLabel.text = @"收藏";
                    
                    cell.imageView.image = [UIImage imageNamed:@"收藏"];
                    
                    break;
                    case 2:
                    cell.textLabel.text = @"认证";
                    
                    cell.imageView.image = [UIImage imageNamed:@"认证"];
                    
                    break;
                    case 3:
                    cell.textLabel.text = @"聘请管理";
                    
                    cell.imageView.image = [UIImage imageNamed:@"聘请管理"];
                    break;
                    case 4:
                    cell.textLabel.text = @"生产基地";
                    
                    cell.imageView.image = [UIImage imageNamed:@"生产基地"];
                    break;
                case 5:
                    cell.textLabel.text = @"资金账户";
                    
                    cell.imageView.image = [UIImage imageNamed:@"资金账户"];
                    break;
            }
            
            
            
    }
    
    
        }
    return cell;
    

}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return indexPath.section?44:90;
}

//-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
//    
//    return [NSString stringWithFormat:@"第%ld分区",(long)section];
//}
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//    return  0;
//}
//
//-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
//    return 20;
//}

-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    if (section==1) {
        return [UIView new];

    }
    return nil;
   }

#pragma mark - ScrollViewDelegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    ZJlogFunction;
    CGRect frame =  self.navigationController.navigationBar.frame;
    CGRect newFrame = CGRectMake(frame.origin.x, frame.origin.y-frame.size.height, frame.size.width, frame.size.height);
    [UIView animateWithDuration:0.05 animations:^{
        self.navigationController.navigationBar.frame = newFrame;
    }];
    
}

-(void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView{
    CGRect frame =  self.navigationController.navigationBar.frame;
    CGRect newFrame = CGRectMake(frame.origin.x, frame.origin.y+frame.size.height, frame.size.width, frame.size.height);
    [UIView animateWithDuration:0.15 animations:^{
        self.navigationController.navigationBar.frame = newFrame;
    }];

}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    ZJlogFunction;
   //    self.navigationController.navigationBar
//    self.tabBarController.tabBar.hidden = NO;
}
@end
