//
//  NXTCellModel.m
//
//  Created by Mac  on 16/11/7
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "NXTCellModel.h"
#import "NXTData.h"


NSString *const kNXTCellModelCode = @"code";
NSString *const kNXTCellModelMessage = @"message";
NSString *const kNXTCellModelData = @"data";
NSString *const kNXTCellModelSessionId = @"sessionId";
NSString *const kNXTCellModelSessionExpired = @"sessionExpired";


@interface NXTCellModel ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation NXTCellModel

@synthesize code = _code;
@synthesize message = _message;
@synthesize data = _data;
@synthesize sessionId = _sessionId;
@synthesize sessionExpired = _sessionExpired;


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
            self.code = [[self objectOrNilForKey:kNXTCellModelCode fromDictionary:dict] doubleValue];
            self.message = [self objectOrNilForKey:kNXTCellModelMessage fromDictionary:dict];
            self.data = [NXTData modelObjectWithDictionary:[dict objectForKey:kNXTCellModelData]];
            self.sessionId = [self objectOrNilForKey:kNXTCellModelSessionId fromDictionary:dict];
            self.sessionExpired = [self objectOrNilForKey:kNXTCellModelSessionExpired fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.code] forKey:kNXTCellModelCode];
    [mutableDict setValue:self.message forKey:kNXTCellModelMessage];
    [mutableDict setValue:[self.data dictionaryRepresentation] forKey:kNXTCellModelData];
    [mutableDict setValue:self.sessionId forKey:kNXTCellModelSessionId];
    [mutableDict setValue:self.sessionExpired forKey:kNXTCellModelSessionExpired];

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

    self.code = [aDecoder decodeDoubleForKey:kNXTCellModelCode];
    self.message = [aDecoder decodeObjectForKey:kNXTCellModelMessage];
    self.data = [aDecoder decodeObjectForKey:kNXTCellModelData];
    self.sessionId = [aDecoder decodeObjectForKey:kNXTCellModelSessionId];
    self.sessionExpired = [aDecoder decodeObjectForKey:kNXTCellModelSessionExpired];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_code forKey:kNXTCellModelCode];
    [aCoder encodeObject:_message forKey:kNXTCellModelMessage];
    [aCoder encodeObject:_data forKey:kNXTCellModelData];
    [aCoder encodeObject:_sessionId forKey:kNXTCellModelSessionId];
    [aCoder encodeObject:_sessionExpired forKey:kNXTCellModelSessionExpired];
}

- (id)copyWithZone:(NSZone *)zone
{
    NXTCellModel *copy = [[NXTCellModel alloc] init];
    
    if (copy) {

        copy.code = self.code;
        copy.message = [self.message copyWithZone:zone];
        copy.data = [self.data copyWithZone:zone];
        copy.sessionId = [self.sessionId copyWithZone:zone];
        copy.sessionExpired = [self.sessionExpired copyWithZone:zone];
    }
    
    return copy;
}


@end
