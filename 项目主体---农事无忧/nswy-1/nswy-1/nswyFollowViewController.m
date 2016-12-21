//
//  nswyFollowViewController.m
//  nswy-1
//
//  Created by Mac on 16/12/2.
//  Copyright © 2016年 HBNXWLKJ. All rights reserved.
//

#import "nswyFollowViewController.h"
#import "nswyFollowCell.h"
#import "PYSearch.h"
#import "PYTempViewController.h"
#import "PellTableViewSelect.h"

@interface nswyFollowViewController ()<PYSearchViewControllerDelegate,UISearchBarDelegate>
/**搜索框*/
@property (nonatomic,strong) UISearchBar * serachBar;

@end

@implementation nswyFollowViewController
static NSString * followCell = @"followCell";
/**
 *设置searchBar
 */
- (void)setUpSearchBar{
     UISearchBar * searchBar = [[UISearchBar alloc]init];
    searchBar.placeholder = @"搜索你要关注的内容或专家";
    searchBar.searchBarStyle = UISearchBarStyleMinimal;
    self.serachBar = searchBar;
    self.serachBar.delegate = self;
    [self.view addSubview:self.serachBar];
}
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar{
    //跳转:
    ZJLog(@"跳转");
    // 1.创建热门搜索
    NSArray *hotSeaches = @[@"Java", @"Python", @"Objective-C", @"Swift", @"C", @"C++", @"PHP", @"C#", @"Perl", @"Go", @"JavaScript", @"R", @"Ruby", @"MATLAB"];
    // 2. 创建控制器
    PYSearchViewController *searchViewController = [PYSearchViewController searchViewControllerWithHotSearches:hotSeaches searchBarPlaceholder:@"搜索编程语言" didSearchBlock:^(PYSearchViewController *searchViewController, UISearchBar *searchBar, NSString *searchText) {
        // 开始搜索执行以下代码
        // 如：跳转到指定控制器
        [searchViewController.navigationController pushViewController:[[PYTempViewController alloc] init] animated:YES];
    }];
    // 3. 设置风格
    // 选择热门搜索
        searchViewController.hotSearchStyle = PYHotSearchStyleColorfulTag; // 热门搜索风格根据选择
        searchViewController.searchHistoryStyle = PYHotSearchStyleDefault; // 搜索历史风格为default
   
    // 4. 设置代理
    searchViewController.delegate = self;
    // 5. 跳转到搜索控制器
   
    [self.navigationController pushViewController:searchViewController animated:YES];
    return NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpSearchBar];
     self.tableView.showsVerticalScrollIndicator = NO;
    
    
    UIBarButtonItem * item = [[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"添加关注"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(addFoucs:)];
    
    self.navigationItem.leftBarButtonItem = item;
    
   UIButton * titleBtn= [UIButton buttonWithType:UIButtonTypeCustom];
   [titleBtn setFrame:CGRectMake(0, 0, 130, 44)];
    
    /**
     *  不自动拉伸内部对象 自动布局使用
     */
    // titleBtn.translatesAutoresizingMaskIntoConstraints = !titleBtn.translatesAutoresizingMaskIntoConstraints;
    titleBtn.imageEdgeInsets = UIEdgeInsetsMake(0,100, 0, 0);
    titleBtn.titleEdgeInsets = UIEdgeInsetsMake(0, -30, 0, 0);
    

//    [titleBtn titleRectForContentRect:CGRectMake(0, 0, 100, 40)];
    [titleBtn setTitle:@"全部关注" forState:UIControlStateNormal];
    [titleBtn setImage:[UIImage imageNamed:@"箭头上"] forState:UIControlStateNormal];
      [titleBtn setImage:[UIImage imageNamed:@"箭头下"] forState:UIControlStateSelected];
    [titleBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [titleBtn addTarget:self action:@selector(selectFocus:) forControlEvents:UIControlEventTouchUpInside];
      ZJLog(@"%@",NSStringFromCGRect([titleBtn imageRectForContentRect:CGRectMake(100, 0, 24, 24 )]));
//    [titleBtn setContentCompressionResistancePriority:UILayoutPriorityDefaultHigh forAxis:UILayoutConstraintAxisHorizontal];
//        [titleBtn setContentCompressionResistancePriority:UILayoutPriorityDefaultHigh forAxis:UILayoutConstraintAxisVertical];
    self.navigationItem.titleView =titleBtn;
    
  //  self.tableView.contentInset = UIEdgeInsetsMake(40, 0, 0, 0);
    
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([nswyFollowCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:followCell];
    
}

-(void)addFoucs:(UIBarButtonItem * )item{

    ZJlogFunction;
}



-(void)viewDidLayoutSubviews{
    self.tableView.frame = CGRectMake(0, 40, ZJScreenW, ZJScreenH-40);
    self.serachBar.frame = CGRectMake(0,-40, ZJScreenW, 40);
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 10;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (!indexPath.row) {
        UITableViewCell * cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        cell.imageView.image = [UIImage imageNamed:@"圈子"];
        cell.textLabel.text = @"圈子";
        
        return cell;
    }
    nswyFollowCell * cell = [tableView dequeueReusableCellWithIdentifier:followCell forIndexPath:indexPath];
    UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 60, 60)];
    label.font = [UIFont systemFontOfSize:50];
    label.text = @"物";
    
    [cell.imageView addSubview:label];
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 80;
}



#pragma mark - PYSearchViewControllerDelegate 搜索框
- (void)searchViewController:(PYSearchViewController *)searchViewController searchTextDidChange:(UISearchBar *)seachBar searchText:(NSString *)searchText
{
    if (searchText.length) { // 与搜索条件再搜索
        // 根据条件发送查询（这里模拟搜索）
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{ // 搜素完毕
            // 显示建议搜索结果
            NSMutableArray *searchSuggestionsM = [NSMutableArray array];
            for (int i = 0; i < arc4random_uniform(5) + 10; i++) {
                NSString *searchSuggestion = [NSString stringWithFormat:@"搜索建议 %d", i];
                [searchSuggestionsM addObject:searchSuggestion];
            }
            // 返回
            searchViewController.searchSuggestions = searchSuggestionsM;
        });
    }
}

#pragma mark -PellTableViewSelect 关注
- (void)selectFocus:(UIButton *)sender{
    ZJLog(@"%i",sender.selected);
    sender.selected =!sender.selected;
    NSArray * arr =@[@"全部关注",@"关注专题",@"关注专家",@"只查看推送"];
    [PellTableViewSelect addPellTableViewSelectWithWindowFrame:CGRectMake(sender.frame.origin.x,sender.frame.origin.y , 150,150) selectData:arr images:nil action:^(NSInteger index) {
        NSLog(@"选择%ld",index);
        if (sender.selected) {
              sender.selected = NO;
        }
      
        [sender setTitle:arr[index] forState:UIControlStateNormal];
       
       //[sender setImage:[UIImage imageNamed:@"箭头向上"] forState:UIControlStateNormal];
        
    } animated:YES];
    
}
@end
