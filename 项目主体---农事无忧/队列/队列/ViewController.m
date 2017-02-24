//
//  ViewController.m
//  队列
//
//  Created by Mac on 2/24/17.
//  Copyright © 2017 HBNXWLKJ. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
 [super viewDidLoad];
    
     [self syncMain];
    
    // Do any additional setup after loading the view, typically from a nib.
}
- (void)syncMain{
    
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    
    
    for (int i = 1 ; i < 31; i++) {
        
        dispatch_sync(queue, ^{
            NSLog(@"------------1");
        });
        dispatch_sync(queue, ^{
            NSLog(@"------------2");
        });
        dispatch_sync(queue, ^{
            NSLog(@"------------3");
        });

    }
   }

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
