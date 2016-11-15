//
//  NSWYDetialCell.m
//  DetialText
//
//  Created by Mac on 16/11/8.
//  Copyright © 2016年 HBNXWLKJ. All rights reserved.
//

#import "NSWYDetialCell.h"
#import "NSWYContent.h"
@interface NSWYDetialCell ()
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *visitorcount;
@property (weak, nonatomic) IBOutlet UILabel *content;
@property (weak, nonatomic) IBOutlet UILabel *com;
@property (weak, nonatomic) IBOutlet UIView *line;

@end


@implementation NSWYDetialCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
   self.contentView.bounds = [UIScreen mainScreen].bounds;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setEntity:(NSWYContent *)entity{
    _entity = entity;
    _title.text = entity.ftitle;
    _visitorcount.text = [NSString stringWithFormat:@"浏览量:%0.0f",entity.fvisitorcount];
    _content.text = entity.fcontent; 
}

-(CGSize)sizeThatFits:(CGSize)size{
    CGFloat totalHeight = 0;
    totalHeight += [self.title sizeThatFits:size].height;
    totalHeight+= [self.visitorcount sizeThatFits:size  ].height;
    totalHeight+=[self.content sizeThatFits:size].height;
    totalHeight+=[self.com sizeThatFits:size].height;
    totalHeight+=[self.line sizeThatFits:size].height;
    
    return CGSizeMake(size.width, totalHeight);
}

@end
