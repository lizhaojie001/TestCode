//
//  ZJLineChartCell.m
//  农展物联网
//
//  Created by Mac on 2/20/17.
//  Copyright © 2017 HBNXWLKJ. All rights reserved.
//

#import "ZJLineChartCell.h"
#import "PNLineChartView.h"
#import "ZJData.h"
#import "PNPlot.h"
@interface ZJLineChartCell ()
@property (weak, nonatomic) IBOutlet PNLineChartView *ChartView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *unitLabel;
 

@end
@implementation ZJLineChartCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setData:(ZJData *)data{
    
    ZJLog(@"data.param %@",data.param);
    _data =data;
    //设置标题
    _titleLabel.text =data.param;
    
    //设置单位
    if ([data.param isEqualToString:@"土壤湿度"]||[data.param isEqualToString:@"空气湿度"]) {
         _unitLabel.text = @"%";
    }
    if ([data.param isEqualToString:@"溶解氧"]||[data.param isEqualToString:@"二氧化碳"]) {
        _unitLabel.text = @"ppm";
    }
    if ([data.param isEqualToString:@"空气温度"]||[data.param isEqualToString:@"土壤温度"]||[data.param isEqualToString:@"水温"]) {
         _unitLabel.text = @"℃";
    }
    if ([data.param isEqualToString:@"光照强度"] ) {
        _unitLabel.text = @"lux";
    }
    NSDictionary * dic = data.dataMap;
    
    
    
    
    
    
    
    ZJLog(@"%@",dic);
    //x轴值
    NSArray *xAxisValues =  dic.allKeys;
    NSMutableArray*xAxisValuesPlus = [NSMutableArray array];
    ZJLog(@"%@",xAxisValues);
    ZJLog(@"%@",dic.allValues);
    //y轴数据
    NSMutableArray * yValue = [NSMutableArray array];
    double maxY = 0; double minY = MAXFLOAT;
    for (int i =0; i < xAxisValues.count; i ++) {
        NSString *key =xAxisValues[i];
        NSString * value = dic[key];
        key = [key substringWithRange:NSMakeRange(11, 5)];
        [xAxisValuesPlus addObject:key];
        ZJLog(@"value: %@",value);
        double Y = [value doubleValue];
        
        [yValue addObject:@(Y)];
        ZJLog(@"yValue: %@",yValue);
        if (Y>maxY) {
            maxY =Y;
        }
        if (Y<minY) {
            minY =Y;
        }
   }
  
    _ChartView.max = maxY;
    _ChartView.min = minY;
    //间距
    _ChartView.interval = (maxY-minY)/5.0;
      NSMutableArray *yAxisValues = [@[] mutableCopy];
    for (int i=0; i<6; i++) {
        NSString* str = [NSString stringWithFormat:@"%.1f", _ChartView.min+_ChartView.interval*i];
        [yAxisValues addObject:str];
    }
    _ChartView.xAxisValues = xAxisValuesPlus;
    _ChartView.yAxisValues = yAxisValues;
   _ChartView.axisLeftLineWidth = 39;
    _ChartView.horizontalLineInterval = 40;
    _ChartView.axisLineWidth = 1;
    _ChartView.floatNumberFormatterString =@"%.1f";
    
    PNPlot *plot1 = [[PNPlot alloc] init];
    plot1.plottingValues = yValue;
    
    plot1.lineColor = ZJGreenColor;
    plot1.lineWidth = 0.5;
    
    [_ChartView addPlot:plot1];

    
}

@end
