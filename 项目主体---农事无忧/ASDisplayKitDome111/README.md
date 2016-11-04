ASDisplayKitDome
===

Demo
---
**Don't remember install Pods**


使用了框架的ASCellNode 和ASTableView \ 布局
简单的水平垂直布局
---
```
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

```

加入了一些图片等元素
---
```
//(默认每个cell都包含 : 发布日期 评论(数) 赞(数) 标题)  作者 头像 分类  cell高度设定为90
-(ASLayoutSpec*)layoutMySubViewsOfNewsCellStyleHaveImageAndAuthorWithAvatarAndCategory{
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
  
  _categoryLabel.flexShrink =YES;
  _commentsLabel.flexShrink =YES;
  ASStackLayoutSpec *horizontalStackSpec2 = [ASStackLayoutSpec horizontalStackLayoutSpec];
  horizontalStackSpec2.alignItems = ASStackLayoutAlignItemsCenter; // center items vertically in horiz stack
  horizontalStackSpec2.justifyContent = ASStackLayoutJustifyContentStart; // justify content to left

  horizontalStackSpec2.flexShrink = YES;
  [horizontalStackSpec2 setChildren:@[_categoryLabel,spacerSpec,_commentsLabel]];
 
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

```
效果图:
![](http://7xntys.com1.z0.glb.clouddn.com/21A44B77-78E5-405C-A809-BDF05636C9C3.png)
