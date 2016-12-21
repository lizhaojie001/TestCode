//
//  nswySegmentation.m
//  nswy-1
//
//  Created by Mac on 16/12/8.
//  Copyright © 2016年 HBNXWLKJ. All rights reserved.
//

#import "nswySegmentation.h"
@interface nswySegmentation ()
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentation;


@end
@implementation nswySegmentation

+(instancetype)segmentation{
    
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([nswySegmentation class]) owner:self options:nil].firstObject;
    
}

-(void)setFrame:(CGRect)frame{
    
    CGRect newFrame = CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, 30);
    [super setFrame:newFrame];
}

-(void)setBounds:(CGRect)bounds{
    CGRect newBounds= CGRectMake(bounds.origin.x, bounds.origin.y, bounds.size.width, 30);
    [super setBounds:newBounds];
}
- (IBAction)select:(UISegmentedControl *)sender {
    
    NSInteger  index = sender.selectedSegmentIndex;
    if ([self.segmentationDelegate respondsToSelector:@selector(didClickSegmentationIndex:)]) {
        [self.segmentationDelegate didClickSegmentationIndex:index];
    }
    
}
- (IBAction)filtrate:(UIButton *)sender {
    
    if ([self.segmentationDelegate respondsToSelector:@selector(didClickFilterBtnfSegmentation)]) {
        [self.segmentationDelegate didClickFilterBtnfSegmentation];
    }
}
- (IBAction)search:(UIButton *)sender {
    if ([self.segmentationDelegate respondsToSelector:@selector(didClickSearchBtnfSegmentation)]) {
        [self.segmentationDelegate didClickSearchBtnfSegmentation];
    }
}
 
@end
