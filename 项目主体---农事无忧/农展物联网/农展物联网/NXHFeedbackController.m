//
//  NXHFeedbackController.m
//  农事无忧
//
//  Created by Mac on 16/10/11.
//  Copyright © 2016年 HBNXWLKJ. All rights reserved.
//

#import "NXHFeedbackController.h"
#import "SVProgressHUD.h"

@interface NXHFeedbackController ()
@property (weak, nonatomic) IBOutlet UITextView *textView;
//@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottom;
@property (weak, nonatomic) IBOutlet UITextField *ContactTextField;
@property (weak, nonatomic)IBOutlet   NSLayoutConstraint *contactConstraint;
/**联系方式对话框约束临时存储*/
@property (nonatomic,strong) NSLayoutConstraint * constraint1;
/**意见对话框临时存储*/
@property (nonatomic,strong) NSLayoutConstraint * constraint2;

/**<#注释#>*/
@property (nonatomic,assign) CGFloat  spacing;


@end

@implementation NXHFeedbackController
- (IBAction)submit:(id)sender {
 
        [SVProgressHUD showWithStatus:@"提交中..."];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [SVProgressHUD showSuccessWithStatus:@"成功"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5* NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
             [UIView animateWithDuration:1 animations:^{
                 [SVProgressHUD dismiss];

             }];
                          });
        });
   
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"意见反馈";
    
    ;
  
    self.constraint2.constant = self.bottom.constant;
    self.constraint1.constant  = self.contactConstraint.constant;

    self.textView.layer.cornerRadius = 5;
    // Do any additional setup after loading the view from its nib.
     
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

 
-(void)keyboardWillShow:(NSNotification*)notification{
    CGRect _keyboardRect = [[[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue] ;
    CGFloat H = _keyboardRect.size.height;
  
 
    if ([self.textView canBecomeFirstResponder]) {
      [UIView animateWithDuration:2 animations:^{
          self.bottom.constant =H+2;
          [self.view layoutSubviews];
      }  ];
       
    }
   
     
    if ( [self.ContactTextField isEditing]){
        
        [UIView animateWithDuration:0.5 animations:^{
            self.bottom.constant = H+self.ContactTextField.height+10;
            self.contactConstraint.constant = H;
            //+self.ContactTextField.height;
          //  self.spacing = Spacing;
            [self.view layoutSubviews];

        }];
        CGFloat   Spacing = -self.textView.y +self.ContactTextField.y - self.textView.height;
      
             
    }
    //  self.bottom.constant = constant;
  
     
    ZJlogFunction;
}
-(void)keyboardWillHide:(NSNotification*)notification{
    ZJlogFunction;
    CGRect _keyboardRect = [[[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue] ;
     
    CGFloat H = _keyboardRect.size.height;
    self.contactConstraint.constant   = self.constraint1.constant;
    self.bottom.constant = self.constraint2.constant;
//    + self.ContactTextField.height+ self.spacing;
     [self.view layoutSubviews];
//    //[self.view removeConstraint:self.constraint];
//    [self.view addConstraint:self.bottom];
//    [self.view updateConstraintsIfNeeded];
//    
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
    //[self.view resignFirstResponder];
  //  [self.textView resignFirstResponder];
    ZJlogFunction;
}


- (NSLayoutConstraint *)constraint1 {
	if(_constraint1 == nil) {
		_constraint1 = [[NSLayoutConstraint alloc] init];
	}
	return _constraint1;
}

- (NSLayoutConstraint *)constraint2 {
	if(_constraint2 == nil) {
		_constraint2 = [[NSLayoutConstraint alloc] init];
	}
	return _constraint2;
}

@end
