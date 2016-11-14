//
//  NSWYContent.m
//
//  Created by Mac  on 16/11/8
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved./


///pageNum=1&number=40
#define CONTENTURLHOST @"http://123.85.2.102:8089/nswy-space/a/consultinfo/nswyConsultinfo/ws/look?" 
#import "NSWYContent.h"


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
NSString *const kNSWYContentID = @"ID";

@interface NSWYContent (){
  BOOL           _fetchPageInProgress;
  BOOL           _refreshFeedInProgress;
}
/**totalItems*/
@property (nonatomic,assign) NSUInteger totalContents;
/**内容数组*/
@property (nonatomic,strong) NSMutableArray * contents;

/**目前第几页*/
@property (nonatomic,assign) NSUInteger currnetPage;
/**总页数*/
@property (nonatomic,assign) NSUInteger totalPages;
 


- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation NSWYContent

/*刷新数据*/
- (void)refreshContentWithCompletionBlock:(void (^)(NSArray *))block numResultsToReturn:(NSUInteger)numResults{
  
}
/**请求数据*/
- (void)requestPageWithCompletionBlock:(void (^)(NSArray *))block numResultsToReturn:(NSUInteger)numResults{
  // only one fetch at a time
  if (_fetchPageInProgress) {
    return;
  } else {
    _fetchPageInProgress = YES;
    [self fetchPageWithCompletionBlock:block numResultsToReturn:numResults];
  }

}
//取回数据
- (void)fetchPageWithCompletionBlock:(void (^)(NSArray *))block numResultsToReturn:(NSUInteger)numResults
{
  [self fetchPageWithCompletionBlock:block numResultsToReturn:numResults replaceData:NO];
}
//
- (void)fetchPageWithCompletionBlock:(void (^)(NSArray *))block numResultsToReturn:(NSUInteger)numResults replaceData:(BOOL)replaceData
{
}
/**清空数据*/
- (void)clearFeed{
  
}



-(NSUInteger)totalNumberOfContent{
  
  return _totalContents; 
}
- (NSWYContent *)objectAtIndex:(NSUInteger)index{
  
  return [_contents objectAtIndex:index];
}

- (NSInteger)indexOfPhotoModel:(NSWYContent   *)content
{
  return [_contents indexOfObjectIdenticalTo:content];
}
@synthesize ID = _ID;
@synthesize isNewRecord = _isNewRecord;
@synthesize fdoctype = _fdoctype;
@synthesize ftype = _ftype;
@synthesize fspeciesid = _fspeciesid;
@synthesize ftown = _ftown;
@synthesize contentIdentifier = _contentIdentifier;
@synthesize ftitle = _ftitle;
@synthesize forigininfo = _forigininfo;
@synthesize fkeywords = _fkeywords;
@synthesize fdiseaseid = _fdiseaseid;
@synthesize fuserdoctypeid = _fuserdoctypeid;
@synthesize fcontent = _fcontent;
@synthesize fvediosrc = _fvediosrc;
@synthesize fgeneralproductname = _fgeneralproductname;
@synthesize fremarks = _fremarks;
@synthesize fstate = _fstate;
@synthesize fcityid = _fcityid;
@synthesize fcountryid = _fcountryid;
@synthesize fpestsid = _fpestsid;
@synthesize fremindcontent = _fremindcontent;
@synthesize fvisibleteamid = _fvisibleteamid;
@synthesize fimgsrc = _fimgsrc;
@synthesize updateDate = _updateDate;
@synthesize fremind = _fremind;
@synthesize fclause = _fclause;
@synthesize fprovinceid = _fprovinceid;
@synthesize remarks = _remarks;
@synthesize fupdatetime = _fupdatetime;
@synthesize fvillage = _fvillage;
@synthesize fabstract = _fabstract;
@synthesize fdeletetime = _fdeletetime;
@synthesize createDate = _createDate;
@synthesize fclassifiedid = _fclassifiedid;
@synthesize fextprop = _fextprop;
@synthesize fcustomcategoriesid = _fcustomcategoriesid;
@synthesize fistopage = _fistopage;
@synthesize fvisittype = _fvisittype;
@synthesize fvisitorcount = _fvisitorcount;
@synthesize freprintstatement = _freprintstatement;
@synthesize fcreatetime = _fcreatetime;
@synthesize findustryname = _findustryname;
@synthesize forigin = _forigin;
@synthesize fzoneid = _fzoneid;
@synthesize fspeciesname = _fspeciesname;
@synthesize fdoctypeid = _fdoctypeid;
@synthesize fgeneralservicename = _fgeneralservicename;
@synthesize fauthor = _fauthor;

- (void)setValue:(id)value forKey:(NSString *)key{
  //因为已经知道要修改的key所以可以直接判定相等
  if ([key isEqualToString:@"id"]) {
    //进行替换
    [self setValue:value forKeyPath:@"ID"];
  }else{
    //抛回父类处理
    [super setValue:value forKey:key];
  }
}
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
      self.ID = [self objectOrNilForKey:kNSWYContentID fromDictionary:dict] ;
            self.isNewRecord = [[self objectOrNilForKey:kNSWYContentIsNewRecord fromDictionary:dict] boolValue];
            self.fdoctype = [self objectOrNilForKey:kNSWYContentFdoctype fromDictionary:dict];
            self.ftype = [self objectOrNilForKey:kNSWYContentFtype fromDictionary:dict];
            self.fspeciesid = [self objectOrNilForKey:kNSWYContentFspeciesid fromDictionary:dict];
            self.ftown = [self objectOrNilForKey:kNSWYContentFtown fromDictionary:dict];
            self.contentIdentifier = [self objectOrNilForKey:kNSWYContentId fromDictionary:dict];
            self.ftitle = [self objectOrNilForKey:kNSWYContentFtitle fromDictionary:dict];
            self.forigininfo = [self objectOrNilForKey:kNSWYContentForigininfo fromDictionary:dict];
            self.fkeywords = [self objectOrNilForKey:kNSWYContentFkeywords fromDictionary:dict];
            self.fdiseaseid = [self objectOrNilForKey:kNSWYContentFdiseaseid fromDictionary:dict];
            self.fuserdoctypeid = [self objectOrNilForKey:kNSWYContentFuserdoctypeid fromDictionary:dict];
            self.fcontent = [self objectOrNilForKey:kNSWYContentFcontent fromDictionary:dict];
            self.fvediosrc = [self objectOrNilForKey:kNSWYContentFvediosrc fromDictionary:dict];
            self.fgeneralproductname = [self objectOrNilForKey:kNSWYContentFgeneralproductname fromDictionary:dict];
            self.fremarks = [self objectOrNilForKey:kNSWYContentFremarks fromDictionary:dict];
            self.fstate = [[self objectOrNilForKey:kNSWYContentFstate fromDictionary:dict] doubleValue];
            self.fcityid = [self objectOrNilForKey:kNSWYContentFcityid fromDictionary:dict];
            self.fcountryid = [self objectOrNilForKey:kNSWYContentFcountryid fromDictionary:dict];
            self.fpestsid = [self objectOrNilForKey:kNSWYContentFpestsid fromDictionary:dict];
            self.fremindcontent = [self objectOrNilForKey:kNSWYContentFremindcontent fromDictionary:dict];
            self.fvisibleteamid = [self objectOrNilForKey:kNSWYContentFvisibleteamid fromDictionary:dict];
            self.fimgsrc = [self objectOrNilForKey:kNSWYContentFimgsrc fromDictionary:dict];
            self.updateDate = [self objectOrNilForKey:kNSWYContentUpdateDate fromDictionary:dict];
            self.fremind = [self objectOrNilForKey:kNSWYContentFremind fromDictionary:dict];
            self.fclause = [self objectOrNilForKey:kNSWYContentFclause fromDictionary:dict];
            self.fprovinceid = [self objectOrNilForKey:kNSWYContentFprovinceid fromDictionary:dict];
            self.remarks = [self objectOrNilForKey:kNSWYContentRemarks fromDictionary:dict];
            self.fupdatetime = [self objectOrNilForKey:kNSWYContentFupdatetime fromDictionary:dict];
            self.fvillage = [self objectOrNilForKey:kNSWYContentFvillage fromDictionary:dict];
            self.fabstract = [self objectOrNilForKey:kNSWYContentFabstract fromDictionary:dict];
            self.fdeletetime = [self objectOrNilForKey:kNSWYContentFdeletetime fromDictionary:dict];
            self.createDate = [self objectOrNilForKey:kNSWYContentCreateDate fromDictionary:dict];
            self.fclassifiedid = [self objectOrNilForKey:kNSWYContentFclassifiedid fromDictionary:dict];
            self.fextprop = [self objectOrNilForKey:kNSWYContentFextprop fromDictionary:dict];
            self.fcustomcategoriesid = [self objectOrNilForKey:kNSWYContentFcustomcategoriesid fromDictionary:dict];
            self.fistopage = [[self objectOrNilForKey:kNSWYContentFistopage fromDictionary:dict] doubleValue];
            self.fvisittype = [[self objectOrNilForKey:kNSWYContentFvisittype fromDictionary:dict] doubleValue];
            self.fvisitorcount = [[self objectOrNilForKey:kNSWYContentFvisitorcount fromDictionary:dict] doubleValue];
            self.freprintstatement = [self objectOrNilForKey:kNSWYContentFreprintstatement fromDictionary:dict];
            self.fcreatetime = [self objectOrNilForKey:kNSWYContentFcreatetime fromDictionary:dict];
            self.findustryname = [self objectOrNilForKey:kNSWYContentFindustryname fromDictionary:dict];
            self.forigin = [[self objectOrNilForKey:kNSWYContentForigin fromDictionary:dict] doubleValue];
            self.fzoneid = [self objectOrNilForKey:kNSWYContentFzoneid fromDictionary:dict];
            self.fspeciesname = [self objectOrNilForKey:kNSWYContentFspeciesname fromDictionary:dict];
            self.fdoctypeid = [self objectOrNilForKey:kNSWYContentFdoctypeid fromDictionary:dict];
            self.fgeneralservicename = [self objectOrNilForKey:kNSWYContentFgeneralservicename fromDictionary:dict];
            self.fauthor = [self objectOrNilForKey:kNSWYContentFauthor fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithBool:self.isNewRecord] forKey:kNSWYContentIsNewRecord];
  [mutableDict setObject:self.ID forKey:kNSWYContentID];
    [mutableDict setValue:self.fdoctype forKey:kNSWYContentFdoctype];
    [mutableDict setValue:self.ftype forKey:kNSWYContentFtype];
    [mutableDict setValue:self.fspeciesid forKey:kNSWYContentFspeciesid];
    [mutableDict setValue:self.ftown forKey:kNSWYContentFtown];
    [mutableDict setValue:self.contentIdentifier forKey:kNSWYContentId];
    [mutableDict setValue:self.ftitle forKey:kNSWYContentFtitle];
    [mutableDict setValue:self.forigininfo forKey:kNSWYContentForigininfo];
    [mutableDict setValue:self.fkeywords forKey:kNSWYContentFkeywords];
    [mutableDict setValue:self.fdiseaseid forKey:kNSWYContentFdiseaseid];
    [mutableDict setValue:self.fuserdoctypeid forKey:kNSWYContentFuserdoctypeid];
    [mutableDict setValue:self.fcontent forKey:kNSWYContentFcontent];
    [mutableDict setValue:self.fvediosrc forKey:kNSWYContentFvediosrc];
    [mutableDict setValue:self.fgeneralproductname forKey:kNSWYContentFgeneralproductname];
    [mutableDict setValue:self.fremarks forKey:kNSWYContentFremarks];
    [mutableDict setValue:[NSNumber numberWithDouble:self.fstate] forKey:kNSWYContentFstate];
    [mutableDict setValue:self.fcityid forKey:kNSWYContentFcityid];
    [mutableDict setValue:self.fcountryid forKey:kNSWYContentFcountryid];
    [mutableDict setValue:self.fpestsid forKey:kNSWYContentFpestsid];
    [mutableDict setValue:self.fremindcontent forKey:kNSWYContentFremindcontent];
    [mutableDict setValue:self.fvisibleteamid forKey:kNSWYContentFvisibleteamid];
    [mutableDict setValue:self.fimgsrc forKey:kNSWYContentFimgsrc];
    [mutableDict setValue:self.updateDate forKey:kNSWYContentUpdateDate];
    [mutableDict setValue:self.fremind forKey:kNSWYContentFremind];
    [mutableDict setValue:self.fclause forKey:kNSWYContentFclause];
    [mutableDict setValue:self.fprovinceid forKey:kNSWYContentFprovinceid];
    [mutableDict setValue:self.remarks forKey:kNSWYContentRemarks];
    [mutableDict setValue:self.fupdatetime forKey:kNSWYContentFupdatetime];
    [mutableDict setValue:self.fvillage forKey:kNSWYContentFvillage];
    [mutableDict setValue:self.fabstract forKey:kNSWYContentFabstract];
    [mutableDict setValue:self.fdeletetime forKey:kNSWYContentFdeletetime];
    [mutableDict setValue:self.createDate forKey:kNSWYContentCreateDate];
    [mutableDict setValue:self.fclassifiedid forKey:kNSWYContentFclassifiedid];
    [mutableDict setValue:self.fextprop forKey:kNSWYContentFextprop];
    [mutableDict setValue:self.fcustomcategoriesid forKey:kNSWYContentFcustomcategoriesid];
    [mutableDict setValue:[NSNumber numberWithDouble:self.fistopage] forKey:kNSWYContentFistopage];
    [mutableDict setValue:[NSNumber numberWithDouble:self.fvisittype] forKey:kNSWYContentFvisittype];
    [mutableDict setValue:[NSNumber numberWithDouble:self.fvisitorcount] forKey:kNSWYContentFvisitorcount];
    [mutableDict setValue:self.freprintstatement forKey:kNSWYContentFreprintstatement];
    [mutableDict setValue:self.fcreatetime forKey:kNSWYContentFcreatetime];
    [mutableDict setValue:self.findustryname forKey:kNSWYContentFindustryname];
    [mutableDict setValue:[NSNumber numberWithDouble:self.forigin] forKey:kNSWYContentForigin];
    [mutableDict setValue:self.fzoneid forKey:kNSWYContentFzoneid];
    [mutableDict setValue:self.fspeciesname forKey:kNSWYContentFspeciesname];
    [mutableDict setValue:self.fdoctypeid forKey:kNSWYContentFdoctypeid];
    [mutableDict setValue:self.fgeneralservicename forKey:kNSWYContentFgeneralservicename];
    [mutableDict setValue:self.fauthor forKey:kNSWYContentFauthor];

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
  self.ID = [aDecoder decodeObjectForKey:kNSWYContentID];
    self.isNewRecord = [aDecoder decodeBoolForKey:kNSWYContentIsNewRecord];
    self.fdoctype = [aDecoder decodeObjectForKey:kNSWYContentFdoctype];
    self.ftype = [aDecoder decodeObjectForKey:kNSWYContentFtype];
    self.fspeciesid = [aDecoder decodeObjectForKey:kNSWYContentFspeciesid];
    self.ftown = [aDecoder decodeObjectForKey:kNSWYContentFtown];
    self.contentIdentifier = [aDecoder decodeObjectForKey:kNSWYContentId];
    self.ftitle = [aDecoder decodeObjectForKey:kNSWYContentFtitle];
    self.forigininfo = [aDecoder decodeObjectForKey:kNSWYContentForigininfo];
    self.fkeywords = [aDecoder decodeObjectForKey:kNSWYContentFkeywords];
    self.fdiseaseid = [aDecoder decodeObjectForKey:kNSWYContentFdiseaseid];
    self.fuserdoctypeid = [aDecoder decodeObjectForKey:kNSWYContentFuserdoctypeid];
    self.fcontent = [aDecoder decodeObjectForKey:kNSWYContentFcontent];
    self.fvediosrc = [aDecoder decodeObjectForKey:kNSWYContentFvediosrc];
    self.fgeneralproductname = [aDecoder decodeObjectForKey:kNSWYContentFgeneralproductname];
    self.fremarks = [aDecoder decodeObjectForKey:kNSWYContentFremarks];
    self.fstate = [aDecoder decodeDoubleForKey:kNSWYContentFstate];
    self.fcityid = [aDecoder decodeObjectForKey:kNSWYContentFcityid];
    self.fcountryid = [aDecoder decodeObjectForKey:kNSWYContentFcountryid];
    self.fpestsid = [aDecoder decodeObjectForKey:kNSWYContentFpestsid];
    self.fremindcontent = [aDecoder decodeObjectForKey:kNSWYContentFremindcontent];
    self.fvisibleteamid = [aDecoder decodeObjectForKey:kNSWYContentFvisibleteamid];
    self.fimgsrc = [aDecoder decodeObjectForKey:kNSWYContentFimgsrc];
    self.updateDate = [aDecoder decodeObjectForKey:kNSWYContentUpdateDate];
    self.fremind = [aDecoder decodeObjectForKey:kNSWYContentFremind];
    self.fclause = [aDecoder decodeObjectForKey:kNSWYContentFclause];
    self.fprovinceid = [aDecoder decodeObjectForKey:kNSWYContentFprovinceid];
    self.remarks = [aDecoder decodeObjectForKey:kNSWYContentRemarks];
    self.fupdatetime = [aDecoder decodeObjectForKey:kNSWYContentFupdatetime];
    self.fvillage = [aDecoder decodeObjectForKey:kNSWYContentFvillage];
    self.fabstract = [aDecoder decodeObjectForKey:kNSWYContentFabstract];
    self.fdeletetime = [aDecoder decodeObjectForKey:kNSWYContentFdeletetime];
    self.createDate = [aDecoder decodeObjectForKey:kNSWYContentCreateDate];
    self.fclassifiedid = [aDecoder decodeObjectForKey:kNSWYContentFclassifiedid];
    self.fextprop = [aDecoder decodeObjectForKey:kNSWYContentFextprop];
    self.fcustomcategoriesid = [aDecoder decodeObjectForKey:kNSWYContentFcustomcategoriesid];
    self.fistopage = [aDecoder decodeDoubleForKey:kNSWYContentFistopage];
    self.fvisittype = [aDecoder decodeDoubleForKey:kNSWYContentFvisittype];
    self.fvisitorcount = [aDecoder decodeDoubleForKey:kNSWYContentFvisitorcount];
    self.freprintstatement = [aDecoder decodeObjectForKey:kNSWYContentFreprintstatement];
    self.fcreatetime = [aDecoder decodeObjectForKey:kNSWYContentFcreatetime];
    self.findustryname = [aDecoder decodeObjectForKey:kNSWYContentFindustryname];
    self.forigin = [aDecoder decodeDoubleForKey:kNSWYContentForigin];
    self.fzoneid = [aDecoder decodeObjectForKey:kNSWYContentFzoneid];
    self.fspeciesname = [aDecoder decodeObjectForKey:kNSWYContentFspeciesname];
    self.fdoctypeid = [aDecoder decodeObjectForKey:kNSWYContentFdoctypeid];
    self.fgeneralservicename = [aDecoder decodeObjectForKey:kNSWYContentFgeneralservicename];
    self.fauthor = [aDecoder decodeObjectForKey:kNSWYContentFauthor];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
  [aCoder encodeObject:_ID forKey:kNSWYContentID];
    [aCoder encodeBool:_isNewRecord forKey:kNSWYContentIsNewRecord];
    [aCoder encodeObject:_fdoctype forKey:kNSWYContentFdoctype];
    [aCoder encodeObject:_ftype forKey:kNSWYContentFtype];
    [aCoder encodeObject:_fspeciesid forKey:kNSWYContentFspeciesid];
    [aCoder encodeObject:_ftown forKey:kNSWYContentFtown];
    [aCoder encodeObject:_contentIdentifier forKey:kNSWYContentId];
    [aCoder encodeObject:_ftitle forKey:kNSWYContentFtitle];
    [aCoder encodeObject:_forigininfo forKey:kNSWYContentForigininfo];
    [aCoder encodeObject:_fkeywords forKey:kNSWYContentFkeywords];
    [aCoder encodeObject:_fdiseaseid forKey:kNSWYContentFdiseaseid];
    [aCoder encodeObject:_fuserdoctypeid forKey:kNSWYContentFuserdoctypeid];
    [aCoder encodeObject:_fcontent forKey:kNSWYContentFcontent];
    [aCoder encodeObject:_fvediosrc forKey:kNSWYContentFvediosrc];
    [aCoder encodeObject:_fgeneralproductname forKey:kNSWYContentFgeneralproductname];
    [aCoder encodeObject:_fremarks forKey:kNSWYContentFremarks];
    [aCoder encodeDouble:_fstate forKey:kNSWYContentFstate];
    [aCoder encodeObject:_fcityid forKey:kNSWYContentFcityid];
    [aCoder encodeObject:_fcountryid forKey:kNSWYContentFcountryid];
    [aCoder encodeObject:_fpestsid forKey:kNSWYContentFpestsid];
    [aCoder encodeObject:_fremindcontent forKey:kNSWYContentFremindcontent];
    [aCoder encodeObject:_fvisibleteamid forKey:kNSWYContentFvisibleteamid];
    [aCoder encodeObject:_fimgsrc forKey:kNSWYContentFimgsrc];
    [aCoder encodeObject:_updateDate forKey:kNSWYContentUpdateDate];
    [aCoder encodeObject:_fremind forKey:kNSWYContentFremind];
    [aCoder encodeObject:_fclause forKey:kNSWYContentFclause];
    [aCoder encodeObject:_fprovinceid forKey:kNSWYContentFprovinceid];
    [aCoder encodeObject:_remarks forKey:kNSWYContentRemarks];
    [aCoder encodeObject:_fupdatetime forKey:kNSWYContentFupdatetime];
    [aCoder encodeObject:_fvillage forKey:kNSWYContentFvillage];
    [aCoder encodeObject:_fabstract forKey:kNSWYContentFabstract];
    [aCoder encodeObject:_fdeletetime forKey:kNSWYContentFdeletetime];
    [aCoder encodeObject:_createDate forKey:kNSWYContentCreateDate];
    [aCoder encodeObject:_fclassifiedid forKey:kNSWYContentFclassifiedid];
    [aCoder encodeObject:_fextprop forKey:kNSWYContentFextprop];
    [aCoder encodeObject:_fcustomcategoriesid forKey:kNSWYContentFcustomcategoriesid];
    [aCoder encodeDouble:_fistopage forKey:kNSWYContentFistopage];
    [aCoder encodeDouble:_fvisittype forKey:kNSWYContentFvisittype];
    [aCoder encodeDouble:_fvisitorcount forKey:kNSWYContentFvisitorcount];
    [aCoder encodeObject:_freprintstatement forKey:kNSWYContentFreprintstatement];
    [aCoder encodeObject:_fcreatetime forKey:kNSWYContentFcreatetime];
    [aCoder encodeObject:_findustryname forKey:kNSWYContentFindustryname];
    [aCoder encodeDouble:_forigin forKey:kNSWYContentForigin];
    [aCoder encodeObject:_fzoneid forKey:kNSWYContentFzoneid];
    [aCoder encodeObject:_fspeciesname forKey:kNSWYContentFspeciesname];
    [aCoder encodeObject:_fdoctypeid forKey:kNSWYContentFdoctypeid];
    [aCoder encodeObject:_fgeneralservicename forKey:kNSWYContentFgeneralservicename];
    [aCoder encodeObject:_fauthor forKey:kNSWYContentFauthor];
}

- (id)copyWithZone:(NSZone *)zone
{
    NSWYContent *copy = [[NSWYContent alloc] init];
    
    if (copy) {
      copy.ID = self.ID;
        copy.isNewRecord = self.isNewRecord;
        copy.fdoctype = [self.fdoctype copyWithZone:zone];
        copy.ftype = [self.ftype copyWithZone:zone];
        copy.fspeciesid = [self.fspeciesid copyWithZone:zone];
        copy.ftown = [self.ftown copyWithZone:zone];
        copy.contentIdentifier = [self.contentIdentifier copyWithZone:zone];
        copy.ftitle = [self.ftitle copyWithZone:zone];
        copy.forigininfo = [self.forigininfo copyWithZone:zone];
        copy.fkeywords = [self.fkeywords copyWithZone:zone];
        copy.fdiseaseid = [self.fdiseaseid copyWithZone:zone];
        copy.fuserdoctypeid = [self.fuserdoctypeid copyWithZone:zone];
        copy.fcontent = [self.fcontent copyWithZone:zone];
        copy.fvediosrc = [self.fvediosrc copyWithZone:zone];
        copy.fgeneralproductname = [self.fgeneralproductname copyWithZone:zone];
        copy.fremarks = [self.fremarks copyWithZone:zone];
        copy.fstate = self.fstate;
        copy.fcityid = [self.fcityid copyWithZone:zone];
        copy.fcountryid = [self.fcountryid copyWithZone:zone];
        copy.fpestsid = [self.fpestsid copyWithZone:zone];
        copy.fremindcontent = [self.fremindcontent copyWithZone:zone];
        copy.fvisibleteamid = [self.fvisibleteamid copyWithZone:zone];
        copy.fimgsrc = [self.fimgsrc copyWithZone:zone];
        copy.updateDate = [self.updateDate copyWithZone:zone];
        copy.fremind = [self.fremind copyWithZone:zone];
        copy.fclause = [self.fclause copyWithZone:zone];
        copy.fprovinceid = [self.fprovinceid copyWithZone:zone];
        copy.remarks = [self.remarks copyWithZone:zone];
        copy.fupdatetime = [self.fupdatetime copyWithZone:zone];
        copy.fvillage = [self.fvillage copyWithZone:zone];
        copy.fabstract = [self.fabstract copyWithZone:zone];
        copy.fdeletetime = [self.fdeletetime copyWithZone:zone];
        copy.createDate = [self.createDate copyWithZone:zone];
        copy.fclassifiedid = [self.fclassifiedid copyWithZone:zone];
        copy.fextprop = [self.fextprop copyWithZone:zone];
        copy.fcustomcategoriesid = [self.fcustomcategoriesid copyWithZone:zone];
        copy.fistopage = self.fistopage;
        copy.fvisittype = self.fvisittype;
        copy.fvisitorcount = self.fvisitorcount;
        copy.freprintstatement = [self.freprintstatement copyWithZone:zone];
        copy.fcreatetime = [self.fcreatetime copyWithZone:zone];
        copy.findustryname = [self.findustryname copyWithZone:zone];
        copy.forigin = self.forigin;
        copy.fzoneid = [self.fzoneid copyWithZone:zone];
        copy.fspeciesname = [self.fspeciesname copyWithZone:zone];
        copy.fdoctypeid = [self.fdoctypeid copyWithZone:zone];
        copy.fgeneralservicename = [self.fgeneralservicename copyWithZone:zone];
        copy.fauthor = [self.fauthor copyWithZone:zone];
    }
    
    return copy;
}


@end
