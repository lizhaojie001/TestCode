//
//  DataModels.h
//  Sample
//
//  Created by Mac on 16/11/29.
//  Copyright © 2016年 Facebook. All rights reserved.
//

#import <Realm/Realm.h>

@interface NSWYContent : RLMObject

@property   NSString * id;
@property  bool isNewRecord;
@property  NSString *fdoctype;
@property  NSString * ftype;
@property  NSString *fspeciesid;
@property  NSString *ftown;
@property  NSString *contentIdentifier;
@property  NSString *ftitle;
@property  NSString * forigininfo;
@property  NSString *fkeywords;
@property  NSString * fdiseaseid;
@property  NSString * fuserdoctypeid;
@property  NSString *fcontent;
@property  NSString * fvediosrc;
@property  NSString * fgeneralproductname;
@property  NSString *fremarks;
@property  int fstate;
@property  NSString * fcityid;
@property  NSString * fcountryid;
@property  NSString * fpestsid;
@property  NSString * fremindcontent;
@property  NSString * fvisibleteamid;
@property  NSString * fimgsrc;
@property  NSString *  updateDate;
@property  NSString * fremind;
@property  NSString * fclause;
@property  NSString * fprovinceid;
@property  NSString * remarks;
@property  NSString *fupdatetime;
@property  NSString * fvillage;
@property  NSString * fabstract;
@property  NSString * fdeletetime;
@property  NSString * createDate;
@property  NSString * fclassifiedid;
@property  NSString * fextprop;
@property  NSString * fcustomcategoriesid;
@property  int  fistopage;
@property  NSNumber <RLMInt> *  fvisittype;
@property  NSNumber<RLMInt> * fvisitorcount;
@property  NSNumber<RLMInt> * freprintstatement;//是否允许转载
@property  NSString * fcreatetime;
@property  NSString * findustryname;
@property  int forigin;
@property  NSString * fzoneid;
@property  NSString * fspeciesname;
@property  NSString * fdoctypeid;
@property  NSString * fgeneralservicename;
@property  NSString * fauthor;
@end
RLM_ARRAY_TYPE(NSWYContent)




@interface NSWYList : RLMObject

@property  NSString *fcommentuser;
@property  NSString *listIdentifier;
@property  NSString * fcreatetime;
@property  NSString * fupdatetime;

@property  NSString *flinkid;
@property  NSString *fcomment;
@property   bool isNewRecord;

@property  NSString *fcommentdate;
@property  NSNumber<RLMInt> * fclass;
@property   NSString* remarks;
@property   NSString * fdeletetime;


@end

RLM_ARRAY_TYPE(NSWYList)


@interface NSWYCommentPage : RLMObject

@property   int pageSize;
@property   int pageNo;
@property   int firstResult;
@property   int count;
@property   RLMArray<NSWYList > *list;
@property   int maxResults;



@end
RLM_ARRAY_TYPE(NSWYCommentPage)


/**
 *  资讯模型
 */
@interface DataModels : RLMObject
@property   NSNumber<RLMInt> * total;
@property   RLMArray<NSWYContent> *content;
//@property  NSWYCommentPage *commentPage;
@property NSString *uuid;
 
@end

// This protocol enables typed collections. i.e.:
// RLMArray<DataModels>
RLM_ARRAY_TYPE(DataModels)




