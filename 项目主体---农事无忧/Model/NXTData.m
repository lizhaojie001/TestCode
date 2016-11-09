//
//  NXTData.m
//
//  Created by Mac  on 16/11/7
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "NXTData.h"


NSString *const kNXTDataUsername = @"username";
NSString *const kNXTDataCommentAllowed = @"comment_allowed";
NSString *const kNXTDataMarkdowncontent = @"markdowncontent";
NSString *const kNXTDataStatus = @"status";
NSString *const kNXTDataTitle = @"title";
NSString *const kNXTDataUrl = @"url";
NSString *const kNXTDataTags = @"tags";
NSString *const kNXTDataArticleedittype = @"articleedittype";
NSString *const kNXTDataNickname = @"nickname";
NSString *const kNXTDataChannel = @"channel";
NSString *const kNXTDataIsDigged = @"is_digged";
NSString *const kNXTDataMarkdowndirectory = @"markdowndirectory";
NSString *const kNXTDataIsBuryed = @"is_buryed";
NSString *const kNXTDataCreate = @"create";
NSString *const kNXTDataBury = @"bury";
NSString *const kNXTDataIsFav = @"is_fav";
NSString *const kNXTDataDigg = @"digg";
NSString *const kNXTDataType = @"type";
NSString *const kNXTDataId = @"id";
NSString *const kNXTDataLevel = @"level";
NSString *const kNXTDataArticlemore = @"articlemore";
NSString *const kNXTDataViewCount = @"view_count";
NSString *const kNXTDataCanDig = @"can_dig";
NSString *const kNXTDataCreateAt = @"create_at";
NSString *const kNXTDataAvatar = @"avatar";
NSString *const kNXTDataCommentCount = @"comment_count";
NSString *const kNXTDataCategories = @"categories";
NSString *const kNXTDataDescription = @"description";


@interface NXTData ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation NXTData

@synthesize username = _username;
@synthesize commentAllowed = _commentAllowed;
@synthesize markdowncontent = _markdowncontent;
@synthesize status = _status;
@synthesize title = _title;
@synthesize url = _url;
@synthesize tags = _tags;
@synthesize articleedittype = _articleedittype;
@synthesize nickname = _nickname;
@synthesize channel = _channel;
@synthesize isDigged = _isDigged;
@synthesize markdowndirectory = _markdowndirectory;
@synthesize isBuryed = _isBuryed;
@synthesize create = _create;
@synthesize bury = _bury;
@synthesize isFav = _isFav;
@synthesize digg = _digg;
@synthesize type = _type;
@synthesize dataIdentifier = _dataIdentifier;
@synthesize level = _level;
@synthesize articlemore = _articlemore;
@synthesize viewCount = _viewCount;
@synthesize canDig = _canDig;
@synthesize createAt = _createAt;
@synthesize avatar = _avatar;
@synthesize commentCount = _commentCount;
@synthesize categories = _categories;
@synthesize dataDescription = _dataDescription;


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
            self.username = [self objectOrNilForKey:kNXTDataUsername fromDictionary:dict];
            self.commentAllowed = [self objectOrNilForKey:kNXTDataCommentAllowed fromDictionary:dict];
            self.markdowncontent = [self objectOrNilForKey:kNXTDataMarkdowncontent fromDictionary:dict];
            self.status = [[self objectOrNilForKey:kNXTDataStatus fromDictionary:dict] doubleValue];
            self.title = [self objectOrNilForKey:kNXTDataTitle fromDictionary:dict];
            self.url = [self objectOrNilForKey:kNXTDataUrl fromDictionary:dict];
            self.tags = [self objectOrNilForKey:kNXTDataTags fromDictionary:dict];
            self.articleedittype = [[self objectOrNilForKey:kNXTDataArticleedittype fromDictionary:dict] doubleValue];
            self.nickname = [self objectOrNilForKey:kNXTDataNickname fromDictionary:dict];
            self.channel = [[self objectOrNilForKey:kNXTDataChannel fromDictionary:dict] doubleValue];
            self.isDigged = [[self objectOrNilForKey:kNXTDataIsDigged fromDictionary:dict] boolValue];
            self.markdowndirectory = [self objectOrNilForKey:kNXTDataMarkdowndirectory fromDictionary:dict];
            self.isBuryed = [[self objectOrNilForKey:kNXTDataIsBuryed fromDictionary:dict] boolValue];
            self.create = [self objectOrNilForKey:kNXTDataCreate fromDictionary:dict];
            self.bury = [[self objectOrNilForKey:kNXTDataBury fromDictionary:dict] doubleValue];
            self.isFav = [[self objectOrNilForKey:kNXTDataIsFav fromDictionary:dict] doubleValue];
            self.digg = [[self objectOrNilForKey:kNXTDataDigg fromDictionary:dict] doubleValue];
            self.type = [self objectOrNilForKey:kNXTDataType fromDictionary:dict];
            self.dataIdentifier = [[self objectOrNilForKey:kNXTDataId fromDictionary:dict] doubleValue];
            self.level = [[self objectOrNilForKey:kNXTDataLevel fromDictionary:dict] doubleValue];
            self.articlemore = [self objectOrNilForKey:kNXTDataArticlemore fromDictionary:dict];
            self.viewCount = [[self objectOrNilForKey:kNXTDataViewCount fromDictionary:dict] doubleValue];
            self.canDig = [[self objectOrNilForKey:kNXTDataCanDig fromDictionary:dict] boolValue];
            self.createAt = [self objectOrNilForKey:kNXTDataCreateAt fromDictionary:dict];
            self.avatar = [self objectOrNilForKey:kNXTDataAvatar fromDictionary:dict];
            self.commentCount = [[self objectOrNilForKey:kNXTDataCommentCount fromDictionary:dict] doubleValue];
            self.categories = [self objectOrNilForKey:kNXTDataCategories fromDictionary:dict];
            self.dataDescription = [self objectOrNilForKey:kNXTDataDescription fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.username forKey:kNXTDataUsername];
    [mutableDict setValue:self.commentAllowed forKey:kNXTDataCommentAllowed];
    [mutableDict setValue:self.markdowncontent forKey:kNXTDataMarkdowncontent];
    [mutableDict setValue:[NSNumber numberWithDouble:self.status] forKey:kNXTDataStatus];
    [mutableDict setValue:self.title forKey:kNXTDataTitle];
    [mutableDict setValue:self.url forKey:kNXTDataUrl];
    [mutableDict setValue:self.tags forKey:kNXTDataTags];
    [mutableDict setValue:[NSNumber numberWithDouble:self.articleedittype] forKey:kNXTDataArticleedittype];
    [mutableDict setValue:self.nickname forKey:kNXTDataNickname];
    [mutableDict setValue:[NSNumber numberWithDouble:self.channel] forKey:kNXTDataChannel];
    [mutableDict setValue:[NSNumber numberWithBool:self.isDigged] forKey:kNXTDataIsDigged];
    [mutableDict setValue:self.markdowndirectory forKey:kNXTDataMarkdowndirectory];
    [mutableDict setValue:[NSNumber numberWithBool:self.isBuryed] forKey:kNXTDataIsBuryed];
    [mutableDict setValue:self.create forKey:kNXTDataCreate];
    [mutableDict setValue:[NSNumber numberWithDouble:self.bury] forKey:kNXTDataBury];
    [mutableDict setValue:[NSNumber numberWithDouble:self.isFav] forKey:kNXTDataIsFav];
    [mutableDict setValue:[NSNumber numberWithDouble:self.digg] forKey:kNXTDataDigg];
    [mutableDict setValue:self.type forKey:kNXTDataType];
    [mutableDict setValue:[NSNumber numberWithDouble:self.dataIdentifier] forKey:kNXTDataId];
    [mutableDict setValue:[NSNumber numberWithDouble:self.level] forKey:kNXTDataLevel];
    [mutableDict setValue:self.articlemore forKey:kNXTDataArticlemore];
    [mutableDict setValue:[NSNumber numberWithDouble:self.viewCount] forKey:kNXTDataViewCount];
    [mutableDict setValue:[NSNumber numberWithBool:self.canDig] forKey:kNXTDataCanDig];
    [mutableDict setValue:self.createAt forKey:kNXTDataCreateAt];
    [mutableDict setValue:self.avatar forKey:kNXTDataAvatar];
    [mutableDict setValue:[NSNumber numberWithDouble:self.commentCount] forKey:kNXTDataCommentCount];
    [mutableDict setValue:self.categories forKey:kNXTDataCategories];
    [mutableDict setValue:self.dataDescription forKey:kNXTDataDescription];

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

    self.username = [aDecoder decodeObjectForKey:kNXTDataUsername];
    self.commentAllowed = [aDecoder decodeObjectForKey:kNXTDataCommentAllowed];
    self.markdowncontent = [aDecoder decodeObjectForKey:kNXTDataMarkdowncontent];
    self.status = [aDecoder decodeDoubleForKey:kNXTDataStatus];
    self.title = [aDecoder decodeObjectForKey:kNXTDataTitle];
    self.url = [aDecoder decodeObjectForKey:kNXTDataUrl];
    self.tags = [aDecoder decodeObjectForKey:kNXTDataTags];
    self.articleedittype = [aDecoder decodeDoubleForKey:kNXTDataArticleedittype];
    self.nickname = [aDecoder decodeObjectForKey:kNXTDataNickname];
    self.channel = [aDecoder decodeDoubleForKey:kNXTDataChannel];
    self.isDigged = [aDecoder decodeBoolForKey:kNXTDataIsDigged];
    self.markdowndirectory = [aDecoder decodeObjectForKey:kNXTDataMarkdowndirectory];
    self.isBuryed = [aDecoder decodeBoolForKey:kNXTDataIsBuryed];
    self.create = [aDecoder decodeObjectForKey:kNXTDataCreate];
    self.bury = [aDecoder decodeDoubleForKey:kNXTDataBury];
    self.isFav = [aDecoder decodeDoubleForKey:kNXTDataIsFav];
    self.digg = [aDecoder decodeDoubleForKey:kNXTDataDigg];
    self.type = [aDecoder decodeObjectForKey:kNXTDataType];
    self.dataIdentifier = [aDecoder decodeDoubleForKey:kNXTDataId];
    self.level = [aDecoder decodeDoubleForKey:kNXTDataLevel];
    self.articlemore = [aDecoder decodeObjectForKey:kNXTDataArticlemore];
    self.viewCount = [aDecoder decodeDoubleForKey:kNXTDataViewCount];
    self.canDig = [aDecoder decodeBoolForKey:kNXTDataCanDig];
    self.createAt = [aDecoder decodeObjectForKey:kNXTDataCreateAt];
    self.avatar = [aDecoder decodeObjectForKey:kNXTDataAvatar];
    self.commentCount = [aDecoder decodeDoubleForKey:kNXTDataCommentCount];
    self.categories = [aDecoder decodeObjectForKey:kNXTDataCategories];
    self.dataDescription = [aDecoder decodeObjectForKey:kNXTDataDescription];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_username forKey:kNXTDataUsername];
    [aCoder encodeObject:_commentAllowed forKey:kNXTDataCommentAllowed];
    [aCoder encodeObject:_markdowncontent forKey:kNXTDataMarkdowncontent];
    [aCoder encodeDouble:_status forKey:kNXTDataStatus];
    [aCoder encodeObject:_title forKey:kNXTDataTitle];
    [aCoder encodeObject:_url forKey:kNXTDataUrl];
    [aCoder encodeObject:_tags forKey:kNXTDataTags];
    [aCoder encodeDouble:_articleedittype forKey:kNXTDataArticleedittype];
    [aCoder encodeObject:_nickname forKey:kNXTDataNickname];
    [aCoder encodeDouble:_channel forKey:kNXTDataChannel];
    [aCoder encodeBool:_isDigged forKey:kNXTDataIsDigged];
    [aCoder encodeObject:_markdowndirectory forKey:kNXTDataMarkdowndirectory];
    [aCoder encodeBool:_isBuryed forKey:kNXTDataIsBuryed];
    [aCoder encodeObject:_create forKey:kNXTDataCreate];
    [aCoder encodeDouble:_bury forKey:kNXTDataBury];
    [aCoder encodeDouble:_isFav forKey:kNXTDataIsFav];
    [aCoder encodeDouble:_digg forKey:kNXTDataDigg];
    [aCoder encodeObject:_type forKey:kNXTDataType];
    [aCoder encodeDouble:_dataIdentifier forKey:kNXTDataId];
    [aCoder encodeDouble:_level forKey:kNXTDataLevel];
    [aCoder encodeObject:_articlemore forKey:kNXTDataArticlemore];
    [aCoder encodeDouble:_viewCount forKey:kNXTDataViewCount];
    [aCoder encodeBool:_canDig forKey:kNXTDataCanDig];
    [aCoder encodeObject:_createAt forKey:kNXTDataCreateAt];
    [aCoder encodeObject:_avatar forKey:kNXTDataAvatar];
    [aCoder encodeDouble:_commentCount forKey:kNXTDataCommentCount];
    [aCoder encodeObject:_categories forKey:kNXTDataCategories];
    [aCoder encodeObject:_dataDescription forKey:kNXTDataDescription];
}

- (id)copyWithZone:(NSZone *)zone
{
    NXTData *copy = [[NXTData alloc] init];
    
    if (copy) {

        copy.username = [self.username copyWithZone:zone];
        copy.commentAllowed = [self.commentAllowed copyWithZone:zone];
        copy.markdowncontent = [self.markdowncontent copyWithZone:zone];
        copy.status = self.status;
        copy.title = [self.title copyWithZone:zone];
        copy.url = [self.url copyWithZone:zone];
        copy.tags = [self.tags copyWithZone:zone];
        copy.articleedittype = self.articleedittype;
        copy.nickname = [self.nickname copyWithZone:zone];
        copy.channel = self.channel;
        copy.isDigged = self.isDigged;
        copy.markdowndirectory = [self.markdowndirectory copyWithZone:zone];
        copy.isBuryed = self.isBuryed;
        copy.create = [self.create copyWithZone:zone];
        copy.bury = self.bury;
        copy.isFav = self.isFav;
        copy.digg = self.digg;
        copy.type = [self.type copyWithZone:zone];
        copy.dataIdentifier = self.dataIdentifier;
        copy.level = self.level;
        copy.articlemore = [self.articlemore copyWithZone:zone];
        copy.viewCount = self.viewCount;
        copy.canDig = self.canDig;
        copy.createAt = [self.createAt copyWithZone:zone];
        copy.avatar = [self.avatar copyWithZone:zone];
        copy.commentCount = self.commentCount;
        copy.categories = [self.categories copyWithZone:zone];
        copy.dataDescription = [self.dataDescription copyWithZone:zone];
    }
    
    return copy;
}


@end
