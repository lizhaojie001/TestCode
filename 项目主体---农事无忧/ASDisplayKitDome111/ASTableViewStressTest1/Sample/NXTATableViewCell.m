//
//  NXTATableViewCell.m
//  咨询解析
//
//  Created by Mac on 16/10/31.
//  Copyright © 2016年 HBNXWLKJ. All rights reserved.
//

#import "NXTATableViewCell.h"
#import "NSWYContent.h"
 
@implementation NXTATableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier WithNewsCellStyle:(NewsCellStyle)NewsCellStyle{
    if (self = [super init]) {
        
        _NewsCellStyle = NewsCellStyle;
        //_rightImageViewSize = 80;
        [self createView];
    }
    return self;
}
-(ASLayoutSpec* )layoutSpecThatFits:(ASSizeRange)constrainedSize{
    switch (_NewsCellStyle) {
        case NewsCellStyleHaveImageAndAuthorWithAvatarAndCategory:
            [self  addSubnode:_EditorButton];
            [self  addSubnode:_rightImageView];
            [self  addSubnode:_categoryLabel];
            [self  addSubnode:_Avatar];
     return        [self layoutMySubViewsOfNewsCellStyleHaveImageAndAuthorWithAvatarAndCategory];
            
            
        case NewsCellStyleHaveImage:
            [self addSubnode:_rightImageView];
        return     [self layoutMySubViewsOfNewsCellStyleHaveImage];
               
        case NewsCellStyleHaveImageAndAuthor:
            [self  addSubnode:_rightImageView];
            [self  addSubnode:_EditorButton];
        return   [self layoutMySubViewsOfNewsCellStyleHaveImageAndAuthor];
            
          
        case NewsCellStyleHaveImageAndAuthorWithAvatar:
            [self  addSubnode:_rightImageView];
            [self  addSubnode:_EditorButton];
            [self  addSubnode:_Avatar];
         return    [self layoutMySubViewsOfNewsCellStyleHaveImageAndAuthorWithAvatar];
            
        default :
       return     [self layoutMySubViewsOfNewsCellStyleDefault];
           
    }
       
}

-(void)setContent:(NSWYContent *)content{
  _content =content;
 // _EditorButton.backgroundColor= [UIColor greenColor];
 
  _titleLabel .attributedText =[[NSAttributedString alloc]initWithString:[NSString stringWithFormat:@"    %@",content.ftitle] attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:17]}]; 
_categoryLabel.attributedText =[[NSAttributedString alloc]initWithString:@"分类" attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:10]}];
  
  _commentsLabel.attributedText = [[NSAttributedString alloc]initWithString:[NSString stringWithFormat:@" 👓%d   · 👍%d",content.fvisitorcount?content.fvisitorcount:0 ,content.fvisitorcount?content.fvisitorcount:0] attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:10]}];
   _releaseDateLabel.attributedText =[[NSAttributedString alloc]initWithString:content.fcreatetime attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:10]}];
  _commentsLabel.truncationMode = NSLineBreakByTruncatingTail ;
  NSString * name ;
  if (content.fauthor == nil) {
    name = @"未知";
  }else{
    name = content.fauthor;
  }
   
    [_EditorButton  setTitle:name withFont:[UIFont systemFontOfSize:10] withColor:[UIColor redColor] forState:ASControlStateNormal];
  //_commentsLabel.backgroundColor = [UIColor lightTextColor];
}
- (void)createView{
    _EditorButton =[ASButtonNode new];
    
    _rightImageView=[ASImageNode new];
    _categoryLabel = [ASTextNode new];
    _commentsLabel = [ASTextNode new];
    _releaseDateLabel = [ASTextNode new];
    _titleLabel =[ASTextNode new];
    _Avatar =[ASImageNode new];
    [self  addSubnode:_releaseDateLabel];
    [self addSubnode:_commentsLabel];
    [self addSubnode:_titleLabel];
    
 
  

//  [_EditorButton setTitle:@"naem" withFont:[UIFont systemFontOfSize:10] withColor:[UIColor redColor] forState:ASControlStateNormal];

    _Avatar.image =  [UIImage imageNamed:@"favicon"];
    _Avatar.contentMode = UIViewContentModeScaleAspectFill;
  //   [_EditorImageButton setImage:_Avatar forState:ASControlStateNormal];
   _Avatar.preferredFrameSize =CGSizeMake(20, 20);
 // _Avatar.backgroundColor = [UIColor redColor];
    //_EditorImageButton.imageView.contentMode = UIViewContentModeScaleAspectFill;
  
   
  //    _EditorButton.preferredFrameSize =CGSizeMake(15, 20);
     //  _EditorButton.titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;

    
   
    _releaseDateLabel.tintColor = [UIColor yellowColor];
  //  _releaseDateLabel.backgroundColor = [UIColor redColor];
  
  _titleLabel.truncationMode = NSLineBreakByTruncatingTail;
  //  _titleLabel.maximumNumberOfLines  = 0;
     
    
    
  //_categoryLabel.shouldRasterizeDescendants = YES;
//    _categoryLabel.layer.borderColor =  [UIColor redColor].CGColor;
   // _categoryLabel.layer.borderWidth = 1;
   
//    _categoryLabel.layer.masksToBounds = YES;
     
   // _categoryLabel.backgroundColor = [UIColor greenColor];
    
    _rightImageView.image = [UIImage imageNamed:@"favicon"];
  _rightImageView.preferredFrameSize =CGSizeMake(60, 60);
    [_rightImageView setContentMode:UIViewContentModeScaleToFill];
    
  
}

-(ASLayoutSpec *)layoutMySubViewsOfNewsCellStyleDefault{
  //设置可伸缩
    _releaseDateLabel.flexShrink = YES;
    
    _titleLabel.flexShrink = YES;
    
    _commentsLabel.flexShrink = YES;
    //创建竖直布局对象
     ASStackLayoutSpec *verticalStackSpec = [ASStackLayoutSpec verticalStackLayoutSpec];
    
    verticalStackSpec.flexShrink = YES;
    //添加布局需要的子控件
    [verticalStackSpec setChildren:@[_releaseDateLabel,_titleLabel,_commentsLabel]];
    
    //初始化一个弹簧
    ASLayoutSpec *spacerSpec = [[ASLayoutSpec alloc] init];
    spacerSpec.flexGrow = YES;
    spacerSpec.flexShrink = YES;
    //初始化一个水平布局
    ASStackLayoutSpec *horizontalStackSpec = [ASStackLayoutSpec horizontalStackLayoutSpec];
  //设置元素中心对其
    horizontalStackSpec.alignItems = ASStackLayoutAlignItemsCenter; // center items vertically in horiz stack
  //设置内容显示 位置
    horizontalStackSpec.justifyContent = ASStackLayoutJustifyContentStart; // justify content to left
    horizontalStackSpec.flexShrink = YES;
    horizontalStackSpec.flexGrow = YES;
    [horizontalStackSpec setChildren:@[verticalStackSpec]];
    
    
    // inset horizontal stack  设置内边距
    UIEdgeInsets insets = UIEdgeInsetsMake(10, 10,
                                           10, 10);
    ASInsetLayoutSpec *headerInsetSpec = [ASInsetLayoutSpec insetLayoutSpecWithInsets:insets child:horizontalStackSpec];
    headerInsetSpec.flexShrink = YES;
    headerInsetSpec.flexGrow = YES;
    
    return headerInsetSpec;
   }

 
//(默认每个cell都包含 : 发布日期 评论(数) 赞(数) 标题)  作者 头像 分类  cell高度设定为90
-(ASLayoutSpec*)layoutMySubViewsOfNewsCellStyleHaveImageAndAuthorWithAvatarAndCategory{
  ASLayoutSpec *spacerSpec = [[ASLayoutSpec alloc] init];
  spacerSpec.flexGrow = YES;
  spacerSpec.flexShrink = NO;

  
  
  _Avatar.flexShrink = YES;
  _EditorButton.flexShrink = YES;
  _releaseDateLabel.flexShrink = YES;
  ASStackLayoutSpec *horizontalStackSpec1 = [ASStackLayoutSpec horizontalStackLayoutSpec];
  horizontalStackSpec1.flexShrink = YES;
 
  horizontalStackSpec1.alignItems = ASStackLayoutAlignItemsCenter; // center items vertically in horiz stack
  horizontalStackSpec1.justifyContent = ASStackLayoutJustifyContentStart; // justify content to left
  
  horizontalStackSpec1.flexGrow = YES;
   
  [horizontalStackSpec1 setChildren:@[_Avatar,spacerSpec,_EditorButton,spacerSpec,_releaseDateLabel]];
 
  _titleLabel.flexShrink = YES;
  
  _categoryLabel.flexShrink =YES;
  _commentsLabel.flexShrink =YES;
  ASStackLayoutSpec *horizontalStackSpec2 = [ASStackLayoutSpec horizontalStackLayoutSpec];
  horizontalStackSpec2.alignItems = ASStackLayoutAlignItemsCenter; // center items vertically in horiz stack
  horizontalStackSpec2.justifyContent = ASStackLayoutJustifyContentStart; // justify content to left

  horizontalStackSpec2.flexShrink = YES;
  [horizontalStackSpec2 setChildren:@[_categoryLabel,spacerSpec,_commentsLabel]];

  
 
  
  
  
  ASStackLayoutSpec *verticalStackSpec = [ASStackLayoutSpec verticalStackLayoutSpec];
  
  verticalStackSpec.flexShrink = YES;
  
 
  [verticalStackSpec setChildren:@[horizontalStackSpec1,spacerSpec,_titleLabel,spacerSpec,horizontalStackSpec2]];
 
 
  ASStackLayoutSpec *horizontalStackLayoutSpec  = [ASStackLayoutSpec horizontalStackLayoutSpec];
  
  horizontalStackLayoutSpec.flexShrink = NO;
   horizontalStackLayoutSpec.alignItems=ASStackLayoutAlignItemsCenter;
  horizontalStackLayoutSpec.justifyContent = ASStackLayoutJustifyContentSpaceBetween;
  [horizontalStackLayoutSpec setChildren:@[verticalStackSpec ,spacerSpec, _rightImageView]];
  
  UIEdgeInsets insets = UIEdgeInsetsMake(10, 10,
                                         10, 10);

  
  ASInsetLayoutSpec *headerInsetSpec3 = [ASInsetLayoutSpec insetLayoutSpecWithInsets:insets child:horizontalStackLayoutSpec];
  headerInsetSpec3.flexShrink = NO;
  headerInsetSpec3.flexGrow = NO;
  
  return headerInsetSpec3;
}
 
// (默认每个cell都包含 : 发布日期 评论(数) 赞(数) 标题)  90
//NewsCellStyleHaveImage 含有右侧图片
-(ASLayoutSpec*)layoutMySubViewsOfNewsCellStyleHaveImage{
 ASLayoutSpec *spacerSpec = [[ASLayoutSpec alloc] init];
 spacerSpec.flexGrow = YES;
 spacerSpec.flexShrink = YES;
  
 _releaseDateLabel.flexShrink = YES;
  
 
 _titleLabel.flexShrink = YES;
 
 _categoryLabel.flexShrink =YES;
 _commentsLabel.flexShrink =YES;
 ASStackLayoutSpec *horizontalStackSpec2 = [ASStackLayoutSpec horizontalStackLayoutSpec];
 horizontalStackSpec2.alignItems = ASStackLayoutAlignItemsCenter; // center items vertically in horiz stack
 horizontalStackSpec2.justifyContent = ASStackLayoutJustifyContentStart; // justify content to left
 
 horizontalStackSpec2.flexShrink = YES;
 [horizontalStackSpec2 setChildren:@[ _commentsLabel]];
 
 
 
 
 
 
 ASStackLayoutSpec *verticalStackSpec = [ASStackLayoutSpec verticalStackLayoutSpec];
 
 verticalStackSpec.flexShrink = YES;
 
 
 [verticalStackSpec setChildren:@[_releaseDateLabel,_titleLabel,horizontalStackSpec2]];
 
 
 ASStackLayoutSpec *horizontalStackLayoutSpec  = [ASStackLayoutSpec horizontalStackLayoutSpec];
 
 horizontalStackLayoutSpec.flexShrink = YES;
 horizontalStackLayoutSpec.alignItems=ASStackLayoutAlignItemsCenter;
 horizontalStackLayoutSpec.justifyContent = ASStackLayoutJustifyContentStart;
 [horizontalStackLayoutSpec setChildren:@[verticalStackSpec ,_rightImageView]];
 
 UIEdgeInsets insets = UIEdgeInsetsMake(10, 10,
 10, 10);
 
 
 ASInsetLayoutSpec *headerInsetSpec3 = [ASInsetLayoutSpec insetLayoutSpecWithInsets:insets child:horizontalStackLayoutSpec];
 headerInsetSpec3.flexShrink = YES;
 headerInsetSpec3.flexGrow = YES;
 
 return headerInsetSpec3;

}
 /*
 *    NewsCellStyleHaveImageAndAuthor,//含有作者名字(button)和右侧图片
 */
 
-(ASLayoutSpec*)layoutMySubViewsOfNewsCellStyleHaveImageAndAuthor{
     
  ASLayoutSpec *spacerSpec = [[ASLayoutSpec alloc] init];
  spacerSpec.flexGrow = YES;
  spacerSpec.flexShrink = YES;
  
  
  
   
  _EditorButton.flexShrink = YES;
  _releaseDateLabel.flexShrink = YES;
  ASStackLayoutSpec *horizontalStackSpec1 = [ASStackLayoutSpec horizontalStackLayoutSpec];
  horizontalStackSpec1.flexShrink = YES;
  
  horizontalStackSpec1.alignItems = ASStackLayoutAlignItemsCenter; // center items vertically in horiz stack
  horizontalStackSpec1.justifyContent = ASStackLayoutJustifyContentStart; // justify content to left
  
  horizontalStackSpec1.flexGrow = YES;
  
  [horizontalStackSpec1 setChildren:@[_EditorButton,spacerSpec,_releaseDateLabel]];
  
  _titleLabel.flexShrink = YES;
  
  
  _commentsLabel.flexShrink =YES;
  ASStackLayoutSpec *horizontalStackSpec2 = [ASStackLayoutSpec horizontalStackLayoutSpec];
  horizontalStackSpec2.alignItems = ASStackLayoutAlignItemsCenter; // center items vertically in horiz stack
  horizontalStackSpec2.justifyContent = ASStackLayoutJustifyContentStart; // justify content to left
  
  horizontalStackSpec2.flexShrink = YES;
  [horizontalStackSpec2 setChildren:@[ _commentsLabel]];
  
  
  
  
  
  
  ASStackLayoutSpec *verticalStackSpec = [ASStackLayoutSpec verticalStackLayoutSpec];
  
  verticalStackSpec.flexShrink = YES;
  
  
  [verticalStackSpec setChildren:@[horizontalStackSpec1,_titleLabel,horizontalStackSpec2]];
  
  
  ASStackLayoutSpec *horizontalStackLayoutSpec  = [ASStackLayoutSpec horizontalStackLayoutSpec];
  
  horizontalStackLayoutSpec.flexShrink = YES;
  horizontalStackLayoutSpec.alignItems=ASStackLayoutAlignItemsCenter;
  horizontalStackLayoutSpec.justifyContent = ASStackLayoutJustifyContentStart;
  [horizontalStackLayoutSpec setChildren:@[verticalStackSpec ,_rightImageView]];
  
  UIEdgeInsets insets = UIEdgeInsetsMake(10, 10,
                                         10, 10);
  
  
  ASInsetLayoutSpec *headerInsetSpec3 = [ASInsetLayoutSpec insetLayoutSpecWithInsets:insets child:horizontalStackLayoutSpec];
  headerInsetSpec3.flexShrink = YES;
  headerInsetSpec3.flexGrow = YES;
  
  return headerInsetSpec3;
}
 
 /*  NewsCellStyleHaveImageAndAuthorWithAvatar ,//含有作者名字头像(button)和右侧图片   
 */
 
-(ASLayoutSpec*)layoutMySubViewsOfNewsCellStyleHaveImageAndAuthorWithAvatar{
  ASLayoutSpec *spacerSpec = [[ASLayoutSpec alloc] init];
  spacerSpec.flexGrow = YES;
  spacerSpec.flexShrink = YES;
  
  
  
  _Avatar.flexShrink = YES;
  _EditorButton.flexShrink = YES;
  _releaseDateLabel.flexShrink = YES;
  ASStackLayoutSpec *horizontalStackSpec1 = [ASStackLayoutSpec horizontalStackLayoutSpec];
  horizontalStackSpec1.flexShrink = YES;
  
  horizontalStackSpec1.alignItems = ASStackLayoutAlignItemsCenter; // center items vertically in horiz stack
  horizontalStackSpec1.justifyContent = ASStackLayoutJustifyContentStart; // justify content to left
  
  horizontalStackSpec1.flexGrow = YES;
  
  [horizontalStackSpec1 setChildren:@[_Avatar,spacerSpec,_EditorButton,spacerSpec,_releaseDateLabel]];
  
  _titleLabel.flexShrink = YES;
  
   
  _commentsLabel.flexShrink =YES;
  ASStackLayoutSpec *horizontalStackSpec2 = [ASStackLayoutSpec horizontalStackLayoutSpec];
  horizontalStackSpec2.alignItems = ASStackLayoutAlignItemsCenter; // center items vertically in horiz stack
  horizontalStackSpec2.justifyContent = ASStackLayoutJustifyContentStart; // justify content to left
  
  horizontalStackSpec2.flexShrink = YES;
  [horizontalStackSpec2 setChildren:@[ _commentsLabel]];
  
  
  
  
  
  
  ASStackLayoutSpec *verticalStackSpec = [ASStackLayoutSpec verticalStackLayoutSpec];
  
  verticalStackSpec.flexShrink = YES;
  
  
  [verticalStackSpec setChildren:@[horizontalStackSpec1,_titleLabel,horizontalStackSpec2]];
  
  
  ASStackLayoutSpec *horizontalStackLayoutSpec  = [ASStackLayoutSpec horizontalStackLayoutSpec];
  
  horizontalStackLayoutSpec.flexShrink = YES;
  horizontalStackLayoutSpec.alignItems=ASStackLayoutAlignItemsCenter;
  horizontalStackLayoutSpec.justifyContent = ASStackLayoutJustifyContentStart;
  [horizontalStackLayoutSpec setChildren:@[verticalStackSpec ,_rightImageView]];
  
  UIEdgeInsets insets = UIEdgeInsetsMake(10, 10,
                                         10, 10);
  
  
  ASInsetLayoutSpec *headerInsetSpec3 = [ASInsetLayoutSpec insetLayoutSpecWithInsets:insets child:horizontalStackLayoutSpec];
  headerInsetSpec3.flexShrink = YES;
  headerInsetSpec3.flexGrow = YES;
  
  return headerInsetSpec3;
  }

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

 
 
@end
