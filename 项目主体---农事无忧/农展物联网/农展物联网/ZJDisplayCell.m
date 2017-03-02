//
//  ZJDisplayCell.m
//  农展物联网
//
//  Created by Mac on 2/28/17.
//  Copyright © 2017 HBNXWLKJ. All rights reserved.
//

#import "ZJDisplayCell.h"

@implementation ZJDisplayCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    
}


-(void)setData:(ZJData *)data{
    _data =data;
    
    self.textLabel.text = data.param;
    self.detailTextLabel.text = data.latestData;
    if ([_pavilionID  isEqual:@4] || [_pavilionID  isEqual: @5] ) {
        if ([data.param  isEqualToString: @"空气温度"] ) {
            self.textLabel.text = @"水温";
            self.detailTextLabel.text = [data.latestData stringByAppendingString:@"℃"];
        }else if ([data.param isEqualToString:@"空气湿度"]) {
            self.textLabel.text = @"溶解氧";
            self.detailTextLabel.text = [data.latestData stringByAppendingString:@"ppm"];
        }else if([data.param isEqualToString:@"土壤湿度"]) {
            self.textLabel.text = @"PH值";
        }
    }else{
        if ([data.param  isEqualToString: @"空气温度"]) {
            self.detailTextLabel.text = [data.latestData stringByAppendingString:@"℃"];
        }else if ([data.param isEqualToString:@"空气湿度"]|| [data.param isEqualToString:@"土壤湿度"]) {
            self.detailTextLabel.text = [data.latestData stringByAppendingString:@"%"];
        }
        
    }
    
    
}

@end
