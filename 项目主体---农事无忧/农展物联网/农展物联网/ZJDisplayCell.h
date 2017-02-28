//
//  ZJDisplayCell.h
//  农展物联网
//
//  Created by Mac on 2/28/17.
//  Copyright © 2017 HBNXWLKJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZJData.h"
#import "ZJPavilion.h"

@interface ZJDisplayCell : UITableViewCell

/**data*/
@property (nonatomic,strong) ZJData * data;

/**ID*/
@property (nonatomic,strong) NSNumber * pavilionID;


@end
