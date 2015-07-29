//
//  LMPlaceholderViewVC1.m
//  LMKitDemo
//
//  Created by 李蒙 on 15/7/29.
//  Copyright (c) 2015年 李蒙. All rights reserved.
//

#import "LMPlaceholderViewVC1.h"
#import "LMKit.h"

@interface LMPlaceholderViewVC1 ()

@end

@implementation LMPlaceholderViewVC1

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self lm_showPlaceholderInitWithBackgroundColor:[UIColor lm_colorWithRamdom] imageName:@"icon_placeholder_address" andTitle:@"找不到您的位置" andRefresBlock:nil];
}

@end
