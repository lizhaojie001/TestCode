//
//  ViewController.m
//  农展物联网
//
//  Created by Mac on 17/1/12.
//  Copyright © 2017年 HBNXWLKJ. All rights reserved.
//

#import "ViewController.h"
#import "ZJPrivilegeController.h"
#import "ZJDisplayController.h"
#import "ZJNaviController.h"
#import "ZJAboutUsController.h"
#import "ZJSenceController.h"
#import "ZJControlEquipmentController.h"
#import "ZJLoginController.h"
#import "ZJMeController.h"
@interface ViewController ()

@end

@implementation ViewController
- (IBAction)jamp:(id)sender {
    ZJPrivilegeController* Privilege = [[ZJPrivilegeController alloc]init];
    [self.navigationController pushViewController:Privilege animated:YES];
}
- (IBAction)Display {
    ZJDisplayController * display = [[ZJDisplayController alloc]init];
    display.view.backgroundColor = [UIColor whiteColor];
    ZJNaviController *nav =       (ZJNaviController*)display.navigationController;
    nav.display = YES;
 
    [self.navigationController pushViewController:display animated:YES];
}
- (IBAction)AboutUs {
    UIStoryboard * storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    ZJAboutUsController * about = [storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([ZJAboutUsController class]) ];
    [self.navigationController pushViewController:about animated:YES];
}
- (IBAction)showSence {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    ZJSenceController * Sence = [[ZJSenceController alloc]initWithCollectionViewLayout:layout];
    
    [self.navigationController pushViewController:Sence animated:YES];

}
- (IBAction)controlEquipment {
    UIStoryboard * storyBorad = [UIStoryboard  storyboardWithName:@"Main" bundle:nil];
    ZJControlEquipmentController * equipment = [storyBorad instantiateViewControllerWithIdentifier:NSStringFromClass([ZJControlEquipmentController class])];
    [self.navigationController pushViewController:equipment animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //self.view.layer.masksToBounds = YES;
//    self.navigationController.navigationBar.backgroundColor = ZJGreenColor;
//    self.view.layer.cornerRadius = 6;
//    self.view.layer.borderColor = ZJBGColor.CGColor;
//    self.view.layer.borderWidth = 1;
//UITextField
    // Do any additional setup after loading the view, typically from a nib.
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
        ZJlogFunction;
}
- (IBAction)Me{
    UIStoryboard * storyBorad = [UIStoryboard  storyboardWithName:@"Main" bundle:nil];
      ZJMeController * me = [storyBorad instantiateViewControllerWithIdentifier:NSStringFromClass([ZJMeController class])];
    [self.navigationController pushViewController:me animated:YES];
    
}
- (IBAction)login {
    UIStoryboard * storyBorad = [UIStoryboard  storyboardWithName:@"Main" bundle:nil];
    ZJLoginController * Login = [storyBorad instantiateViewControllerWithIdentifier:NSStringFromClass([ZJLoginController class])];
    ZJlogFunction;
    [self.navigationController pushViewController:Login animated:YES];

}


@end
