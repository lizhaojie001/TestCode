//
//  nswyTopic.h
//  nswy-1
//
//  Created by Mac on 16/12/2.
//  Copyright © 2016年 HBNXWLKJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@class nswyTopic;
@protocol  nswyTopicDelegate <NSObject>
@required
 
- (void)didClickItemWith:(UIButton *)button;



@end


@interface nswyTopic : UIScrollView


/**代理*/
@property (nonatomic,weak) id topicDelegate;
/**背景图片*/
@property (nonatomic,strong) NSMutableArray * imageArr;


- (instancetype)initWithNumBer:(NSArray *)NameArr;
@end
