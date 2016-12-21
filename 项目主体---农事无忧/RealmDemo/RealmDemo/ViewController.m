//
//  ViewController.m
//  RealmDemo
//
//  Created by Mac on 16/11/24.
//  Copyright © 2016年 HBNXWLKJ. All rights reserved.
//

#import "ViewController.h"
#import "People.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    Person * jim =[ [Person alloc]init];
    Dog * rex =[[Dog alloc]init];
    rex.owner =jim;
    
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
