//
//  ZJMemberCenterViewController.m
//  农展物联网
//
//  Created by Mac on 17/2/9.
//  Copyright © 2017年 HBNXWLKJ. All rights reserved.
//

#import "ZJMemberCenterViewController.h"
#import "ZJPrivilegeController.h"
#import "ZJNoticeViewController.h"
#import "UIBarButtonItem+ZJButtonItem.h"
#import "ZJVerButton.h"
@interface ZJMemberCenterViewController ()
@property (weak, nonatomic) IBOutlet ZJVerButton *picBtn;
@property (weak, nonatomic) IBOutlet ZJVerButton *mapBtn;
@property (weak, nonatomic) IBOutlet ZJVerButton *dataBtn;
@property (weak, nonatomic) IBOutlet ZJVerButton *videoBtn;
@property (weak, nonatomic) IBOutlet ZJVerButton *controlBtn;
@property (weak, nonatomic) IBOutlet UIImageView *Avatar;

@end

@implementation ZJMemberCenterViewController
- (IBAction)more {
    ZJPrivilegeController * privilege = [[ZJPrivilegeController alloc]initWithNibName:NSStringFromClass([ZJPrivilegeController class]) bundle:nil];
    [self.navigationController pushViewController:privilege animated:YES];
    
}
- (void)notice {
    ZJNoticeViewController * notice = [[ZJNoticeViewController alloc]initWithStyle:UITableViewStylePlain];
    [self.navigationController pushViewController:notice animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor =ZJBGColor;
    self.title = @"会员中心";
    // Do any additional setup after loading the view.
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImage:@"通知" highImage:nil title:nil target:self action:@selector(notice)];
    
    [self setupPicOfBtn];
    
    
}

- (void)setupPicOfBtn{
    
    switch ([[[NSUserDefaults standardUserDefaults] valueForKey:GroupID] intValue]) {
        case 1:
            [self.picBtn setImage:[UIImage imageNamed:@"tu-blue"] forState:UIControlStateNormal];
            [self.mapBtn setImage:[UIImage imageNamed:@"dt-blue"] forState:UIControlStateNormal];  [self.dataBtn setImage:[UIImage imageNamed:@"sj-blue"] forState:UIControlStateNormal];
            self.videoBtn.hidden = YES;
            self.controlBtn.hidden =YES;
            
            self.Avatar.image = [UIImage imageNamed:@"Avatar1"];
            break;
        case 2:
            [self.picBtn setImage:[UIImage imageNamed:@"tp-gray"] forState:UIControlStateNormal];
            [self.mapBtn setImage:[UIImage imageNamed:@"map-gray"] forState:UIControlStateNormal];
            [self.dataBtn setImage:[UIImage imageNamed:@"sj-gray"] forState:UIControlStateNormal];
            [self.videoBtn setImage:[UIImage imageNamed:@"sp-gray"] forState:UIControlStateNormal];
            self.controlBtn.hidden =YES;
            self.Avatar.image = [UIImage imageNamed:@"Avatar2"];
            
        default:
            [self.picBtn setImage:[UIImage imageNamed:@"tp-gold"] forState:UIControlStateNormal];
            [self.mapBtn setImage:[UIImage imageNamed:@"map-gold"] forState:UIControlStateNormal];
            [self.dataBtn setImage:[UIImage imageNamed:@"sj-gold"] forState:UIControlStateNormal];
            [self.videoBtn setImage:[UIImage imageNamed:@"sp-gold"] forState:UIControlStateNormal];
            [self.controlBtn setImage:[UIImage imageNamed:@"kz-gold"] forState:UIControlStateNormal];
            self.Avatar.image = [UIImage imageNamed:@"Avatar3"];
            
            break;
    }
}

@end
