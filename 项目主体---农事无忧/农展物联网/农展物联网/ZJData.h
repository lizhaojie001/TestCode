//
//  ZJData.h
//  农展物联网
//
//  Created by Mac on 2/27/17.
//  Copyright © 2017 HBNXWLKJ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZJData : NSObject
/**param*/
@property (nonatomic,copy ) NSString * param;

/**dataMap*/
@property (nonatomic,strong) NSDictionary * dataMap;




//辅助属性

/**最新的时间点的数据值*/
@property (nonatomic,copy,readonly) NSString * latestData;

@property (nonatomic, strong) NSNumber *pavilionID;

@end
