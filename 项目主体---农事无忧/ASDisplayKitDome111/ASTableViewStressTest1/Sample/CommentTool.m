//
//  CommentTool.m
//  Sample
//
//  Created by Mac on 16/11/18.
//  Copyright © 2016年 Facebook. All rights reserved.
//

#import "CommentTool.h"
#define ZJWidth [UIScreen mainScreen].bounds.size.width

#define JZHeight [UIScreen mainScreen].bounds.size.height
@implementation CommentTool

-(void)setFrame:(CGRect)frame{
  
  frame = CGRectMake(0, JZHeight-49, ZJWidth, 49);
  
  [super setFrame:frame];
}

+ (instancetype)tool{
 
  //[window makeKeyAndVisible];
  return    [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil].firstObject;
 
}
- (IBAction)comment:(id)sender {
  
  if ([self.toolDelegate respondsToSelector:@selector(CommentTool:didClickButton: )]) {
    [self.toolDelegate CommentTool:self didClickButton:ZJTextFieldType];
  }
  
}
- (IBAction)watchComments:(id)sender {
  if ([self.toolDelegate respondsToSelector:@selector(CommentTool:didClickButton:)]) {
    [self.toolDelegate CommentTool:self didClickButton:ZJWatchCommmentType];
  }
  
}
- (IBAction)collect:(id)sender {
  if ([self.toolDelegate respondsToSelector:@selector(CommentTool:didClickButton:)]) {
    [self.toolDelegate CommentTool:self didClickButton:ZJCollectType];
  }
  
}
- (IBAction)share:(id)sender {
  if ([self.toolDelegate respondsToSelector:@selector(CommentTool:didClickButton:)]) {
    [self.toolDelegate CommentTool:self didClickButton:ZJShareType];
  }
  
}

@end
