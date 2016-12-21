//
//  NSWYPageNumModel.h
//
//  Created by Mac  on 16/11/8
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import <Realm.h>

@class NSWYCommentPage;

@interface NSWYPageNumModel : RLMObject

@property (nonatomic, assign) double total;
@property (nonatomic, strong) NSArray *content;
@property (nonatomic, strong) NSWYCommentPage *commentPage;

@end




@interface NSWYList : RLMObject

@property (nonatomic, strong) NSString *fcommentuser;
@property (nonatomic, strong) NSString *listIdentifier;
@property (nonatomic, assign) id fcreatetime;
@property (nonatomic, assign) id fupdatetime;
@property (nonatomic, assign) id createDate;
@property (nonatomic, strong) NSString *flinkid;
@property (nonatomic, strong) NSString *fcomment;
@property (nonatomic, assign) BOOL isNewRecord;
@property (nonatomic, assign) id updateDate;
@property (nonatomic, strong) NSString *fcommentdate;
@property (nonatomic, assign) double fclass;
@property (nonatomic, assign) id remarks;
@property (nonatomic, assign) id fdeletetime;


@end
