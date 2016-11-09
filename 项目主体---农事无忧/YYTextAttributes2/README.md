
字符串捆绑
=== 
```
 NSMutableAttributedString * str = [[NSMutableAttributedString alloc]initWithString:@"@农资" ];
    
    [str insertString:@"   " atIndex:0];
    [str appendString:@"   "];
    str.font = [UIFont boldSystemFontOfSize:16];
    str.color = [UIColor blackColor];
    [str setTextBinding:[YYTextBinding bindingWithDeleteConfirm:NO] range:str.rangeOfAll];
    
    YYTextBorder * border = [YYTextBorder new];
    border.strokeColor = [UIColor lightTextColor];
    border.strokeWidth = 1.5;
    border.fillColor = [UIColor lightTextColor];
   // border.strokeColor = [UIColor blueColor];
    border.cornerRadius = 100;
    border.insets = UIEdgeInsetsMake(-2, -5, -2, -5);
    
    [str setTextBorder:border];
    
    str.lineSpacing = 20;
    str.lineBreakMode = NSLineBreakByWordWrapping;
    
    [str appendString:@"\n"];
    
    [str appendAttributedString:str];
    
    
//    YYLabel * label = [YYLabel new];
//    label.attributedText = str;
//    label.size = self.view.size;
//    label.numberOfLines =0;
//
//         label.textContainerInset =  UIEdgeInsetsMake(10 + ([UIDevice currentDevice].systemVersion.doubleValue>7.0 ? 64 : 0), 10, 10, 10);
//    [self.view addSubview:label];
    
    
    YYTextView * textView = [YYTextView new];
      textView.attributedText = str;
    textView.size = self.view.size;
    textView.textContainerInset = UIEdgeInsetsMake(10 + ([UIDevice currentDevice].systemVersion.doubleValue>7.0 ? 64 : 0), 10, 10, 10);
    
    textView.allowsCopyAttributedString = YES;
    textView.allowsPasteAttributedString =YES;
    textView.scrollIndicatorInsets = textView.contentInset;
       [self.view addSubview:textView];
       
```