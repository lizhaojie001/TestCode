//
//  NSWYPageNumModel.h
//
//  Created by Mac  on 16/11/8
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class NSWYCommentPage;

@interface NSWYPageNumModel : NSObject <NSCoding, NSCopying>

@property (nonatomic, assign) double total;
@property (nonatomic, strong) NSArray *content;
@property (nonatomic, strong) NSWYCommentPage *commentPage;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
