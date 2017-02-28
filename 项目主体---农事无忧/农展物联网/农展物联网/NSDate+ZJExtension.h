//
//  NSDate+ZJExtension.h
//  农展物联网
//
//  Created by Mac on 2/28/17.
//  Copyright © 2017 HBNXWLKJ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (ZJExtension)
+ (int)getMin:(NSString *)time;
+ (int)getHour:(NSString*)time;

/**
 *  获取2017-02-12 形式的字符串
 */
+ (NSString *)DateOfToday;
@end
