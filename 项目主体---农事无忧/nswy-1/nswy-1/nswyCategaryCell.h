//
//  nswyCategaryCell.h
//  nswy-1
//
//  Created by Mac on 16/12/31.
//  Copyright © 2016年 HBNXWLKJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface nswyCategaryCell : UICollectionViewCell
/***/
@property (nonatomic,strong) UILabel * label;
/**文字*/
@property (nonatomic,copy) NSString * text;
/**最大宽度*/
@property (nonatomic,assign) CGFloat maxWidth;
/**size*/
@property (nonatomic,assign) CGSize size;

 
+(CGSize)sizeForContentString:(NSString*)s forMaxWidth:(CGFloat)maxWidth;


@end
