//
//  CommentsTool.h
//  Sample
//
//  Created by Mac on 16/11/18.
//  Copyright © 2016年 Facebook. All rights reserved.
//

#import <UIKit/UIKit.h>



typedef enum {
  
  ZJTextFieldType,
  ZJWatchCommmentType,
  ZJCollectType,
  ZJShareType
  
  
} ZJButtonType;

@class CommentsTool;
@protocol CommentsToolDelegate <NSObject>

@optional

- (void)CommentTool:(CommentsTool* )CommentsTool didClickButton:(ZJButtonType)item;

@end
@interface CommentsTool : UIWindow
@property (weak, nonatomic) IBOutlet UITextField *comment;
@property (weak, nonatomic) IBOutlet UIButton *WatchComments;
@property (weak, nonatomic) IBOutlet UIButton *collection;
@property (weak, nonatomic) IBOutlet UIButton *shareButton;

+(instancetype)tool;


/**代理*/
@property (nonatomic,weak) id<CommentsToolDelegate> toolDelegate;

@end
