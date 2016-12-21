//
//  nswyTopic.m
//  nswy-1
//
//  Created by Mac on 16/12/2.
//  Copyright © 2016年 HBNXWLKJ. All rights reserved.
//

#import "nswyTopic.h"

@interface nswyTopic()
/**存储button*/
@property (nonatomic,strong) NSMutableArray * buttonArr;

/**设置专题名字*/
@property (nonatomic,strong) NSArray * nameArr;
@end


@implementation nswyTopic
- (instancetype)initWithNumBer:(NSArray *)NameArr{
    if (self =[super init]) {
        _nameArr = NameArr;
        self.showsHorizontalScrollIndicator = NO;
      self.contentSize = CGSizeMake(NameArr.count*105+20, 80);
        [self setUpButtons];
    }
    return self;
    
}


-(void)layoutSubviews{
    [super layoutSubviews];
    int i = 1;
    for (UIButton  * button in self.buttonArr) {
        
        if (i==button.tag) {
              button.frame = CGRectMake(20+(105*i-105), 20, 100, 40);
                      i++;
        }
        
        
    }
}

- (void)setUpButtons{
    
    for (int i = 0; i <_nameArr.count ; i++) {
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:_nameArr[i] forState:UIControlStateNormal];
        [button setBackgroundImage:_imageArr[i] forState:UIControlStateNormal];
        button.tag =  i+1;
        [button setBackgroundColor:[UIColor orangeColor]];
        [button addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
        button.layer.cornerRadius = 3;
        button.titleEdgeInsets = UIEdgeInsetsMake(0, -30, 0, 0);
        [self addSubview:button];
        [self.buttonArr addObject:button];
    }
    
}

- (void)clickButton:(UIButton* )buuton{
    if ([self.topicDelegate respondsToSelector:@selector(didClickItemWith:  )]) {
        [self.topicDelegate didClickItemWith:buuton];
    }
    
    
}




- (NSMutableArray *)buttonArr {
	if(_buttonArr == nil) {
		_buttonArr = [[NSMutableArray alloc] init];
	}
	return _buttonArr;
}
-(void)setFrame:(CGRect)frame{
    
    CGRect Newframe = CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, 80);
    [super setFrame:Newframe];
    
}

-(void)setBounds:(CGRect)bounds{
    CGRect Newframe = CGRectMake(bounds.origin.x, bounds.origin.y, bounds.size.width, 80);
    [super setBounds:Newframe];

}

@end
