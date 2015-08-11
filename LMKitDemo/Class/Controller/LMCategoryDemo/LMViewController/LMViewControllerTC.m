//
//  LMViewControllerTC.m
//  LMKitDemo
//
//  Created by 李蒙 on 15/8/6.
//  Copyright (c) 2015年 李蒙. All rights reserved.
//

#import "LMViewControllerTC.h"
#import "LMKit.h"
#import "SVProgressHUD.h"
#import "LMTransitionVC.h"

@interface LMViewControllerTC ()

@end

@implementation LMViewControllerTC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self lm_tapDismissKeyboard];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (TARGET_IPHONE_SIMULATOR && indexPath.row == 10) {
        
        LMAlertShow(@"不支持模拟器");
        
        return;
    }
    
    switch (indexPath.row) {
        case 1:
        case 2:
        case 3:
        case 4:
        case 5:
        case 6:
        case 7:
        case 8:
        case 9:
        {
            [self transition:indexPath.row - 1];
        }
            break;
        case 10:
            [self lm_presentAppStoreWithITunesItemIdentifier:414478124 loading:^{
                
                LMLog(@"正在跳转到微信");
                
                [SVProgressHUD showWithStatus:@"正在跳转到微信" maskType:SVProgressHUDMaskTypeClear];
                
            } loaded:^(NSError *error) {
                
                if (error) {
                    LMAlertShow(error.localizedDescription);
                }
                
                [SVProgressHUD dismiss];
                
            } didFinish:^{
                LMLog(@"取消");
                
                [SVProgressHUD dismiss];
            }];
            break;
        case 11:
            
            break;
    }
}

- (void)transition:(LMTransitionType)type
{
    [self lm_performSegueWithIdentifier:@"TransitionVC" sender:nil storyboardSegue:^(id sender, UIStoryboardSegue *segue, UINavigationController *destinationViewController) {

        destinationViewController.topViewController.view.backgroundColor = LMRandomColor;
        
        [segue.destinationViewController lm_addTransitionType:type direction:LMTransitionDirectionLeft duration:[self lm_randomInteger:1 to:2] completion:nil];
    }];
}

@end
