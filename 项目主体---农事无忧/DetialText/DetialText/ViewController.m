//
//  ViewController.m
//  DetialText
//
//  Created by Mac on 16/11/7.
//  Copyright © 2016年 HBNXWLKJ. All rights reserved.
//

#import "ViewController.h"
#import "DetialTableViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)goto:(id)sender {
    DetialTableViewController * a = [[DetialTableViewController alloc]initWithStyle:UITableViewStylePlain];
    [self presentViewController:a animated:YES completion:nil];
}

@end
