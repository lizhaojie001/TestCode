//
//  NSWYContent.h
//
//  Created by Mac  on 16/11/8
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface NSWYContent : NSObject <NSCoding, NSCopying>
/**ID*/
@property (nonatomic,strong) NSString * ID;

@property (nonatomic, assign) BOOL isNewRecord;
@property (nonatomic, strong) NSString *fdoctype;
@property (nonatomic, assign) id ftype;
@property (nonatomic, strong) NSString *fspeciesid;
@property (nonatomic, assign) id ftown;
@property (nonatomic, strong) NSString *contentIdentifier;
@property (nonatomic, strong) NSString *ftitle;
@property (nonatomic, assign) id forigininfo;
@property (nonatomic, strong) NSString *fkeywords;
@property (nonatomic, assign) id fdiseaseid;
@property (nonatomic, assign) id fuserdoctypeid;
@property (nonatomic, strong) NSString *fcontent;
@property (nonatomic, assign) id fvediosrc;
@property (nonatomic, assign) id fgeneralproductname;
@property (nonatomic, strong) NSString *fremarks;
@property (nonatomic, assign) double fstate;
@property (nonatomic, assign) id fcityid;
@property (nonatomic, strong) NSString *fcountryid;
@property (nonatomic, assign) id fpestsid;
@property (nonatomic, strong) NSString *fremindcontent;
@property (nonatomic, assign) id fvisibleteamid;
@property (nonatomic, assign) id fimgsrc;
@property (nonatomic, assign) id updateDate;
@property (nonatomic, assign) id fremind;
@property (nonatomic, assign) id fclause;
@property (nonatomic, assign) id fprovinceid;
@property (nonatomic, assign) id remarks;
@property (nonatomic, strong) NSString *fupdatetime;
@property (nonatomic, assign) id fvillage;
@property (nonatomic, assign) id fabstract;
@property (nonatomic, assign) id fdeletetime;
@property (nonatomic, assign) id createDate;
@property (nonatomic, assign) id fclassifiedid;
@property (nonatomic, assign) id fextprop;
@property (nonatomic, assign) id fcustomcategoriesid;
@property (nonatomic, assign) double fistopage;
@property (nonatomic, assign) double fvisittype;
@property (nonatomic, assign) double fvisitorcount;
@property (nonatomic, assign) id freprintstatement;
@property (nonatomic, strong) NSString *fcreatetime;
@property (nonatomic, strong) NSString *findustryname;
@property (nonatomic, assign) double forigin;
@property (nonatomic, assign) id fzoneid;
@property (nonatomic, assign) id fspeciesname;
@property (nonatomic, strong) NSString *fdoctypeid;
@property (nonatomic, assign) id fgeneralservicename;
@property (nonatomic, assign) NSString * fauthor;

/**数量*/
- (NSUInteger)totalNumberOfContent;
/**<#注释#>*/
- (NSWYContent*)objectAtIndex:(NSUInteger)index;
/**
 刷新数据*/
- (void)refreshContentWithCompletionBlock:(void (^)(NSArray *))block numResultsToReturn:(NSUInteger)numResults;
/**请求数据*/
- (void)requestPageWithCompletionBlock:(void (^)(NSArray *))block numResultsToReturn:(NSUInteger)numResults;
/**清空数据*/
- (void)clearFeed;
+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
