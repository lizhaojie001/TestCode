/**
 !! 随便弄了一下，只是为了 目前项目的使用.过几天会 完善
 !! 加入单例等
 
 有问题可以联系 邮箱 906037367@qq.com
 QQ               906037367
 

 */

#import "PellTableViewSelect.h"
#define  LeftView 10.0f
#define  TopToView 10.0f
@interface  PellTableViewSelect()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,copy) NSArray *selectData;
@property (nonatomic,copy) void(^action)(NSInteger index);
@property (nonatomic,copy) NSArray * imagesData;
///**frame*/
//@property (nonatomic,assign) CGRect  Frame ;

@end



PellTableViewSelect * backgroundView;
UITableView * tableView;
CGRect Frame;
@implementation PellTableViewSelect
{
    CGRect Frame;
}

- (instancetype)init{
    if (self = [super init]) {
    }
    return self;
}
- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]) {
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
    }
    return self;
}

+ (void)addPellTableViewSelectWithWindowFrame:(CGRect)frame
                                   selectData:(NSArray *)selectData
                                       images:(NSArray *)images
                                       action:(void(^)(NSInteger index))action animated:(BOOL)animate
{
    Frame = frame;
    if (backgroundView != nil) {
        [PellTableViewSelect hiden];
    }
    UIWindow *win = [[[UIApplication sharedApplication] windows] firstObject];
    
    backgroundView = [[PellTableViewSelect alloc] initWithFrame:win.bounds];
    backgroundView.action = action;
    backgroundView.imagesData = images ;
    backgroundView.selectData = selectData;
    backgroundView.backgroundColor = [UIColor colorWithHue:0
                                                saturation:0
                                                brightness:0 alpha:0.1];
    [win addSubview:backgroundView];
    CGFloat W=  [UIScreen mainScreen].bounds.size.width;
    // TAB
     tableView = [[UITableView alloc] initWithFrame:CGRectMake(W/2,64.0 -  20.0 * selectData.count,frame.size.width,40 * selectData.count) style:0];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//    tableView = [[UITableView alloc] initWithFrame:CGRectMake(  [UIScreen mainScreen].bounds.size.width - 80 , 70.0 -  20.0 * selectData.count , frame.size.width, 40 * selectData.count) style:0];
    tableView.dataSource = backgroundView;
//    tableView.transform =  CGAffineTransformMakeScale(0.5, 0.5);
    tableView.delegate = backgroundView;
    tableView.layer.cornerRadius = 10.0f;
    // 定点
    tableView.layer.anchorPoint = CGPointMake(1.0, 0);
    tableView.transform =CGAffineTransformMakeScale(1, 0.0001);
    
    tableView.rowHeight = 40;
    [win addSubview:tableView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapBackgroundClick)];
    [backgroundView addGestureRecognizer:tap];
    backgroundView.action = action;
    backgroundView.selectData = selectData;
//    tableView.layer.anchorPoint = CGPointMake(100, 64);


    if (animate == YES) {
        backgroundView.alpha = 0;
//        tableView.frame = CGRectMake([UIScreen mainScreen].bounds.size.width - 80, 70, frame.size.width, 40 * selectData.count);
        [UIView animateWithDuration:0.2 animations:^{
            backgroundView.alpha = 0.5;
            CGAffineTransform t = CGAffineTransformMakeScale(1.0, 1.0);
            tableView.transform =t;
        }];
    }
}
+ (void)tapBackgroundClick
{
    [PellTableViewSelect hiden];
}
+ (void)hiden
{
    if (backgroundView != nil) {
        
        [UIView animateWithDuration:0.1 animations:^{
              backgroundView.alpha = 0;
//            UIWindow * win = [[[UIApplication sharedApplication] windows] firstObject];
//            tableView.frame = CGRectMake(win.bounds.size.width - 35 , 64, 0, 0);
           CGAffineTransform t=  CGAffineTransformMakeScale(1,0.0001);
            tableView.transform =   t;
            
        } completion:^(BOOL finished) {
            [backgroundView removeFromSuperview];
            [tableView removeFromSuperview];
            tableView = nil;
            backgroundView = nil;
        }];
    }
   
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _selectData.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *Identifier = @"PellTableViewSelectIdentifier";
    UITableViewCell *cell =  [tableView dequeueReusableCellWithIdentifier:Identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:0 reuseIdentifier:Identifier];
    }
    cell.imageView.image = [UIImage imageNamed:self.imagesData[indexPath.row]];
    cell.textLabel.text = _selectData[indexPath.row];
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.action) {
        self.action(indexPath.row);
    }
    [PellTableViewSelect hiden];
}

#pragma mark 绘制三角形
- (void)drawRect:(CGRect)rect

{
    
    
    //    [colors[serie] setFill];
    // 设置背景色
    [[UIColor whiteColor] set];
    //拿到当前视图准备好的画板
    
    CGContextRef  context = UIGraphicsGetCurrentContext();
    
    //利用path进行绘制三角形
    
    CGContextBeginPath(context);//标记
    CGFloat x =   [UIScreen mainScreen].bounds.size.width/2.0;
    CGFloat y = 64;
    CGContextMoveToPoint(context,
                         x-10, y);//设置起点
    
    CGContextAddLineToPoint(context,
                             x , y-10);
    
    CGContextAddLineToPoint(context,
                            x+10, y);
    
    CGContextClosePath(context);//路径结束标志，不写默认封闭
    
    [[UIColor whiteColor] setFill];  //设置填充色
    
    [[UIColor whiteColor] setStroke]; //设置边框颜色
    
    CGContextDrawPath(context,
                      kCGPathFillStroke);//绘制路径path
    
//    [self setNeedsDisplay];
}

@end
