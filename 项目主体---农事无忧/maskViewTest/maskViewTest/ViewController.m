//
//  ViewController.m
//  maskViewTest
//
//  Created by Mac on 16/9/20.
//  Copyright © 2016年 HBNXWLKJ. All rights reserved.
//

#import "ViewController.h"
#import "UIView+ZJFadeAnimation.h"
@interface ViewController ()
/**iamgeView*/
@property (nonatomic,strong) UIImageView * imageView1;
/**2*/
@property (nonatomic,strong) UIImageView * imageView2;

/**label*/
@property (nonatomic,strong) UILabel * label;
@property (weak, nonatomic) IBOutlet UIStackView *stackView;
@property (weak, nonatomic) IBOutlet UITextField *lines;
@property (weak, nonatomic) IBOutlet UITextField *row;
@property (weak, nonatomic) IBOutlet UITextField *ratio;
@property (weak, nonatomic) IBOutlet UITextField *Interval;
@property (weak, nonatomic) IBOutlet UIButton *configure;

@end

@implementation ViewController
- (IBAction)configure:(id)sender {
    [self config];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self test2];
    [self.view bringSubviewToFront:self.lines];
    [self.view bringSubviewToFront:self.ratio];
    [self.view bringSubviewToFront:self.row];
    [self.view bringSubviewToFront:self.Interval];
    [self.view bringSubviewToFront:self.stackView];
    [self.view bringSubviewToFront:self.configure];
}
- (IBAction)forWord:(id)sender {

    [self.view animateFadeWithComplete:nil  ];


}
- (IBAction)reverse:(id)sender {

    [self.view reverseWithComplete:nil  ];
}
- (IBAction)towforward:(id)sender {

    [self.view animateFadeWithComplete:nil   twoFoward:YES];
    NSLog(@"%s",__func__);
}

- (void)config{
    [self.view configurateWithVerticalCount:[self.row.text integerValue] horizontalCount:[self.lines.text integerValue] ratio:[self.ratio.text floatValue] duration:[self.Interval.text floatValue] withContentView:_imageView2];

}
- (void)test3{
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(50, 50, 200, 50)];
    label.text = @"123454567";
    label.backgroundColor = [UIColor redColor];
    [self.view addSubview:label];
    _label =label;
}
- (void)test2{

    _imageView1 = [[UIImageView alloc] initWithFrame: self.view.bounds];
    _imageView1.image = [UIImage imageNamed:@"123.jpg"];
    [self.view addSubview:_imageView1];
    _imageView2 = [[ UIImageView alloc]initWithFrame:self.view.bounds];
    _imageView2 .image = [UIImage imageNamed:@"11602285792005e56fl.jpg"];
    [self.view addSubview:_imageView2];



      NSLog(@"%@",self.row.text);
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    [self.view endEditing:YES];
//  [UIView animateWithDuration:2 delay:7 options:UIViewAnimationOptionCurveLinear animations:^{
//        _label.frame = CGRectMake(200, 200, 100, 100);
//    } completion:nil];

}
- (void)test{
    self.view.backgroundColor = [UIColor blackColor];
        UIImageView * iamgeview = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"138050-5497241268ca44b4"]];
        iamgeview.frame =CGRectMake(50, 50, 300, 150);
    
        UIImageView * maskView = [[UIImageView alloc]initWithFrame:iamgeview.bounds];
        maskView.image = [UIImage imageNamed:@"138050-6d105f8c1fd7336e"];
        iamgeview.maskView = maskView;
        [self.view addSubview:iamgeview];
    
        UIImageView * iamgeview1 = [[UIImageView alloc]initWithFrame:CGRectMake(50, 300, 300, 150)];
        iamgeview1.image =[UIImage imageNamed:@"138050-5497241268ca44b4"];
        [self.view addSubview:iamgeview1];
    
        UIImageView * iamgeview2 = [[UIImageView alloc]initWithFrame:CGRectMake(50, 500, 300, 150)];
        iamgeview2.alpha =0.5;
        iamgeview2.image =[UIImage imageNamed:@"138050-5497241268ca44b4"];
   [self.view addSubview:iamgeview2];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
