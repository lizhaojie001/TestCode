//
//  NXTCellModel.h
//
//  Created by Mac  on 16/11/7
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class NXTData;

@interface NXTCellModel : NSObject <NSCoding, NSCopying>

@property (nonatomic, assign) double code;
@property (nonatomic, strong) NSString *message;
@property (nonatomic, strong) NXTData *data;
@property (nonatomic, strong) NSString *sessionId;
@property (nonatomic, strong) NSString *sessionExpired;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
