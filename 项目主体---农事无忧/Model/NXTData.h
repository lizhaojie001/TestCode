//
//  NXTData.h
//
//  Created by Mac  on 16/11/7
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface NXTData : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *username;
@property (nonatomic, strong) NSString *commentAllowed;
@property (nonatomic, strong) NSString *markdowncontent;
@property (nonatomic, assign) double status;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *url;
@property (nonatomic, strong) NSString *tags;
@property (nonatomic, assign) double articleedittype;
@property (nonatomic, strong) NSString *nickname;
@property (nonatomic, assign) double channel;
@property (nonatomic, assign) BOOL isDigged;
@property (nonatomic, assign) id markdowndirectory;
@property (nonatomic, assign) BOOL isBuryed;
@property (nonatomic, strong) NSString *create;
@property (nonatomic, assign) double bury;
@property (nonatomic, assign) double isFav;
@property (nonatomic, assign) double digg;
@property (nonatomic, strong) NSString *type;
@property (nonatomic, assign) double dataIdentifier;
@property (nonatomic, assign) double level;
@property (nonatomic, strong) NSString *articlemore;
@property (nonatomic, assign) double viewCount;
@property (nonatomic, assign) BOOL canDig;
@property (nonatomic, strong) NSString *createAt;
@property (nonatomic, strong) NSString *avatar;
@property (nonatomic, assign) double commentCount;
@property (nonatomic, strong) NSString *categories;
@property (nonatomic, strong) NSString *dataDescription;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
