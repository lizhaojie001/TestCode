//
//  nswyCategaryController.m
//  nswy-1
//
//  Created by Mac on 16/12/31.
//  Copyright © 2016年 HBNXWLKJ. All rights reserved.
//

#import "nswyCategaryController.h"
#import "nswyCategaryCollection.h"

@interface nswyCategaryController ()
/**标记*/
@property (nonatomic ) BOOL   flag;
/**NSMutableIndexSet*/
@property (nonatomic,strong) NSMutableIndexSet * IndexSet;
/**section*/
@property (nonatomic ) NSUInteger section;

@end

@implementation nswyCategaryController
static NSString * reuseIdentifier  = @"reuseIdentifier";
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

#pragma mrak-tableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 6;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.text = @"物种分类";
        cell.detailTextLabel.text = @"cell";
        //cell.imageView.image = [UIImage imageNamed:<#@"cell"#>];
    }
    
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 44;
}

//-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
//    
//    return @"";
//}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 20   ;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 1;
}

-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    
    return [UIView new];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        nswyCategaryCollection * categary = [[nswyCategaryCollection alloc]initWithCollectionViewLayout:layout];
    [self.navigationController pushViewController:categary animated:YES];
    
}
//-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//    
//    UIButton * button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 100, 20)];
//    [button setTag:section];
//    [button setTitle:@"物种" forState:UIControlStateNormal];
//    [button setTintColor:[UIColor redColor]];
//    [button addTarget:self action:@selector(titleBtn:) forControlEvents:UIControlEventTouchUpInside];
//    return button;
//}

- (void)titleBtn:(UIButton*)button{
    button.selected = YES;
    ZJLog(@"self.flag= ==%d",self.flag);
    self.flag = !self.flag;
    ZJlogFunction;
    self.section = button.tag;
    NSIndexSet * sections = [[NSIndexSet alloc]initWithIndex:0];
   
    [self.tableView reloadSections:self.IndexSet withRowAnimation:UITableViewRowAnimationFade];
  
    
//    [self.IndexSet removeAllIndexes];
    
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (NSMutableIndexSet *)IndexSet {
	if(_IndexSet == nil) {
		_IndexSet = [[NSMutableIndexSet alloc] init];
        for (int i = 0; i < 6; i ++) {
            [_IndexSet addIndex:i];
        }
        
	}
	return _IndexSet;
}

@end
