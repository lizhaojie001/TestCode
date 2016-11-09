//
//  NSWYCommentPage.h
//
//  Created by Mac  on 16/11/8
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface NSWYCommentPage : NSObject <NSCoding, NSCopying>

@property (nonatomic, assign) double pageSize;
@property (nonatomic, assign) double pageNo;
@property (nonatomic, assign) double firstResult;
@property (nonatomic, assign) double count;
@property (nonatomic, strong) NSString *html;
@property (nonatomic, strong) NSArray *list;
@property (nonatomic, assign) double maxResults;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
