//
//  author.h
//  DetialText
//
//  Created by Mac on 16/11/7.
//  Copyright © 2016年 HBNXWLKJ. All rights reserved.
//

#import <UIKit/UIKit.h>
@class NSWYContent;
@interface author : UIView
@property (weak, nonatomic) IBOutlet UIButton *avatar;
@property (weak, nonatomic) IBOutlet UIButton *Follow;
/**zjdata*/
 
/**model*/
@property (nonatomic,strong) NSWYContent * model;

@end
