//
//  author.m
//  DetialText
//
//  Created by Mac on 16/11/7.
//  Copyright © 2016年 HBNXWLKJ. All rights reserved.
//

#import "author.h"
 
#import "UIImageView+WebCache.h"
#import "UIButton+WebCache.h"
#import "nswyModel/NSWYContent.h"

@interface author ()

@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *time;
 

@end
@implementation author
-(void)awakeFromNib{
    self.avatar.layer.cornerRadius = self.avatar.frame.size.width/2;
    self.avatar.layer.masksToBounds = YES;
}
-(void)layoutSubviews{
    if (self.Follow.selected  ) {
        [self.Follow setBackgroundColor:[UIColor grayColor]];
    }else{
        [self.Follow setBackgroundColor:[UIColor colorWithRed:252/255.0 green:83/255.0 blue:32 alpha:1]];
    }
}

-(void)setModel:(NSWYContent *)model{
    _model = model;
    _name.text = model.fauthor;
    _time.text = model.fcreatetime;
    
}
 

@end
