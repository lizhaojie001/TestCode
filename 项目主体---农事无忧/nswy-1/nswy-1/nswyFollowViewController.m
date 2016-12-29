//
//  nswyFollowViewController.m
//  nswy-1
//
//  Created by Mac on 16/12/2.
//  Copyright © 2016年 HBNXWLKJ. All rights reserved.
//

#import "nswyFollowViewController.h"
#import "nswyFollowCell.h"
#import "PYSearch.h"
#import "PYTempViewController.h"
#import "PellTableViewSelect.h"
#import <CoreText/CoreText.h>
@interface nswyFollowViewController ()<PYSearchViewControllerDelegate,UISearchBarDelegate>
/**搜索框*/
@property (nonatomic,strong) UISearchBar * serachBar;

@end

@implementation nswyFollowViewController
static NSString * followCell = @"followCell";
/**
 *设置searchBar
 */
- (void)setUpSearchBar{
     UISearchBar * searchBar = [[UISearchBar alloc]init];
    searchBar.placeholder = @"搜索你要关注的内容或专家";
    searchBar.searchBarStyle = UISearchBarStyleMinimal;
    self.serachBar = searchBar;
    self.serachBar.delegate = self;
    [self.view addSubview:self.serachBar];
}
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar{
    //跳转:
    ZJLog(@"跳转");
    // 1.创建热门搜索
    NSArray *hotSeaches = @[@"Java", @"Python", @"Objective-C", @"Swift", @"C", @"C++", @"PHP", @"C#", @"Perl", @"Go", @"JavaScript", @"R", @"Ruby", @"MATLAB"];
    // 2. 创建控制器
    PYSearchViewController *searchViewController = [PYSearchViewController searchViewControllerWithHotSearches:hotSeaches searchBarPlaceholder:@"搜索编程语言" didSearchBlock:^(PYSearchViewController *searchViewController, UISearchBar *searchBar, NSString *searchText) {
        // 开始搜索执行以下代码
        // 如：跳转到指定控制器
        [searchViewController.navigationController pushViewController:[[PYTempViewController alloc] init] animated:YES];
    }];
    // 3. 设置风格
    // 选择热门搜索
        searchViewController.hotSearchStyle = PYHotSearchStyleColorfulTag; // 热门搜索风格根据选择
        searchViewController.searchHistoryStyle = PYHotSearchStyleDefault; // 搜索历史风格为default
   
    // 4. 设置代理
    searchViewController.delegate = self;
    // 5. 跳转到搜索控制器
   
    [self.navigationController pushViewController:searchViewController animated:YES];
    return NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpSearchBar];
     self.tableView.showsVerticalScrollIndicator = NO;
    
    
    UIBarButtonItem * item = [[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"添加关注"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(addFoucs:)];
    
    self.navigationItem.leftBarButtonItem = item;
    
   UIButton * titleBtn= [UIButton buttonWithType:UIButtonTypeCustom];
   [titleBtn setFrame:CGRectMake(0, 0, 130, 44)];
    
    /**
     *  不自动拉伸内部对象 自动布局使用
     */
    // titleBtn.translatesAutoresizingMaskIntoConstraints = !titleBtn.translatesAutoresizingMaskIntoConstraints;
    titleBtn.imageEdgeInsets = UIEdgeInsetsMake(0,100, 0, 0);
    titleBtn.titleEdgeInsets = UIEdgeInsetsMake(0, -30, 0, 0);
    

//    [titleBtn titleRectForContentRect:CGRectMake(0, 0, 100, 40)];
    [titleBtn setTitle:@"全部关注" forState:UIControlStateNormal];
    [titleBtn setImage:[UIImage imageNamed:@"箭头上"] forState:UIControlStateNormal];
      [titleBtn setImage:[UIImage imageNamed:@"箭头下"] forState:UIControlStateSelected];
    [titleBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [titleBtn addTarget:self action:@selector(selectFocus:) forControlEvents:UIControlEventTouchUpInside];
      ZJLog(@"%@",NSStringFromCGRect([titleBtn imageRectForContentRect:CGRectMake(100, 0, 24, 24 )]));
//    [titleBtn setContentCompressionResistancePriority:UILayoutPriorityDefaultHigh forAxis:UILayoutConstraintAxisHorizontal];
//        [titleBtn setContentCompressionResistancePriority:UILayoutPriorityDefaultHigh forAxis:UILayoutConstraintAxisVertical];
    self.navigationItem.titleView =titleBtn;
    
  //  self.tableView.contentInset = UIEdgeInsetsMake(40, 0, 0, 0);
    
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([nswyFollowCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:followCell];
    
}

-(void)addFoucs:(UIBarButtonItem * )item{

    ZJlogFunction;
}



-(void)viewDidLayoutSubviews{
    self.tableView.frame = CGRectMake(0, 40, ZJScreenW, ZJScreenH-40);
    self.serachBar.frame = CGRectMake(0,-40, ZJScreenW, 40);
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 10;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (!indexPath.row) {
        UITableViewCell * cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        cell.imageView.image = [UIImage imageNamed:@"圈子"];
        cell.textLabel.text = @"圈子";
        
        return cell;
    }
    nswyFollowCell * cell = [tableView dequeueReusableCellWithIdentifier:followCell forIndexPath:indexPath];
    cell.imageView.image = GetImage(@"物种");
    cell.imageView.backgroundColor = [UIColor redColor];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 80;
}



#pragma mark - PYSearchViewControllerDelegate 搜索框
- (void)searchViewController:(PYSearchViewController *)searchViewController searchTextDidChange:(UISearchBar *)seachBar searchText:(NSString *)searchText
{
    if (searchText.length) { // 与搜索条件再搜索
        // 根据条件发送查询（这里模拟搜索）
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{ // 搜素完毕
            // 显示建议搜索结果
            NSMutableArray *searchSuggestionsM = [NSMutableArray array];
            for (int i = 0; i < arc4random_uniform(5) + 10; i++) {
                NSString *searchSuggestion = [NSString stringWithFormat:@"搜索建议 %d", i];
                [searchSuggestionsM addObject:searchSuggestion];
            }
            // 返回
            searchViewController.searchSuggestions = searchSuggestionsM;
        });
    }
}

#pragma mark -PellTableViewSelect 关注
- (void)selectFocus:(UIButton *)sender{
    ZJLog(@"%i",sender.selected);
    sender.selected =!sender.selected;
    NSArray * arr =@[@"全部关注",@"关注的服务",@"关注的物种",@"关注的商品",@"关注的知识",@"关注的资讯"];
    [PellTableViewSelect addPellTableViewSelectWithWindowFrame:CGRectMake(sender.frame.origin.x,sender.frame.origin.y , 150,150) selectData:arr images:nil action:^(NSInteger index) {
        NSLog(@"选择%ld",index);
        if (sender.selected) {
              sender.selected = NO;
        }
      
        [sender setTitle:arr[index] forState:UIControlStateNormal];
       
       //[sender setImage:[UIImage imageNamed:@"箭头向上"] forState:UIControlStateNormal];
        
    } animated:YES];
    
}
#pragma mark 文字转图片
#define CONTENT_MAX_WIDTH   300.0f

+(UIImage *)imageFromText:(NSArray*) arrContent withFont: (CGFloat)fontSize
{
    // set the font type and size
    UIFont *font = [UIFont systemFontOfSize:fontSize];
    NSMutableArray *arrHeight = [[NSMutableArray alloc] initWithCapacity:arrContent.count];
    
    CGFloat fHeight = 0.0f;
    for (NSString *sContent in arrContent) {
        CGRect stringSize = [sContent boundingRectWithSize:CGSizeMake(CONTENT_MAX_WIDTH, 10000) options:NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName : font} context:nil];
       // CGSize stringSize = [sContent sizeWithFont:font constrainedToSize:CGSizeMake(CONTENT_MAX_WIDTH, 10000) lineBreakMode:UILineBreakModeWordWrap];
        [arrHeight addObject:[NSNumber numberWithFloat:stringSize.size.height]];
        
        fHeight += stringSize.size.height;
    }
    
    
    CGSize newSize = CGSizeMake(CONTENT_MAX_WIDTH+20, fHeight+50);
    
    UIGraphicsBeginImageContextWithOptions(newSize,NO,0.0);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextSetCharacterSpacing(ctx, 10);
    CGContextSetTextDrawingMode (ctx, kCGTextFillStroke);
    CGContextSetRGBFillColor (ctx, 0.1, 0.2, 0.3, 1); // 6
    CGContextSetRGBStrokeColor (ctx, 0, 0, 0, 1);
    
    int nIndex = 0;
    CGFloat fPosY = 20.0f;
    for (NSString *sContent in arrContent) {
        NSNumber *numHeight = [arrHeight objectAtIndex:nIndex];
        CGRect rect = CGRectMake(10, fPosY, CONTENT_MAX_WIDTH , [numHeight floatValue]);
        
        
       // [sContent drawInRect:rect withFont:font lineBreakMode:UILineBreakModeWordWrap alignment:UITextAlignmentLeft];
        [sContent drawInRect:rect withAttributes:@{NSFontAttributeName: font }];
      
        fPosY += [numHeight floatValue];
        nIndex++;
    }
    // transfer image
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
 
    
    
    
    return image;
    
}

UIImage * GetImage( NSString * str) {
    CGSize Size = CGSizeMake(60, 60);
    UIGraphicsBeginImageContextWithOptions(Size,NO,0.0);
    double width; CGContextRef context; CGPoint textPosition; CFAttributedStringRef attrString;
    // Initialize those variables.
   const char * N = [str UTF8String];
    CFStringRef string = CFStringCreateWithCString(kCFAllocatorDefault, N, kCFStringEncodingUTF8 );

    //只绘制150字节 的字符串
    width =60;
    context = UIGraphicsGetCurrentContext();
    
    CGContextTranslateCTM(context, 0, Size.height);
    
    CGContextScaleCTM(context, 1.0, -1.0);
    
    //起始位置
    textPosition = CGPointMake(0.0, 20.0);
    //字形
    //CFStringRef fontName =CFSTR(/*"Papyrus"*/"HanziPenSC-W3");
    //iosfonts.com
    CFStringRef fontName =CFSTR("Papyrus");
    CTFontRef  font =
    CTFontCreateWithName(fontName, 20, NULL);
    //笔调重描痕迹
    CGFloat number = 3.0;
    
    CFNumberRef strokeWidth = CFNumberCreate(kCFAllocatorDefault, kCFNumberFloatType, &number  );
    //笔调颜色重描痕迹
    CGColorSpaceRef space =   CGColorSpaceCreateDeviceRGB();
    CGFloat components[] = {0.5,0.5,0.6,1};
    CGColorRef color = CGColorCreate(space, components);
    // Controls vertical text positioning
    CGFloat superScriptnumber = 1;
    
    CFNumberRef superScript = CFNumberCreate(kCFAllocatorDefault, kCFNumberCGFloatType, &superScriptnumber  );
    //kCTUnderlineStyleAttributeName
    /**
     *    kCTUnderlineStyleNone           = 0x00,
     kCTUnderlineStyleSingle         = 0x01,
     kCTUnderlineStyleThick          = 0x02,
     kCTUnderlineStyleDouble         = 0x09
     */
    CGFloat UnderlineStylenumber =kCTUnderlineStyleNone|kCTUnderlinePatternSolid ;
    
    CFNumberRef UnderlineStyle = CFNumberCreate(kCFAllocatorDefault, kCFNumberCGFloatType, &UnderlineStylenumber  );
    //kCTUnderlineColorAttributeName
    CGColorSpaceRef Underlinespace =   CGColorSpaceCreateDeviceRGB();
    CGFloat Underlinecomponents[] = {0.0,0.5,0.5,1};
    CGColorRef Underlinecolor = CGColorCreate(Underlinespace, Underlinecomponents);
    //kCTVerticalFormsAttributeName 文字方向
    CFBooleanRef t = kCFBooleanFalse;
    
  
    CFStringRef keys[] = { kCTFontAttributeName,kCTStrokeWidthAttributeName ,kCTStrokeColorAttributeName,kCTSuperscriptAttributeName,kCTUnderlineColorAttributeName,kCTUnderlineStyleAttributeName,kCTVerticalFormsAttributeName/*,kCTGlyphInfoAttributeName*/ };
    
    CFTypeRef values[] = { font ,strokeWidth,color,superScript,Underlinecolor, UnderlineStyle  ,t/*,info*/};
    
    
    
    CFDictionaryRef attributes =
    
    CFDictionaryCreate(kCFAllocatorDefault,(const void**)&keys,
                       
                       (const void**)&values,sizeof(keys)/sizeof(keys[0]) ,
                       
                       &kCFTypeDictionaryKeyCallBacks,
                       
                       &kCFTypeDictionaryValueCallBacks);
    
    
    
    attrString =   CFAttributedStringCreate(kCFAllocatorDefault, string, attributes);
    
    // Create a typesetter using the attributed string.
    CTTypesetterRef typesetter = CTTypesetterCreateWithAttributedString(attrString);
    
    // Find a break for line from the beginning of the string to the given width.
    CFIndex start = 0;
    CFIndex count = CTTypesetterSuggestLineBreak(typesetter, start, width);
    
    // Use the returned character count (to the break) to create the line.
    CTLineRef line = CTTypesetterCreateLine(typesetter, CFRangeMake(start, count));
    
    // Get the offset needed to center the line.
    float flush = 0.5; // centered
    double penOffset = CTLineGetPenOffsetForFlush(line, flush, width);
    
    // Move the given text drawing position by the calculated offset and draw the line.
    CGContextSetTextPosition(context, textPosition.x + penOffset, textPosition.y);
    CTLineDraw(line, context);
    
    // Move the index beyond the line break.
    start += count;
    CGColorRelease(color);
    CGColorRelease(Underlinecolor);
    CGColorSpaceRelease(Underlinespace);
    CGColorSpaceRelease(space);
    // transfer image
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
     return image;
}


@end
