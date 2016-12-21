//
//  nswySegmentation.h
//  nswy-1
//
//  Created by Mac on 16/12/8.
//  Copyright © 2016年 HBNXWLKJ. All rights reserved.
//

#import <UIKit/UIKit.h>
@class  nswySegmentation;
@protocol  nswySegmentationDelegate <NSObject>


@required

-(void)didClickSegmentationIndex:(NSInteger )index;

-(void)didClickFilterBtnfSegmentation;

-(void)didClickSearchBtnfSegmentation;
@end



@interface nswySegmentation : UIView

/**代理*/
@property (nonatomic,weak) id segmentationDelegate;

+(instancetype)segmentation;

@end
