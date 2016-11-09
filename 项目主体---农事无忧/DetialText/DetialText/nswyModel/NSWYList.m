//
//  NSWYList.m
//
//  Created by Mac  on 16/11/8
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "NSWYList.h"


NSString *const kNSWYListFcommentuser = @"fcommentuser";
NSString *const kNSWYListId = @"id";
NSString *const kNSWYListFcreatetime = @"fcreatetime";
NSString *const kNSWYListFupdatetime = @"fupdatetime";
NSString *const kNSWYListCreateDate = @"createDate";
NSString *const kNSWYListFlinkid = @"flinkid";
NSString *const kNSWYListFcomment = @"fcomment";
NSString *const kNSWYListIsNewRecord = @"isNewRecord";
NSString *const kNSWYListUpdateDate = @"updateDate";
NSString *const kNSWYListFcommentdate = @"fcommentdate";
NSString *const kNSWYListFclass = @"fclass";
NSString *const kNSWYListRemarks = @"remarks";
NSString *const kNSWYListFdeletetime = @"fdeletetime";


@interface NSWYList ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation NSWYList

@synthesize fcommentuser = _fcommentuser;
@synthesize listIdentifier = _listIdentifier;
@synthesize fcreatetime = _fcreatetime;
@synthesize fupdatetime = _fupdatetime;
@synthesize createDate = _createDate;
@synthesize flinkid = _flinkid;
@synthesize fcomment = _fcomment;
@synthesize isNewRecord = _isNewRecord;
@synthesize updateDate = _updateDate;
@synthesize fcommentdate = _fcommentdate;
@synthesize fclass = _fclass;
@synthesize remarks = _remarks;
@synthesize fdeletetime = _fdeletetime;


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
            self.fcommentuser = [self objectOrNilForKey:kNSWYListFcommentuser fromDictionary:dict];
            self.listIdentifier = [self objectOrNilForKey:kNSWYListId fromDictionary:dict];
            self.fcreatetime = [self objectOrNilForKey:kNSWYListFcreatetime fromDictionary:dict];
            self.fupdatetime = [self objectOrNilForKey:kNSWYListFupdatetime fromDictionary:dict];
            self.createDate = [self objectOrNilForKey:kNSWYListCreateDate fromDictionary:dict];
            self.flinkid = [self objectOrNilForKey:kNSWYListFlinkid fromDictionary:dict];
            self.fcomment = [self objectOrNilForKey:kNSWYListFcomment fromDictionary:dict];
            self.isNewRecord = [[self objectOrNilForKey:kNSWYListIsNewRecord fromDictionary:dict] boolValue];
            self.updateDate = [self objectOrNilForKey:kNSWYListUpdateDate fromDictionary:dict];
            self.fcommentdate = [self objectOrNilForKey:kNSWYListFcommentdate fromDictionary:dict];
            self.fclass = [[self objectOrNilForKey:kNSWYListFclass fromDictionary:dict] doubleValue];
            self.remarks = [self objectOrNilForKey:kNSWYListRemarks fromDictionary:dict];
            self.fdeletetime = [self objectOrNilForKey:kNSWYListFdeletetime fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.fcommentuser forKey:kNSWYListFcommentuser];
    [mutableDict setValue:self.listIdentifier forKey:kNSWYListId];
    [mutableDict setValue:self.fcreatetime forKey:kNSWYListFcreatetime];
    [mutableDict setValue:self.fupdatetime forKey:kNSWYListFupdatetime];
    [mutableDict setValue:self.createDate forKey:kNSWYListCreateDate];
    [mutableDict setValue:self.flinkid forKey:kNSWYListFlinkid];
    [mutableDict setValue:self.fcomment forKey:kNSWYListFcomment];
    [mutableDict setValue:[NSNumber numberWithBool:self.isNewRecord] forKey:kNSWYListIsNewRecord];
    [mutableDict setValue:self.updateDate forKey:kNSWYListUpdateDate];
    [mutableDict setValue:self.fcommentdate forKey:kNSWYListFcommentdate];
    [mutableDict setValue:[NSNumber numberWithDouble:self.fclass] forKey:kNSWYListFclass];
    [mutableDict setValue:self.remarks forKey:kNSWYListRemarks];
    [mutableDict setValue:self.fdeletetime forKey:kNSWYListFdeletetime];

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

    self.fcommentuser = [aDecoder decodeObjectForKey:kNSWYListFcommentuser];
    self.listIdentifier = [aDecoder decodeObjectForKey:kNSWYListId];
    self.fcreatetime = [aDecoder decodeObjectForKey:kNSWYListFcreatetime];
    self.fupdatetime = [aDecoder decodeObjectForKey:kNSWYListFupdatetime];
    self.createDate = [aDecoder decodeObjectForKey:kNSWYListCreateDate];
    self.flinkid = [aDecoder decodeObjectForKey:kNSWYListFlinkid];
    self.fcomment = [aDecoder decodeObjectForKey:kNSWYListFcomment];
    self.isNewRecord = [aDecoder decodeBoolForKey:kNSWYListIsNewRecord];
    self.updateDate = [aDecoder decodeObjectForKey:kNSWYListUpdateDate];
    self.fcommentdate = [aDecoder decodeObjectForKey:kNSWYListFcommentdate];
    self.fclass = [aDecoder decodeDoubleForKey:kNSWYListFclass];
    self.remarks = [aDecoder decodeObjectForKey:kNSWYListRemarks];
    self.fdeletetime = [aDecoder decodeObjectForKey:kNSWYListFdeletetime];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_fcommentuser forKey:kNSWYListFcommentuser];
    [aCoder encodeObject:_listIdentifier forKey:kNSWYListId];
    [aCoder encodeObject:_fcreatetime forKey:kNSWYListFcreatetime];
    [aCoder encodeObject:_fupdatetime forKey:kNSWYListFupdatetime];
    [aCoder encodeObject:_createDate forKey:kNSWYListCreateDate];
    [aCoder encodeObject:_flinkid forKey:kNSWYListFlinkid];
    [aCoder encodeObject:_fcomment forKey:kNSWYListFcomment];
    [aCoder encodeBool:_isNewRecord forKey:kNSWYListIsNewRecord];
    [aCoder encodeObject:_updateDate forKey:kNSWYListUpdateDate];
    [aCoder encodeObject:_fcommentdate forKey:kNSWYListFcommentdate];
    [aCoder encodeDouble:_fclass forKey:kNSWYListFclass];
    [aCoder encodeObject:_remarks forKey:kNSWYListRemarks];
    [aCoder encodeObject:_fdeletetime forKey:kNSWYListFdeletetime];
}

- (id)copyWithZone:(NSZone *)zone
{
    NSWYList *copy = [[NSWYList alloc] init];
    
    if (copy) {

        copy.fcommentuser = [self.fcommentuser copyWithZone:zone];
        copy.listIdentifier = [self.listIdentifier copyWithZone:zone];
        copy.fcreatetime = [self.fcreatetime copyWithZone:zone];
        copy.fupdatetime = [self.fupdatetime copyWithZone:zone];
        copy.createDate = [self.createDate copyWithZone:zone];
        copy.flinkid = [self.flinkid copyWithZone:zone];
        copy.fcomment = [self.fcomment copyWithZone:zone];
        copy.isNewRecord = self.isNewRecord;
        copy.updateDate = [self.updateDate copyWithZone:zone];
        copy.fcommentdate = [self.fcommentdate copyWithZone:zone];
        copy.fclass = self.fclass;
        copy.remarks = [self.remarks copyWithZone:zone];
        copy.fdeletetime = [self.fdeletetime copyWithZone:zone];
    }
    
    return copy;
}


@end
