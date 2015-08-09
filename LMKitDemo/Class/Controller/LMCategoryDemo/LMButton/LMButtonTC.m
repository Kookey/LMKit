//
//  LMButtonTC.m
//  LMKitDemo
//
//  Created by 李蒙 on 15/8/9.
//  Copyright (c) 2015年 李蒙. All rights reserved.
//

#import "LMButtonTC.h"
#import "LMKit.h"

@interface LMButtonTC ()

@property (weak, nonatomic) IBOutlet UIButton *loginButton;

@end

@implementation LMButtonTC

- (IBAction)loginAction:(id)sender {
    
    [self.loginButton lm_startActivityIndicator];
    
    [self lm_performBlock:^{
        
        [self.loginButton lm_stopActivityIndicator];
        
    } afterDelay:3];
}

@end
