//
//  DataModels.m
//  Sample
//
//  Created by Mac on 16/11/29.
//  Copyright © 2016年 Facebook. All rights reserved.
//

#import "DataModels.h"

NSString *const kNSWYCommentPagePageSize = @"pageSize";
NSString *const kNSWYCommentPagePageNo = @"pageNo";
NSString *const kNSWYCommentPageFirstResult = @"firstResult";
NSString *const kNSWYCommentPageCount = @"count";
NSString *const kNSWYCommentPageHtml = @"html";
NSString *const kNSWYCommentPageList = @"list";
NSString *const kNSWYCommentPageMaxResults = @"maxResults";



NSString *const kNSWYContentIsNewRecord = @"isNewRecord";
NSString *const kNSWYContentFdoctype = @"fdoctype";
NSString *const kNSWYContentFtype = @"ftype";
NSString *const kNSWYContentFspeciesid = @"fspeciesid";
NSString *const kNSWYContentFtown = @"ftown";
NSString *const kNSWYContentId = @"id";
NSString *const kNSWYContentFtitle = @"ftitle";
NSString *const kNSWYContentForigininfo = @"forigininfo";
NSString *const kNSWYContentFkeywords = @"fkeywords";
NSString *const kNSWYContentFdiseaseid = @"fdiseaseid";
NSString *const kNSWYContentFuserdoctypeid = @"fuserdoctypeid";
NSString *const kNSWYContentFcontent = @"fcontent";
NSString *const kNSWYContentFvediosrc = @"fvediosrc";
NSString *const kNSWYContentFgeneralproductname = @"fgeneralproductname";
NSString *const kNSWYContentFremarks = @"fremarks";
NSString *const kNSWYContentFstate = @"fstate";
NSString *const kNSWYContentFcityid = @"fcityid";
NSString *const kNSWYContentFcountryid = @"fcountryid";
NSString *const kNSWYContentFpestsid = @"fpestsid";
NSString *const kNSWYContentFremindcontent = @"fremindcontent";
NSString *const kNSWYContentFvisibleteamid = @"fvisibleteamid";
NSString *const kNSWYContentFimgsrc = @"fimgsrc";
NSString *const kNSWYContentUpdateDate = @"updateDate";
NSString *const kNSWYContentFremind = @"fremind";
NSString *const kNSWYContentFclause = @"fclause";
NSString *const kNSWYContentFprovinceid = @"fprovinceid";
NSString *const kNSWYContentRemarks = @"remarks";
NSString *const kNSWYContentFupdatetime = @"fupdatetime";
NSString *const kNSWYContentFvillage = @"fvillage";
NSString *const kNSWYContentFabstract = @"fabstract";
NSString *const kNSWYContentFdeletetime = @"fdeletetime";
NSString *const kNSWYContentCreateDate = @"createDate";
NSString *const kNSWYContentFclassifiedid = @"fclassifiedid";
NSString *const kNSWYContentFextprop = @"fextprop";
NSString *const kNSWYContentFcustomcategoriesid = @"fcustomcategoriesid";
NSString *const kNSWYContentFistopage = @"fistopage";
NSString *const kNSWYContentFvisittype = @"fvisittype";
NSString *const kNSWYContentFvisitorcount = @"fvisitorcount";
NSString *const kNSWYContentFreprintstatement = @"freprintstatement";
NSString *const kNSWYContentFcreatetime = @"fcreatetime";
NSString *const kNSWYContentFindustryname = @"findustryname";
NSString *const kNSWYContentForigin = @"forigin";
NSString *const kNSWYContentFzoneid = @"fzoneid";
NSString *const kNSWYContentFspeciesname = @"fspeciesname";
NSString *const kNSWYContentFdoctypeid = @"fdoctypeid";
NSString *const kNSWYContentFgeneralservicename = @"fgeneralservicename";
NSString *const kNSWYContentFauthor = @"fauthor";




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

NSString *const kNSWYPageNumModelTotal = @"total";
NSString *const kNSWYPageNumModelContent = @"content";
NSString *const kNSWYPageNumModelCommentPage = @"commentPage";


@implementation NSWYContent
+(NSString *)primaryKey{
  
  return  kNSWYContentId;
}
//+ (NSArray *)requiredProperties {
//    //kNSWYContentFclassifiedid不能为空，暂时未使用 
//  return @[kNSWYContentId,kNSWYContentFtitle,kNSWYContentFdoctype,kNSWYContentFcountryid,
//           kNSWYContentFcityid,kNSWYContentFzoneid,kNSWYContentFdoctypeid,kNSWYContentFcontent,kNSWYContentFkeywords];
//}

+ (NSArray *)ignoredProperties {
  return @[kNSWYContentCreateDate,kNSWYContentUpdateDate];
}

@end


@implementation DataModels
+ (NSString *)primaryKey
{
    return @"uuid";
}

+ (NSDictionary *)defaultPropertyValues
{
   return  @{@"uuid": @"UUID"};
}

 
// Specify default values for properties

//+ (NSDictionary *)defaultPropertyValues
//{
//    return @{};
//}

// Specify properties to ignore (Realm won't persist these)

//+ (NSArray *)ignoredProperties
//{
//    return @[];
//}

@end


@implementation NSWYList

@end

@implementation NSWYCommentPage

@end
