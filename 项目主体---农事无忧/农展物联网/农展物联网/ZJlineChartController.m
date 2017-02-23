//
//  ZJlineChartController.m
//  农展物联网
//
//  Created by Mac on 2/20/17.
//  Copyright © 2017 HBNXWLKJ. All rights reserved.
//

#import "ZJlineChartController.h"
#import <BEMSimpleLineGraphView.h>
#import "ZJLineChartCell.h"
@interface ZJlineChartController ()<BEMSimpleLineGraphDelegate,BEMSimpleLineGraphDataSource,UITableViewDelegate,UITableViewDataSource>
/**
 *  PH
 */
@property (weak, nonatomic) IBOutlet UIView *PHView;
/**
 *  温度
 */
@property (weak, nonatomic) IBOutlet UIView *TemperatureView;
/**
 *  溶解氧
 */
@property (weak, nonatomic) IBOutlet UIView *DOView;

/**BEMSimpleLineGraphView*/
@property (nonatomic,weak) BEMSimpleLineGraphView * Graph;

/**tableView*/
@property (nonatomic,weak) UITableView * tableView;

/**背景视图*/
@property (nonatomic,weak) UIScrollView * scrollView;

@end

@implementation ZJlineChartController
static NSString * Identifier = @"cell";
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
//    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = ZJBGColor;
    
//    [self setupTableView];
//    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([ZJLineChartCell class]) bundle:nil] forCellReuseIdentifier:Identifier];
    
    [self setupScrollowView];
}


- (void)setupTableView{
    
    UITableView * table = [[UITableView alloc] initWithFrame:ZJScreenBounds style:UITableViewStyleGrouped];
    self.tableView = table;
    table.delegate =self;
    table.dataSource = self;
    [self.view addSubview:table];
 
}
#pragma  mark - UITableViewDelegate

#pragma mrak-tableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ZJLineChartCell * cell = [tableView dequeueReusableCellWithIdentifier:Identifier forIndexPath:indexPath];
     
       return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 283;
}

-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
    return [NSString stringWithFormat:@"%ld",section];
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 20   ;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 20   ;
}

-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    
    return [UIView new];
}

#pragma mark-UITableViewDataSource

- (void)setupScrollowView{

    CGFloat H = 210;
    CGFloat W = ZJScreenW;
    CGRect rect = CGRectMake(0, 64, W, H);
    
    UIScrollView * sw = [[UIScrollView alloc]initWithFrame:rect];
    [sw sizeToFit];
   // self.scrollView = sw;
//    sw.backgroundColor =[UIColor grayColor];
    sw.alwaysBounceVertical =NO;
    CGRect rect1 = CGRectMake(0, 0, (W-40)*2, H);
    BEMSimpleLineGraphView * Graph = [[BEMSimpleLineGraphView alloc]initWithFrame:rect1];
    CGSize size =Graph.frame.size;
 //   self.Graph = Graph;
//     Graph.backgroundColor = [UIColor redColor];
    sw.contentSize = CGSizeMake(size.width, size.height);
//    sw.contentInset = UIEdgeInsetsMake(0, 10, 0, 10);
    sw.bounces =NO;
    Graph.delegate= self;
    Graph.dataSource =self;
    
    
    // Create a gradient to apply to the bottom portion of the graph
//    CGColorSpaceRef colorspace = CGColorSpaceCreateDeviceRGB();
//    size_t num_locations = 2;
//    CGFloat locations[2] = { 0.0, 1.0 };
//    CGFloat components[8] = {
//        1.0, 1.0, 1.0, 1.0,
//        1.0, 1.0, 1.0, 0.0
//    };
//    
//    // Apply the gradient to the bottom portion of the graph
//    Graph.gradientBottom = CGGradientCreateWithColorComponents(colorspace, components, locations, num_locations);
//    
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
    Graph.colorYaxisLabel = [UIColor blackColor];
    Graph.colorBackgroundYaxis = [UIColor whiteColor];
    Graph.alphaBackgroundYaxis = 0.8;
    Graph.formatStringForValues= @"%.1f";
    
    //colorTop
    Graph.colorTop = [UIColor whiteColor];
    Graph.alphaTop = 0.8;
    
    
    //colorLine
    Graph.colorLine =ZJGreenColor;
    Graph.alphaLine = 0.8;
    //widthLine
    Graph.widthLine = 2;
    
    //colorBottom
    Graph.colorBottom = [UIColor whiteColor];
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
/**
 *  X
 *
 *  @param graph <#graph description#>
 *
 *  @return <#return value description#>
 */
- (NSInteger)numberOfGapsBetweenLabelsOnLineGraph:(BEMSimpleLineGraphView *)graph{
    NSLog(@"%s",__func__);
    return 2;
}
//Y
- (NSInteger)numberOfYAxisLabelsOnLineGraph:(BEMSimpleLineGraphView *)graph{
    NSLog(@"%s",__func__);
    return 3;
}
- (NSString *)yAxisSuffixOnLineGraph:(BEMSimpleLineGraphView *)graph{
    NSLog(@"%s",__func__);
    return @"℃";
}

#pragma mark -BEMSimpleLineGraphDataSource
//多少个点
- (NSInteger)numberOfPointsInLineGraph:(BEMSimpleLineGraphView *)graph{
    NSLog(@"%s",__func__);
    NSInteger  number = 20;
   // self.Graph.width = 20* 10;
    return number;
}
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
- (NSString *)lineGraph:(BEMSimpleLineGraphView *)graph labelOnXAxisForIndex:(NSInteger)index {
    NSString * label = [self labelForDateAtIndex:index];
    return [label stringByReplacingOccurrencesOfString:@" " withString:@"\n"];
}
@end
