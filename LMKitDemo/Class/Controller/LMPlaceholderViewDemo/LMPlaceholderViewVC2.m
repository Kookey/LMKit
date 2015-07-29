//
//  LMPlaceholderViewVC2.m
//  LMKitDemo
//
//  Created by 李蒙 on 15/7/29.
//  Copyright (c) 2015年 李蒙. All rights reserved.
//

#import "LMPlaceholderViewVC2.h"
#import "LMKit.h"

@interface LMPlaceholderViewVC2 ()

@end

@implementation LMPlaceholderViewVC2

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self requestOrder:nil];
}

- (IBAction)requestOrder:(id)sender {
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self lm_showPlaceholderInitWithImageName:@"icon_placeholder_network" andTitle:@"网络请求失败\n点击屏幕重新加载" andFrame:CGRectMake(0, 0, LMScreenWidth, LMScreenHeight - 44) andRefresBlock:^{
        
        self.view.backgroundColor = LMColorWithRamdom;
        
        [[[UIAlertView alloc] initWithTitle:@"加载成功" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil] show];
        
    }];
}

@end
