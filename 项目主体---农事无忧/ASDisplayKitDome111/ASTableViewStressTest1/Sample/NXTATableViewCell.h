//
//  NXTATableViewCell.h
//  咨询解析
//
//  Created by Mac on 16/10/31.
//  Copyright © 2016年 HBNXWLKJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AsyncDisplayKit.h> 

//默认每个cell都包含 : 发布日期 评论(数) 赞(数) 标题
typedef enum:NSUInteger{
    NewsCellStyleDefault  =0,
    NewsCellStyleHaveImage,//含有右侧图片
    NewsCellStyleHaveImageAndAuthor,//含有作者名字(button)和右侧图片
    NewsCellStyleHaveImageAndAuthorWithAvatar ,//含有作者名字头像(button)和右侧图片   
    NewsCellStyleHaveImageAndAuthorWithAvatarAndCategory,//含有作者名字头像(button)和右侧图片和分类
} NewsCellStyle;
@interface NXTATableViewCell : ASCellNode
/**文章标题*/
@property (nonatomic,strong) ASTextNode * titleLabel;

/**评论数和点赞*/
@property (nonatomic,strong) ASTextNode * commentsLabel;

/**发布日期*/
@property (nonatomic,strong) ASTextNode * releaseDateLabel;

/**Avatar*/
@property (nonatomic,strong) ASImageNode* Avatar;

/**Editor*/
@property (nonatomic,strong) NSString * Editor;
/**头像名字*/
@property (nonatomic,strong) ASButtonNode *  EditorButton;
/**头像按钮*/
@property (nonatomic,strong) ASButtonNode *  EditorImageButton;


/**右侧图片*/
@property (nonatomic,strong) ASImageNode * rightImageView;
/**右侧图片大小*/
@property (nonatomic,assign) CGFloat  rightImageViewSize;

/**分类*/
@property (nonatomic,strong) ASTextNode * categoryLabel;


/**NewsCellStyle*/
@property (nonatomic,assign)  NewsCellStyle  NewsCellStyle;

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier WithNewsCellStyle:(NewsCellStyle)NewsCellStyle;


@end
