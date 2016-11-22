//
//  CommentTool.m
//  Sample
//
//  Created by Mac on 16/11/18.
//  Copyright © 2016年 Facebook. All rights reserved.
//

#import "CommentsTool.h"
#define ZJWidth [UIScreen mainScreen].bounds.size.width

#define JZHeight [UIScreen mainScreen].bounds.size.height
@implementation CommentsTool

-(void)setFrame:(CGRect)frame{
  
  frame = CGRectMake(0, JZHeight-49, ZJWidth, 49);
  
  [super setFrame:frame];
}

+ (instancetype)tool{
  CommentsTool *  window = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil].firstObject;
  window.windowLevel =UIWindowLevelAlert;
  //[window makeKeyAndVisible];
  return    window;
  
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
- (IBAction)collect:(UIButton *)sender {
  sender.selected =!sender.selected;
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
