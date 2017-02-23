//
//  ZJUser.m
//  农展物联网
//
//  Created by Mac on 17/2/17.
//  Copyright © 2017年 HBNXWLKJ. All rights reserved.
//

#import "ZJUser.h"

@implementation ZJUser

-(void)saveToPreferance{
    
    
    [[NSUserDefaults standardUserDefaults] setObject:self.UserID forKey:UserID];
     [[NSUserDefaults standardUserDefaults] setObject:self.Mobile forKey:Mobile];
     [[NSUserDefaults standardUserDefaults] setObject:self.TrueName forKey:TrueName];
     [[NSUserDefaults standardUserDefaults] setObject:self.Phone forKey:Phone];
     [[NSUserDefaults standardUserDefaults] setObject:self.LoginName forKey:LoginName];
     [[NSUserDefaults standardUserDefaults] setObject:self.Address forKey:Address];
     [[NSUserDefaults standardUserDefaults] setObject:self.PostCode forKey:PostCode];
     [[NSUserDefaults standardUserDefaults] setObject:self.QQ forKey:QQ];
     [[NSUserDefaults standardUserDefaults] setObject:self.GroupID forKey:GroupID];
     [[NSUserDefaults standardUserDefaults] setObject:self.Email forKey:Email];
 
}

@end
