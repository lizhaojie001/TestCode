//
//  NSWYCommentPage.m
//
//  Created by Mac  on 16/11/8
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "NSWYCommentPage.h"
#import "NSWYList.h"


NSString *const kNSWYCommentPagePageSize = @"pageSize";
NSString *const kNSWYCommentPagePageNo = @"pageNo";
NSString *const kNSWYCommentPageFirstResult = @"firstResult";
NSString *const kNSWYCommentPageCount = @"count";
NSString *const kNSWYCommentPageHtml = @"html";
NSString *const kNSWYCommentPageList = @"list";
NSString *const kNSWYCommentPageMaxResults = @"maxResults";


@interface NSWYCommentPage ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation NSWYCommentPage

@synthesize pageSize = _pageSize;
@synthesize pageNo = _pageNo;
@synthesize firstResult = _firstResult;
@synthesize count = _count;
@synthesize html = _html;
@synthesize list = _list;
@synthesize maxResults = _maxResults;


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
            self.pageSize = [[self objectOrNilForKey:kNSWYCommentPagePageSize fromDictionary:dict] doubleValue];
            self.pageNo = [[self objectOrNilForKey:kNSWYCommentPagePageNo fromDictionary:dict] doubleValue];
            self.firstResult = [[self objectOrNilForKey:kNSWYCommentPageFirstResult fromDictionary:dict] doubleValue];
            self.count = [[self objectOrNilForKey:kNSWYCommentPageCount fromDictionary:dict] doubleValue];
            self.html = [self objectOrNilForKey:kNSWYCommentPageHtml fromDictionary:dict];
    NSObject *receivedNSWYList = [dict objectForKey:kNSWYCommentPageList];
    NSMutableArray *parsedNSWYList = [NSMutableArray array];
    if ([receivedNSWYList isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedNSWYList) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedNSWYList addObject:[NSWYList modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedNSWYList isKindOfClass:[NSDictionary class]]) {
       [parsedNSWYList addObject:[NSWYList modelObjectWithDictionary:(NSDictionary *)receivedNSWYList]];
    }

    self.list = [NSArray arrayWithArray:parsedNSWYList];
            self.maxResults = [[self objectOrNilForKey:kNSWYCommentPageMaxResults fromDictionary:dict] doubleValue];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.pageSize] forKey:kNSWYCommentPagePageSize];
    [mutableDict setValue:[NSNumber numberWithDouble:self.pageNo] forKey:kNSWYCommentPagePageNo];
    [mutableDict setValue:[NSNumber numberWithDouble:self.firstResult] forKey:kNSWYCommentPageFirstResult];
    [mutableDict setValue:[NSNumber numberWithDouble:self.count] forKey:kNSWYCommentPageCount];
    [mutableDict setValue:self.html forKey:kNSWYCommentPageHtml];
    NSMutableArray *tempArrayForList = [NSMutableArray array];
    for (NSObject *subArrayObject in self.list) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForList addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForList addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForList] forKey:kNSWYCommentPageList];
    [mutableDict setValue:[NSNumber numberWithDouble:self.maxResults] forKey:kNSWYCommentPageMaxResults];

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

    self.pageSize = [aDecoder decodeDoubleForKey:kNSWYCommentPagePageSize];
    self.pageNo = [aDecoder decodeDoubleForKey:kNSWYCommentPagePageNo];
    self.firstResult = [aDecoder decodeDoubleForKey:kNSWYCommentPageFirstResult];
    self.count = [aDecoder decodeDoubleForKey:kNSWYCommentPageCount];
    self.html = [aDecoder decodeObjectForKey:kNSWYCommentPageHtml];
    self.list = [aDecoder decodeObjectForKey:kNSWYCommentPageList];
    self.maxResults = [aDecoder decodeDoubleForKey:kNSWYCommentPageMaxResults];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_pageSize forKey:kNSWYCommentPagePageSize];
    [aCoder encodeDouble:_pageNo forKey:kNSWYCommentPagePageNo];
    [aCoder encodeDouble:_firstResult forKey:kNSWYCommentPageFirstResult];
    [aCoder encodeDouble:_count forKey:kNSWYCommentPageCount];
    [aCoder encodeObject:_html forKey:kNSWYCommentPageHtml];
    [aCoder encodeObject:_list forKey:kNSWYCommentPageList];
    [aCoder encodeDouble:_maxResults forKey:kNSWYCommentPageMaxResults];
}

- (id)copyWithZone:(NSZone *)zone
{
    NSWYCommentPage *copy = [[NSWYCommentPage alloc] init];
    
    if (copy) {

        copy.pageSize = self.pageSize;
        copy.pageNo = self.pageNo;
        copy.firstResult = self.firstResult;
        copy.count = self.count;
        copy.html = [self.html copyWithZone:zone];
        copy.list = [self.list copyWithZone:zone];
        copy.maxResults = self.maxResults;
    }
    
    return copy;
}


@end
