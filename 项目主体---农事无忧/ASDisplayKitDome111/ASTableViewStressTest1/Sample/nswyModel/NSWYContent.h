//
//  NSWYContent.h
//
//  Created by Mac  on 16/11/8
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MJExtension.h"


@interface NSWYContent : NSObject <NSCoding, NSCopying>
/**ID*/
@property (nonatomic,strong) NSString * ID;

@property (nonatomic, strong) NSNumber * isNewRecord;
@property (nonatomic, strong) NSString *fdoctype;
@property (nonatomic, strong) NSString *ftype;
@property (nonatomic, strong) NSString *fspeciesid;
@property (nonatomic, strong) NSString *ftown;
@property (nonatomic, strong) NSString *contentIdentifier;
@property (nonatomic, strong) NSString *ftitle;
@property (nonatomic, strong) NSString * forigininfo;
@property (nonatomic, strong) NSString *fkeywords;
@property (nonatomic, strong) NSString * fdiseaseid;
@property (nonatomic, strong) NSString * fuserdoctypeid;
@property (nonatomic, strong) NSString *fcontent;
@property (nonatomic, strong) NSString * fvediosrc;
@property (nonatomic, strong) NSString * fgeneralproductname;
@property (nonatomic, strong) NSString *fremarks;
@property (nonatomic, strong) NSNumber * fstate;
@property (nonatomic, strong) NSString * fcityid;
@property (nonatomic, strong) NSString * fcountryid;
@property (nonatomic, strong) NSString * fpestsid;
@property (nonatomic, strong) NSString * fremindcontent;
@property (nonatomic, strong) NSString * fvisibleteamid;
@property (nonatomic, strong) NSString * fimgsrc;
@property (nonatomic, strong) NSString *  updateDate;
@property (nonatomic, strong) NSString * fremind;
@property (nonatomic, strong) NSString * fclause;
@property (nonatomic, strong) NSString * fprovinceid;
@property (nonatomic, strong) NSString * remarks;
@property (nonatomic, strong) NSString *fupdatetime;
@property (nonatomic, strong) NSString * fvillage;
@property (nonatomic, strong) NSString * fabstract;
@property (nonatomic, strong) NSString * fdeletetime;
@property (nonatomic, strong) NSString * createDate;
@property (nonatomic, strong) NSString * fclassifiedid;
@property (nonatomic, strong) NSString * fextprop;
@property (nonatomic, strong) NSString * fcustomcategoriesid;
@property (nonatomic, strong) NSNumber * fistopage;
@property (nonatomic, strong) NSNumber * fvisittype;
@property (nonatomic, assign) int fvisitorcount;
@property (nonatomic, strong) NSNumber * freprintstatement;//是否允许转载
@property (nonatomic, strong) NSString * fcreatetime;
@property (nonatomic, strong) NSString * findustryname;
@property (nonatomic, strong) NSNumber * forigin;
@property (nonatomic, strong) NSString * fzoneid;
@property (nonatomic, strong) NSString * fspeciesname;
@property (nonatomic, strong) NSString * fdoctypeid;
@property (nonatomic, strong) NSString * fgeneralservicename;
@property (nonatomic, strong) NSString * fauthor;


 
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
