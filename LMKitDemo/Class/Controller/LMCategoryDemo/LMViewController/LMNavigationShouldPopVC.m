//
//  LMNavigationShouldPopVC.m
//  LMKitDemo
//
//  Created by 李蒙 on 15/8/7.
//  Copyright (c) 2015年 李蒙. All rights reserved.
//

#import "LMNavigationShouldPopVC.h"
#import "LMKit.h"

@interface LMNavigationShouldPopVC () <UIAlertViewDelegate>

@end

@implementation LMNavigationShouldPopVC

- (BOOL)lm_navigationShouldPopOnBackButton
{
    [[[UIAlertView alloc] initWithTitle:@"要返回吗？" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil] show];
    
    return NO;
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (buttonIndex == 1) {
        
        [self.navigationController popViewControllerAnimated:YES];
    }
}

@end
