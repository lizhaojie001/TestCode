//
//  TableCellHelper.h
//  DetialText
//
//  Created by Mac on 16/11/7.
//  Copyright © 2016年 HBNXWLKJ. All rights reserved.
//

#import <Foundation/Foundation.h>
@class NSWYContent; 
@interface TableCellHelper : NSObject

+(NSMutableAttributedString*)parseContentOfCell:(NSWYContent*)content;

@end
