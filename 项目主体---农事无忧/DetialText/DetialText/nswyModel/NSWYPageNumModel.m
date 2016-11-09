//
//  NSWYPageNumModel.m
//
//  Created by Mac  on 16/11/8
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "NSWYPageNumModel.h"
#import "NSWYContent.h"
#import "NSWYCommentPage.h"


NSString *const kNSWYPageNumModelTotal = @"total";
NSString *const kNSWYPageNumModelContent = @"content";
NSString *const kNSWYPageNumModelCommentPage = @"commentPage";


@interface NSWYPageNumModel ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation NSWYPageNumModel

@synthesize total = _total;
@synthesize content = _content;
@synthesize commentPage = _commentPage;


+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict
{
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
            self.total = [[self objectOrNilForKey:kNSWYPageNumModelTotal fromDictionary:dict] doubleValue];
    NSObject *receivedNSWYContent = [dict objectForKey:kNSWYPageNumModelContent];
    NSMutableArray *parsedNSWYContent = [NSMutableArray array];
    if ([receivedNSWYContent isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedNSWYContent) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedNSWYContent addObject:[NSWYContent modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedNSWYContent isKindOfClass:[NSDictionary class]]) {
       [parsedNSWYContent addObject:[NSWYContent modelObjectWithDictionary:(NSDictionary *)receivedNSWYContent]];
    }

    self.content = [NSArray arrayWithArray:parsedNSWYContent];
            self.commentPage = [NSWYCommentPage modelObjectWithDictionary:[dict objectForKey:kNSWYPageNumModelCommentPage]];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.total] forKey:kNSWYPageNumModelTotal];
    NSMutableArray *tempArrayForContent = [NSMutableArray array];
    for (NSObject *subArrayObject in self.content) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForContent addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForContent addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForContent] forKey:kNSWYPageNumModelContent];
    [mutableDict setValue:[self.commentPage dictionaryRepresentation] forKey:kNSWYPageNumModelCommentPage];

    return [NSDictionary dictionaryWithDictionary:mutableDict];
}

- (NSString *)description 
{
    return [NSString stringWithFormat:@"%@", [self dictionaryRepresentation]];
}

#pragma mark - Helper Method
- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict
{
    id object = [dict objectForKey:aKey];
    return [object isEqual:[NSNull null]] ? nil : object;
}


#pragma mark - NSCoding Methods

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];

    self.total = [aDecoder decodeDoubleForKey:kNSWYPageNumModelTotal];
    self.content = [aDecoder decodeObjectForKey:kNSWYPageNumModelContent];
    self.commentPage = [aDecoder decodeObjectForKey:kNSWYPageNumModelCommentPage];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_total forKey:kNSWYPageNumModelTotal];
    [aCoder encodeObject:_content forKey:kNSWYPageNumModelContent];
    [aCoder encodeObject:_commentPage forKey:kNSWYPageNumModelCommentPage];
}

- (id)copyWithZone:(NSZone *)zone
{
    NSWYPageNumModel *copy = [[NSWYPageNumModel alloc] init];
    
    if (copy) {

        copy.total = self.total;
        copy.content = [self.content copyWithZone:zone];
        copy.commentPage = [self.commentPage copyWithZone:zone];
    }
    
    return copy;
}


@end
