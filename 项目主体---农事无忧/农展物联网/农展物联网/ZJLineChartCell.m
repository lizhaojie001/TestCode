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
    
         //x轴值
    NSArray *xAxisValues =[self sortFromTimeArray:  dic.allKeys];
    
    NSMutableArray*xAxisValuesPlus = [NSMutableArray array];
    ZJLog(@"xAxisValues %@",xAxisValues);
    ZJLog(@"dic.allValues %@",dic.allValues);
    //y轴数据
    NSMutableArray * yValue = [NSMutableArray array];
    double maxY = 0; double minY = MAXFLOAT;
    for (int i =0; i < xAxisValues.count; i ++) {
        NSString *key =xAxisValues[i];
        NSString * value = dic[key];
        key = [key substringWithRange:NSMakeRange(11, 5)];
        [xAxisValuesPlus addObject:key];
       
        double Y = [value doubleValue];
        
        [yValue addObject:@(Y)];
        
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
        NSString* str = [NSString stringWithFormat:@"%.2f", _ChartView.min+_ChartView.interval*i];
        [yAxisValues addObject:str];
    }
    _ChartView.xAxisValues = xAxisValuesPlus;
    _ChartView.yAxisValues = yAxisValues;
    [_data.param isEqualToString:@"光照强度"]? (_ChartView.axisLeftLineWidth = 65):( _ChartView.axisLeftLineWidth = 50);
 
;
      _ChartView.horizontalLineInterval = 40;
    _ChartView.axisLineWidth = 1;
    _ChartView.floatNumberFormatterString =@"%.2f";
    
    PNPlot *plot1 = [[PNPlot alloc] init];
    plot1.plottingValues = yValue;
    
    plot1.lineColor = ZJGreenColor;
    plot1.lineWidth = 0.5;
    
    [_ChartView addPlot:plot1];

    
}


-(NSArray*)sortFromTimeArray:(NSArray *)xAxisValues{
    int count = (int)xAxisValues.count;
    int a[count]  ;
    for (int i =0; i < xAxisValues.count; i ++) {
        NSString * str = [xAxisValues[i] substringWithRange:NSMakeRange(11, 2)];
        int value = [str intValue];
        a[i] = value;
    }
    
   NSArray * arr =  bubble_sort([xAxisValues mutableCopy]);
    
    return arr;
  /*
    
    NSMutableArray * xAxis = [NSMutableArray arrayWithArray:xAxisValues];
//    NSUInteger count = xAxis.count;
    int j = 0;
    for (; j < count; j ++) {
        NSString *time1 =xAxis[j];
      NSString*  hour = [time1 substringWithRange:NSMakeRange(11, 2)];
    NSString*  min = [time1 substringWithRange:NSMakeRange(14, 2)];
           int hourFirst = [hour intValue];
          int minFirst = [min intValue];
    for (int i =j+1; i <  count; i ++) {
        
          NSString *time2 =xAxis[i];
        //比较小时
   
       NSString* hour2 = [time2 substringWithRange:NSMakeRange(11, 2)];
     
        int hourSecond = [hour2 intValue];
        
       if (hourFirst>hourSecond) {
           NSString* first = xAxis[j];
           xAxis[j]= xAxis[i];
           xAxis[i] =first;
       }
//       }else if(hourFirst ==hourSecond){
//       
//           NSString* min2 = [time2 substringWithRange:NSMakeRange(14, 2)];
//         
//           int minSecond = [min2 intValue];
//           if (minFirst > minSecond) {
//               NSString* first = xAxis[j+1];
//               xAxis[j+1]= xAxis[i];
//               xAxis[i] =first;
//               
//               NSString* second = xAxis[j];
//               xAxis[j]= xAxis[j+1];
//               xAxis[j+1] = second;
//               
//
//           }
           
//       }
         }
//
        
        
    }
    
    return xAxis;
   */
}


NSArray *  bubble_sort(NSMutableArray * xAxisValues  ){
    int n = (int)xAxisValues.count;
    int a[n] ;
    int b[n];
    for (int i =0; i < n; i ++) {
        NSString * str = [xAxisValues[i] substringWithRange:NSMakeRange(11, 2)];
        int value = [str intValue];
        a[i] = value;
    }
    
    int i , j ,t ;
    BOOL change;
    for (i =n -1 ,change = TRUE; i>1&&change; -- i ) {
        change = FALSE;
        for (j=0; j<i; ++j) {
            if (a[j]>a[j+1]) {
                t= a[j];
                NSString * first = xAxisValues[j];
                xAxisValues[j] = xAxisValues[j+1];
                xAxisValues[j+1] = first;
                a[j]=a[j+1];
                a[j+1]=t;
                change =TRUE;
            }
        }
        
        
    }
    
    
    
    return bubble_sort2(xAxisValues);
}
NSArray *  bubble_sort2(NSMutableArray * xAxisValues  ){
    int n = (int)xAxisValues.count;
   
    int a[n] ;
    int b[n];
    for (int i =0; i < n; i ++) {
        NSString * str = [xAxisValues[i] substringWithRange:NSMakeRange(11, 2)];
        int value = [str intValue];
        a[i] = value;
    }

    for (int i =0; i < n; i ++) {
        NSString * str = [xAxisValues[i] substringWithRange:NSMakeRange(14, 2)];
        int value = [str intValue];
        b[i] = value;
    }
    
    int i , j ,t ;
    BOOL change;
    for (i =n -1 ,change = TRUE; i>1&&change; -- i ) {
        change = FALSE;
        for (j=0; j<i; ++j) {
            if (a[j]==a[j+1]) {
                
                if(b[j]>b[j+1]){
                t= b[j];
                NSString * first = xAxisValues[j];
                xAxisValues[j] = xAxisValues[j+1];
                xAxisValues[j+1] = first;
                b[j]=b[j+1];
                b[j+1]=t;
                change =TRUE;
                }
            }
        }
        
        
    }
    
    return xAxisValues;
}



@end
