//
//  main.m
//  replace
//
//  Created by Mac on 16/11/22.
//  Copyright © 2016年 HBNXWLKJ. All rights reserved.
//

#import <Foundation/Foundation.h>
  NSString *  IMG =@"<img style=\"width:650px;height:431px;\" alt=\"\" src=\
\"http://www.ns51.cn/KindUpload/Image/20140108/20140108_143832_679snail.JPG\" width=\
\"650\" height=\"649\" />";
int main(int argc, const char * argv[]) {
    @autoreleasepool {
        NSString *staString = [NSString stringWithUTF8String:"[self. label setText: @\"hello world\"];"];
        NSString *parten = @"(\\s)*(\\[)(\\s)*(self)(\\s)*(.)(\\s)*(label)(\\s)*(setText)(\\s)*(:)(\\s)*(@)(\\s)*(\".*\")(\\s)*(\\])(\\s)*(;)(\\s)*";
        
        NSError* error = NULL;
        
        NSRegularExpression *reg = [NSRegularExpression regularExpressionWithPattern:parten options:nil error:&error];
        
        NSArray* match = [reg matchesInString:staString options:NSMatchingCompleted range:NSMakeRange(0, [staString length])];
        
        if (match.count != 0)
        {
            for (NSTextCheckingResult *matc in match)
            {
                NSRange range = [matc range];
                NSLog(@"%lu,%lu,%@",(unsigned long)range.location,(unsigned long)range.length,[staString substringWithRange:range]);
            }  
        }
        
        
        
        
    }
    return 0;
}
/*
int getInt( NSString * str ,NSString * parten ,BOOL HorW){
    
    int lenth =  HorW?12:11;
    int beginLoc = HorW?8:7;
    NSError * error = NULL;
    
    NSRegularExpression *reg = [NSRegularExpression regularExpressionWithPattern:parten options:NSRegularExpressionAnchorsMatchLines|NSRegularExpressionDotMatchesLineSeparators|NSRegularExpressionAllowCommentsAndWhitespace error:&error];
    NSArray* match = [reg matchesInString:str options:NSMatchingReportCompletion range:NSMakeRange(0, [str length])];
    
    if (match.count != 0)
    {
        for (NSTextCheckingResult *matc in match)
         {
             NSString * a = [str substringWithRange:[matc range]];
             
            if (a.length ==lenth)
            {
                NSRange range = {beginLoc,3};
                a =    [a substringWithRange:range];
                
            }else if (a.length ==(lenth-1))
            {
                NSRange range = {beginLoc,2};
                a =    [a substringWithRange:range];
                
            }else
            {
                NSRange range = {beginLoc,1};
                a =    [a substringWithRange:range];
               
            }
        return [a intValue ];
             
     }
        
    }
    return 0;
}
*/
