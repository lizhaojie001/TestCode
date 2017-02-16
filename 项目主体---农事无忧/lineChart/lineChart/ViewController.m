//
//  ViewController.m
//  lineChart
//
//  Created by Mac on 17/2/10.
//  Copyright © 2017年 HBNXWLKJ. All rights reserved.
//

#import "ViewController.h"
#import "BEMSimpleLineGraphView.h"
#import "PNChart.h"

@interface ViewController ()<BEMSimpleLineGraphDelegate, BEMSimpleLineGraphDataSource>
/**宽度*/
@property (nonatomic,assign) CGFloat  width   ;
/**<#注释#>*/
@property (nonatomic,weak) BEMSimpleLineGraphView * Graph;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self setupScrollowView];
}
-(void)setupPNChart{
    
    //For Line Chart
    PNLineChart * lineChart = [[PNLineChart alloc] initWithFrame:CGRectMake(0, 135.0, SCREEN_WIDTH, 200.0)];
    [lineChart setXLabels:@[@"SEP 1",@"SEP 2",@"SEP 3",@"SEP 4",@"SEP 5"]];
    
    // Line Chart No.1
    NSArray * data01Array = @[@60.1, @160.1, @126.4, @262.2, @186.2];
    PNLineChartData *data01 = [PNLineChartData new];
    data01.color = PNFreshGreen;
    data01.itemCount = lineChart.xLabels.count;
    data01.getData = ^(NSUInteger index) {
        CGFloat yValue = [data01Array[index] floatValue];
        return [PNLineChartDataItem dataItemWithY:yValue];
    };
    // Line Chart No.2
    NSArray * data02Array = @[@20.1, @180.1, @26.4, @202.2, @126.2];
    PNLineChartData *data02 = [PNLineChartData new];
    data02.color = PNTwitterColor;
    data02.itemCount = lineChart.xLabels.count;
    data02.getData = ^(NSUInteger index) {
        CGFloat yValue = [data02Array[index] floatValue];
        return [PNLineChartDataItem dataItemWithY:yValue];
    };
    
    lineChart.chartData = @[data01, data02];
    [lineChart strokeChart];
    
    
    
}



- (void)setupScrollowView{
    CGRect rect = CGRectMake(0, 100, self.view.frame.size.width, 300);
    
    UIScrollView * sw = [[UIScrollView alloc]initWithFrame:rect];
    sw.backgroundColor =[UIColor grayColor];
     CGRect rect1 = CGRectMake(0, 0, (self.view.frame.size.width-40)*2, 250);
    BEMSimpleLineGraphView * Graph = [[BEMSimpleLineGraphView alloc]initWithFrame:rect1];
    CGSize size =Graph.frame.size;
    sw.contentSize = CGSizeMake(size.width, size.height);
    sw.contentInset = UIEdgeInsetsMake(0, 10, 0, 10);
    sw.bounces =NO;
    Graph.delegate= self;
    Graph.dataSource =self;
    
    
    // Create a gradient to apply to the bottom portion of the graph
    CGColorSpaceRef colorspace = CGColorSpaceCreateDeviceRGB();
    size_t num_locations = 2;
    CGFloat locations[2] = { 0.0, 1.0 };
    CGFloat components[8] = {
        1.0, 1.0, 1.0, 1.0,
        1.0, 1.0, 1.0, 0.0
    };
    
    // Apply the gradient to the bottom portion of the graph
     Graph.gradientBottom = CGGradientCreateWithColorComponents(colorspace, components, locations, num_locations);

    //属性设置
    Graph.enableReferenceXAxisLines =YES;//
    Graph.enableReferenceYAxisLines = YES;
    Graph.enableReferenceAxisFrame = YES;
    
    Graph.autoScaleYAxis = YES;
    Graph.alwaysDisplayDots = NO;
    
//    Graph.enableBottomReferenceAxisFrameLine =YES;
//    Graph.enableTopReferenceAxisFrameLine =YES;
//    Graph.enableRightReferenceAxisFrameLine =YES;
    Graph.alwaysDisplayPopUpLabels =YES;
    Graph.lineDashPatternForReferenceYAxisLines =@[@2,@2];
    Graph.lineDashPatternForReferenceXAxisLines = @[@3,@3];
    //X轴
  
    Graph.enableXAxisLabel = YES;
    Graph.colorXaxisLabel = [UIColor blackColor];
    Graph.colorBackgroundXaxis = [UIColor whiteColor];
    Graph.alphaBackgroundXaxis = 0.8;
    //Y轴
    Graph.enableYAxisLabel = YES;
     Graph.colorYaxisLabel = [UIColor redColor];
    Graph.colorBackgroundYaxis = [UIColor whiteColor];
    Graph.alphaBackgroundYaxis = 0.8;
    Graph.formatStringForValues= @"%.2f";

     //colorTop
   Graph.colorTop = [UIColor clearColor];
    Graph.alphaTop = 0.8;
   
    
    //colorLine
    Graph.colorLine = [UIColor whiteColor];
    Graph.alphaLine = 0.8;
    //widthLine
    Graph.widthLine = 2;
    
    //colorBottom
     Graph.colorBottom = [UIColor greenColor];
    Graph.alphaBottom = 0.8;
    
    //colorPoint
    Graph.colorPoint = [UIColor greenColor];
    
    //sizePoint
    Graph.sizePoint = 10.0;
    
//    //colorXaxisLabel
//    Graph.colorXaxisLabel = [UIColor whiteColor];
//    
//    //colorYaxisLabel
//    Graph.colorYaxisLabel = [UIColor whiteColor];
    //colorTouchInputLine
    Graph.colorTouchInputLine = [UIColor grayColor];
    Graph.alphaTouchInputLine = 0.8;
    
    //widthTouchInputLine
    Graph.widthTouchInputLine = 0.5;
    
    //colorBackgroundPopUplabel
    Graph.colorBackgroundPopUplabel = [UIColor colorWithWhite:0.8 alpha:0.8];
    
    
    //Animation Speed
    Graph.animationGraphEntranceTime = 1.5;
    //Animation Style
    Graph.animationGraphStyle =  BEMLineAnimationNone;
    
    
   // Touch Reporting (Interactive Graph)
    
    //Popup Reporting
    Graph.enablePopUpReport = YES;
    
    //Touch Reporting
    Graph.enableTouchReport = YES;
    
    //Average Line
    Graph.averageLine.enableAverageLine = YES;
    Graph.averageLine.color = [UIColor redColor];
    Graph.averageLine.width = 1.0;
    Graph.averageLine.alpha = 0.2;
    Graph.averageLine.dashPattern = @[@2,@3];
    Graph.averageLine.yValue = [Graph calculatePointValueAverage].floatValue;
    //enableBezierCurve = YES;
    Graph.enableBezierCurve = NO;
     [sw addSubview:Graph];
    [self.view addSubview:sw];
    
}
#pragma mark -BEMSimpleLineGraphDelegate

//----- GRAPH EVENTS -----//


/** Sent to the delegate each time the line graph is loaded or reloaded.
 @seealso lineGraphDidFinishLoading:
 @param graph The graph object that is about to be loaded or reloaded. */
//- (void)lineGraphDidBeginLoading:(BEMSimpleLineGraphView *)graph{
//    NSLog(@"%s",__func__);
//}


/** Sent to the delegate each time the line graph finishes loading or reloading.
 @discussion The respective graph object's data has been loaded at this time. However, the graph may not be fully rendered. Use this method to update any content with the new graph object's data.
 
 @seealso lineGraphDidBeginLoading: lineGraphDidFinishDrawing:
 @param graph The graph object that finished loading or reloading. */
//- (void)lineGraphDidFinishLoading:(BEMSimpleLineGraphView *)graph{
//     NSLog(@"%s",__func__);
//}


/** Sent to the delegate each time the line graph finishes animating and drawing.
 @discussion The respective graph object has been completely drawn and animated at this point. It is safe to use \p graphSnapshotImage after recieving this method call on the delegate.
 
 This method may be called in addition to the \p lineGraphDidFinishLoading: method, after drawing has completed. \p animationGraphEntranceTime is taken into account when calling this method.
 
 @seealso lineGraphDidFinishLoading:
 @param graph The graph object that finished drawing. */
- (void)lineGraphDidFinishDrawing:(BEMSimpleLineGraphView *)graph{
     NSLog(@"%s",__func__);
}


//----- CUSTOMIZATION -----//


/** The optional suffix to append to the popup report.
 @param graph The graph object requesting the total number of points.
 @return The suffix to append to the popup report. */
//- (NSString *)popUpSuffixForlineGraph:(BEMSimpleLineGraphView *)graph{
//     NSLog(@"%s",__func__);
//    return @"suffix";
//}


/** The optional prefix to append to the popup report.
 @param graph The graph object requesting the total number of points.
 @return The prefix to prepend to the popup report. */
//- (NSString *)popUpPrefixForlineGraph:(BEMSimpleLineGraphView *)graph{
//     NSLog(@"%s",__func__);
//    return @"prefix";
//}

/** Optional method to always display some of the pop up labels on the graph.
 @see alwaysDisplayPopUpLabels must be set to YES for this method to have any affect.
 @param graph The graph object requesting the total number of points.
 @param index The index from left to right of the points on the graph. The first value for the index is 0.
 @return Return YES if you want the popup label to be displayed for this index. */
//- (BOOL)lineGraph:(BEMSimpleLineGraphView *)graph alwaysDisplayPopUpAtIndex:(CGFloat)index{
//     NSLog(@"%s",__func__);
//    return NO;
//}

/** Optional method to set the maximum value of the Y-Axis. If not implemented, the maximum value will be the biggest point of the graph.
 @param graph The graph object requesting the maximum value.
 @return The maximum value of the Y-Axis. */
//- (CGFloat)maxValueForLineGraph:(BEMSimpleLineGraphView *)graph{
//     NSLog(@"%s",__func__);
//    return 100;
//}


/** Optional method to set the minimum value of the Y-Axis. If not implemented, the minimum value will be the smallest point of the graph.
 @param graph The graph object requesting the minimum value.
 @return The minimum value of the Y-Axis. */
//- (CGFloat)minValueForLineGraph:(BEMSimpleLineGraphView *)graph{
//     NSLog(@"%s",__func__);
//    
//    return 10;
//}


/** Optional method to control whether a label indicating NO DATA will be shown while number of data is zero
 @param graph The graph object for the NO DATA label
 @return The boolean value indicating the availability of the NO DATA label. */
//- (BOOL)noDataLabelEnableForLineGraph:(BEMSimpleLineGraphView *)graph{
//     NSLog(@"%s",__func__);
//    return YES;
//}


/** Optional method to control the text to be displayed on NO DATA label
 @param graph The graph object for the NO DATA label
 @return The text to show on the NO DATA label. */
//- (NSString *)noDataLabelTextForLineGraph:(BEMSimpleLineGraphView *)graph{
//     NSLog(@"%s",__func__);
//    return @"noDataLabelTextForLineGraph";
//}


/** Optional method to set the static padding distance between the graph line and the whole graph
 @param graph The graph object requesting the padding value.
 @return The padding value of the graph. */
//- (CGFloat)staticPaddingForLineGraph:(BEMSimpleLineGraphView *)graph{
//     NSLog(@"%s",__func__);
//    return 5;
//}


/** Optional method to return a custom popup view to be used on the chart
 @param graph The graph object requesting the padding value.
 @return The custom popup view to use */
//- (UIView *)popUpViewForLineGraph:(BEMSimpleLineGraphView *)graph{
//    
//     NSLog(@"%s",__func__);
//    UIView * v =[UIView new];
//    CGRect frame = v.frame;
//    frame.size = CGSizeMake(30, 30);
//    v.frame =frame;
//    v.backgroundColor = [UIColor redColor];
//    return v;
//}


/** Optional method that gets called if you are using a custom popup view.  This method allows you to modify your popup view for different graph indices
 @param graph The graph object requesting the padding value.
 @param popupView The popup view owned by the graph that needs to be modified
 @param index The index of the element associated with the popup view
 @return The custom popup view to use */
- (void)lineGraph:(BEMSimpleLineGraphView *)graph modifyPopupView:(UIView *)popupView forIndex:(NSUInteger)index{
     NSLog(@"%s",__func__);
}


//----- TOUCH EVENTS -----//


/** Sent to the delegate when the user starts touching the graph. The property 'enableTouchReport' must be set to YES.
 @param graph The graph object which was touched by the user.
 @param index The closest index (X-axis) from the location the user is currently touching. */
- (void)lineGraph:(BEMSimpleLineGraphView *)graph didTouchGraphWithClosestIndex:(NSInteger)index{
     NSLog(@"%s",__func__);
}


/** Sent to the delegate when the user stops touching the graph.
 @param graph The graph object which was touched by the user.
 @param index The closest index (X-axis) from the location the user last touched. */
- (void)lineGraph:(BEMSimpleLineGraphView *)graph didReleaseTouchFromGraphWithClosestIndex:(CGFloat)index{
     NSLog(@"%s",__func__);
}


//----- X AXIS -----//


/** The number of free space between labels on the X-axis to avoid overlapping.
 @discussion For example returning '1' would mean that half of the labels on the X-axis are not displayed: the first is not displayed, the second is, the third is not etc. Returning '0' would mean that all of the labels will be displayed. Finally, returning a value equal to the number of labels will only display the first and last label.
 @param graph The graph object which is requesting the number of gaps between the labels.
 @return The number of labels to "jump" between each displayed label on the X-axis. */
/**
 *  label的数量
 *
 *  @param graph 0 表示全部展示
 * 和label数量相同展示 第一个和最后一个
 *
 *  @return <#return value description#>
 */
- (NSInteger)numberOfGapsBetweenLabelsOnLineGraph:(BEMSimpleLineGraphView *)graph{
     NSLog(@"%s",__func__);
    return 2;
}


/** The starting index to plot X-Axis values.  MUST ALSO IMPLEMENT incrementIndexForXAxisOnLineGraph FOR THIS TO TAKE EFFECT
 @discussion This allows you to specify a custom starting index for drawing x axis labels
 @param graph The graph object which is requesting the number of gaps between the labels.
 @return The graph data index to begin drawing labels */
//- (NSInteger)baseIndexForXAxisOnLineGraph:(BEMSimpleLineGraphView *)graph{
//     NSLog(@"%s",__func__);
//    return 0;
//}


/** The increment to apply when drawing X-Axis labels.  This increment is applied to the base x axis index.  MUST ALSO IMPLEMENT baseIndexForXAxisOnLineGraph FOR THIS TO TAKE EFFECT
 @discussion This allows you to set a custom interval in drawing x axis labels. When this is set in conjuction with baseIndexForXAxisOnLineGraph, `numberOfGapsBetweenLabelsOnLineGraph` is ignored
 @param graph The graph object which is requesting the number of gaps between the labels.
 @return The increment between X-Axis labels */
//- (NSInteger)incrementIndexForXAxisOnLineGraph:(BEMSimpleLineGraphView *)graph{
//     NSLog(@"%s",__func__);
//    return 2;
//}


/** An array of graph indices where X-Axis labels should be drawn
 @discussion This allows high customization over where X-Axis labels can be placed.  They can be placed in non-consistent intervals. Additionally,
 it allows you to draw the X-Axis labels based on traits of your data (eg. when the date corresponding to the data becomes a new day).
 When this is set, `numberOfGapsBetweenLabelsOnLineGraph` is ignored
 @param graph The graph object which is requesting the number of gaps between the labels.
 @return Array of graph indices to place X-Axis labels */
//- (NSArray *)incrementPositionsForXAxisOnLineGraph:(BEMSimpleLineGraphView *)graph{
//     return @[]
//}



//----- Y AXIS -----//


/** The total number of Y-axis labels on the line graph.
 @discussion Calculates the total height of the graph and evenly spaces the labels based on the graph height. Default value is 3.
 @param graph The graph object which is requesting the number of labels.
 @return The number of labels displayed on the Y-axis. */

- (NSInteger)numberOfYAxisLabelsOnLineGraph:(BEMSimpleLineGraphView *)graph{
     NSLog(@"%s",__func__);
    return 3;
}


/** The optional prefix to append to the y axis.
 @param graph The graph object requesting the total number of points.
 @return The prefix to prepend to append to the y axis. */
//- (NSString *)yAxisPrefixOnLineGraph:(BEMSimpleLineGraphView *)graph{
//     NSLog(@"%s",__func__);
//    return @"温度";
//}


/** The optional suffix to append to the y axis.
 @param graph The graph object requesting the total number of points.
 @return The suffix to prepend to append to the y axis. */
- (NSString *)yAxisSuffixOnLineGraph:(BEMSimpleLineGraphView *)graph{
     NSLog(@"%s",__func__);
    return @"℃";
}


/** Starting value to begin drawing Y-Axis labels  MUST ALSO IMPLEMENT incrementValueForYAxisOnLineGraph FOR THIS TO TAKE EFFECT
 @discussion This allows you to finally hone the granularity of the data label.  Instead of drawing values like 11.24,
 you can lock these values to draw 11.20 to make it more user friendly.  When this is set, `numberOfYAxisLabelsOnLineGraph` is ignored.
 @param graph The graph object which is requesting the number of gaps between the labels.
 @return The base value to draw the first Y-Axis label */
//- (CGFloat)baseValueForYAxisOnLineGraph:(BEMSimpleLineGraphView *)graph{
//    
//     NSLog(@"%s",__func__);
//    return 5;
//}


/** Increment value to apply to the base Y-Axis label.  MUST ALSO IMPLEMENT baseValueForYAxisOnLineGraph FOR THIS TO TAKE EFFECT
 @discussion This value tells the graph the interval to be applied to the base Y-Axis value.  This allows you to increment the Y-Axis via user-friendly values rather than values
 like 37.17.  This let's you enforce that your Y-Axis have values rounded to whatever granularity best fits your data.
 @param graph The graph object which is requesting the number of gaps between the labels.
 @return The increment value to add to the value returned from `baseValueForYAxisOnLineGraph` for future Y-Axis labels */
//- (CGFloat)incrementValueForYAxisOnLineGraph:(BEMSimpleLineGraphView *)graph{
//     NSLog(@"%s",__func__);
//    return 0.1;
//}

#pragma mark -BEMSimpleLineGraphDataSource
//----- DATA POINTS -----//


/** The number of points along the X-axis of the graph.
 @param graph The graph object requesting the total number of points.
 @return The total number of points in the line graph. */
//多少个点
- (NSInteger)numberOfPointsInLineGraph:(BEMSimpleLineGraphView *)graph{
     NSLog(@"%s",__func__);
    return 20;
}


/** The vertical position for a point at the given index. It corresponds to the Y-axis value of the Graph.
 @param graph The graph object requesting the point value.
 @param index The index from left to right of a given point (X-axis). The first value for the index is 0.
 @return The Y-axis value at a given index. */
//每个点的Y值
- (CGFloat)lineGraph:(BEMSimpleLineGraphView *)graph valueForPointAtIndex:(NSInteger)index{
     NSLog(@"%s",__func__);
    return  arc4random()%10/10.0+10;
}
- (NSString *)labelForDateAtIndex:(NSInteger)index {
    NSDate *date = [NSDate date];
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    df.dateFormat = @"HH:mm:ss";
    NSString *label = [df stringFromDate:date];
    return label;
}
//------- X AXIS -------//

/** The string to display on the label on the X-axis at a given index.
 @discussion The number of strings to be returned should be equal to the number of points in the graph (returned in \p numberOfPointsInLineGraph). Otherwise, an exception may be thrown.
 @param graph The graph object which is requesting the label on the specified X-Axis position.
 @param index The index from left to right of a given label on the X-axis. Is the same index as the one for the points. The first value for the index is 0. */
 
- (NSString *)lineGraph:(BEMSimpleLineGraphView *)graph labelOnXAxisForIndex:(NSInteger)index {
    NSString * label = [self labelForDateAtIndex:index];
    return [label stringByReplacingOccurrencesOfString:@" " withString:@"\n"];
}
@end
