//
//  LMPlaceholderViewTC3.m
//  LMKitDemo
//
//  Created by 李蒙 on 15/9/11.
//  Copyright (c) 2015年 李蒙. All rights reserved.
//

#import "LMPlaceholderViewTC3.h"
#import "LMKit.h"

@interface LMPlaceholderViewTC3 ()

@end

@implementation LMPlaceholderViewTC3

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self refresh];
}

- (void)refresh
{
    [self lm_showPlaceholderInitWithBackgroundColor:[UIColor lm_colorWithRamdom] imageName:@"icon_placeholder_address" andTitle:@"无法定位" andRefresBlock:^{
        
        LMLog(@"%@", [NSDate new]);
        
        [self refresh];
    }];
}

@end
