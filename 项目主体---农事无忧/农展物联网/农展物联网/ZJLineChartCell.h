//
//  ZJLineChartCell.h
//  农展物联网
//
//  Created by Mac on 2/20/17.
//  Copyright © 2017 HBNXWLKJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZJLineChartCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *TheHighest;
@property (weak, nonatomic) IBOutlet UILabel *average;
@property (weak, nonatomic) IBOutlet UILabel *Lowest;

@end
