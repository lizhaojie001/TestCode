//
//  ViewController.m
//  BEMSimpleLineGraphDemo
//
//  Created by Mac on 16/12/22.
//  Copyright © 2016年 HBNXWLKJ. All rights reserved.
//

#import "ViewController.h"
#import "BEMSimpleLineGraphView.h"

@interface ViewController ()<BEMSimpleLineGraphDelegate,BEMSimpleLineGraphDataSource>
@property (weak, nonatomic) IBOutlet BEMSimpleLineGraphView *lineView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

-(NSInteger)numberOfPointsInLineGraph:(BEMSimpleLineGraphView *)graph{
    
    return 20;
}

-(CGFloat)lineGraph:(BEMSimpleLineGraphView *)graph valueForPointAtIndex:(NSInteger)index{
    
    return index%2?20:10;
}
#pragma mark BEMSimpleLineGraphDelegate
//Graph Did Begin Loading
-(void)lineGraphDidBeginLoading:(BEMSimpleLineGraphView *)graph {
    // Prepare for loading
}
//Graph Did Finish Loading
- (void)lineGraphDidFinishLoading:(BEMSimpleLineGraphView *)graph {
    // Update interface after reloading the graph. Ensure the data source is synced-up.
}
//Graph Did Finish Drawing
- (void) lineGraphDidFinishDrawing:(BEMSimpleLineGraphView *)graph {
    // Update any interface elements that rely on a full rendered graph
}
#pragma mark Popups
- (NSString *)popUpSuffixForlineGraph:(BEMSimpleLineGraphView *)graph {
    return @"miles";
}
//Always Display Popup At Index
- (BOOL)lineGraph:(BEMSimpleLineGraphView *)graph alwaysDisplayPopUpAtIndex:(CGFloat)index {
    if (index == 0 || index == 10) return YES;
    else return NO;
}
#pragma mark Touch Events
/**
 *  Touched Graph at Closest Index
 */
- (void)lineGraph:(BEMSimpleLineGraphView *)graph didTouchGraphWithClosestIndex:(NSInteger)index {
    // Update the interface to display relevant data
}
/**
 *  Released Touch from Graph at Closest Index
 */
- (void)lineGraph:(BEMSimpleLineGraphView *)graph didReleaseTouchFromGraphWithClosestIndex:(CGFloat)index {
    // Update the interface to display relevant data
}
#pragma mark X-Axis
- (NSInteger)numberOfGapsBetweenLabelsOnLineGraph:(BEMSimpleLineGraphView *)graph {
    return 1;
}
- (NSString *)lineGraph:(BEMSimpleLineGraphView *)graph labelOnXAxisForIndex:(NSInteger)index {
    return @"😀";
}
@end
