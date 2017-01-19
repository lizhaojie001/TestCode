//
//  nswyCategaryCollection.m
//  nswy-1
//
//  Created by Mac on 16/12/31.
//  Copyright © 2016年 HBNXWLKJ. All rights reserved.
//

#import "nswyCategaryCollection.h"
#import "nswyCategaryCell.h"
#import "nswyCategaryHeaderCell.h"

@interface nswyCategaryCollection ()<UICollectionViewDelegateFlowLayout>
/**<#注释#>*/
@property (nonatomic,strong) NSArray * sections;

/**第一个分区*/
@property (nonatomic,strong) NSMutableArray  * firstSection;
/**第二个分区*/
@property (nonatomic,strong) NSMutableArray  * secondSection;

@end

@implementation nswyCategaryCollection

static NSString * const reuseIdentifier = @"reuseIdentifier";
static NSString * const HeatherreuseIdentifier = @"HeatherreuseIdentifier";
- (void)viewDidLoad {
    [super viewDidLoad];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
//    UICollectionViewLayout * layout = self.collectionView.collectionViewLayout;
//    UICollectionViewFlowLayout * flow = (UICollectionViewFlowLayout*)layout;
//    flow.sectionInset = UIEdgeInsetsMake(10, 100,
                                        // 30, 20);
    
    // Register cell classes
    [self.collectionView registerClass:[nswyCategaryCell class] forCellWithReuseIdentifier:reuseIdentifier];
    [self.collectionView registerClass:[nswyCategaryHeaderCell class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:HeatherreuseIdentifier];
    // Do any additional setup after loading the view.
    //flow.headerReferenceSize = CGSizeMake(100, 25);
}

- (NSArray *)wordsInSection:(NSInteger)section{
     NSArray * words = self.sections[section][@"content"];
    
   
    return words;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
#warning Incomplete implementation, return the number of sections
    return [self.sections count];
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of items
    switch (section) {
        case 0:
            return self.firstSection.count;
            
            
        default:
            return self.secondSection.count;
           
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    
    nswyCategaryCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.maxWidth =collectionView.bounds.size.width;
    switch (indexPath.section) {
        case 0:
            cell.text = self.firstSection[indexPath.item];
            break;
            
        default:
            cell.text = self.secondSection[indexPath.item];

            break;
    }
  
    
   
     cell.backgroundColor = ZJRomColor;
    
    return cell;
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    if ([kind isEqual:UICollectionElementKindSectionHeader]) {
        nswyCategaryHeaderCell * cell = [self.collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:HeatherreuseIdentifier forIndexPath:indexPath];
        cell.maxWidth = collectionView.bounds.size.width;
        cell.text = self.sections[indexPath.section][@"header"];
        return cell;
    }
    return nil;
}
#pragma mark <UICollectionViewDelegate>


 //Uncomment this method to specify if the specified item should be highlighted during tracking
//- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
//	return YES;
//}
// 
//
//
//// Uncomment this method to specify if the specified item should be selected
//- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
//    return YES;
//}
// 

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

- (NSArray *)sections {
	if(_sections == nil) {
		_sections = @[@{@"header": @"已关注物种分类 Witch",@"content":@[@"27",@"5dfd",@"fgdjkdfdsfsafgdjkgfdagfjk",@"fgdjkafgdjkgfdagfjk"]},
                      
  @{@"header":@"未关注物种分类",@"content":@[@"纤维类",@"油料类",@"糖类",@"燃料类",@"粮食类",@"纤维类",@"油料类",@"糖类",@"燃料类",@"粮食类"]}
    ];
    
    }
	return _sections;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    ZJlogFunction;
    ZJLog(@"section= %ld row =%ld",(long)indexPath.section , (long)indexPath.row);
    if (!indexPath.section) {
        [collectionView performBatchUpdates:^{
            [self.secondSection addObject:self.firstSection[indexPath.item]];
            NSIndexPath *index = [NSIndexPath indexPathForItem:self.secondSection.count-1 inSection:indexPath.section+1];
            [self.firstSection removeObjectAtIndex:indexPath.item];
            [collectionView moveItemAtIndexPath:indexPath toIndexPath:index];
            
        } completion:^(BOOL finished) {
            
        }];
        

    }
    else{
        [collectionView performBatchUpdates:^{
            [self.firstSection addObject:self.secondSection[indexPath.item]];
            NSIndexPath * index =[NSIndexPath indexPathForItem:self.firstSection.count-1 inSection:indexPath.section-1];
            [self.secondSection removeObjectAtIndex:indexPath.item];
            [collectionView moveItemAtIndexPath:indexPath toIndexPath:index];

        } completion:nil];
        
    }
    
  
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
   // ZJlogFunction;
    ZJLog(@"%lu",(unsigned long)self.firstSection.count);
    CGSize size = [nswyCategaryCell sizeForContentString:indexPath.section?self.secondSection[indexPath.item]:self.firstSection[indexPath.item] forMaxWidth:collectionView.frame.size.width];
    return size;
    
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(5, 5, 10, 20);
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    
    return 10;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    
    return 20;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    
    return CGSizeMake(200, 50);
}
#pragma mark  移动items





#pragma mark 懒加载
- (NSMutableArray *)firstSection {
	if(_firstSection == nil) {
		 
        _firstSection =[NSMutableArray arrayWithArray: self.sections.firstObject[@"content"]];
	}
	return _firstSection;
}

- (NSMutableArray *)secondSection {
	if(_secondSection == nil) {
        _secondSection = [NSMutableArray arrayWithArray:self.sections.lastObject[@"content"]];
        
	}
	return _secondSection;
}





@end
