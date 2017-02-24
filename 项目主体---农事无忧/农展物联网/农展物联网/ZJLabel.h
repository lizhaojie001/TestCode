//
//  ZJLabel.h
//  农展物联网
//
//  Created by Mac on 2/24/17.
//  Copyright © 2017 HBNXWLKJ. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^ZJlCompletionBlock)( );
@interface ZJLabel : UILabel

- (void)zj_setLabelText:(NSString *)text  placeholderText:(NSString * )placeholder  completed:(ZJlCompletionBlock)completedBlock;
@end
