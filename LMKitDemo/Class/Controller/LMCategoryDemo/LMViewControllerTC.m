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
        {
            UIViewController *vc = [[UIViewController alloc] init];
            [vc lm_addTransitionType:LMTransitionTypeFade direction:LMTransitionDirectionLeft duration:2 completion:nil];
            vc.view.backgroundColor = LMRandomColor;
            
            [self.navigationController pushViewController:vc animated:NO];
        }
            break;
        case 2:
        {
            UIViewController *vc = [[UIViewController alloc] init];
            [vc lm_addTransitionType:LMTransitionTypePush direction:LMTransitionDirectionRight duration:2 completion:nil];
            vc.view.backgroundColor = LMRandomColor;
            
            [self.navigationController pushViewController:vc animated:NO];
        }
            break;
        case 3:
        {
            UIViewController *vc = [[UIViewController alloc] init];
            [vc lm_addTransitionType:LMTransitionTypeCube direction:LMTransitionDirectionLeft duration:2 completion:nil];
            vc.view.backgroundColor = LMRandomColor;
            
            [self.navigationController pushViewController:vc animated:NO];
        }
            break;
        case 4:
        {
            UIViewController *vc = [[UIViewController alloc] init];
            [vc lm_addTransitionType:LMTransitionTypeFlip direction:LMTransitionDirectionLeft duration:2 completion:nil];
            vc.view.backgroundColor = LMRandomColor;
            
            [self.navigationController pushViewController:vc animated:NO];
        }
            break;
        case 5:
        {
            UIViewController *vc = [[UIViewController alloc] init];
            [vc lm_addTransitionType:LMTransitionTypeRipple direction:LMTransitionDirectionLeft duration:2 completion:nil];
            vc.view.backgroundColor = LMRandomColor;
            
            [self.navigationController pushViewController:vc animated:NO];
        }
            break;
        case 6:
        {
            UIViewController *vc = [[UIViewController alloc] init];
            [vc lm_addTransitionType:LMTransitionTypePageCurl direction:LMTransitionDirectionLeft duration:2 completion:nil];
            vc.view.backgroundColor = LMRandomColor;
            
            [self.navigationController pushViewController:vc animated:NO];
        }
            break;
        case 7:
        {
            UIViewController *vc = [[UIViewController alloc] init];
            [vc lm_addTransitionType:LMTransitionTypePageUnCurl direction:LMTransitionDirectionLeft duration:2 completion:nil];
            vc.view.backgroundColor = LMRandomColor;
            
            [self.navigationController pushViewController:vc animated:NO];
        }
            break;
        case 8:
        {
            UIViewController *vc = [[UIViewController alloc] init];
            [vc lm_addTransitionType:LMTransitionTypePageCameraOpen direction:LMTransitionDirectionLeft duration:2 completion:nil];
            vc.view.backgroundColor = LMRandomColor;
            
            [self.navigationController pushViewController:vc animated:NO];
        }
            break;
        case 9:
        {
            UIViewController *vc = [[UIViewController alloc] init];
            [vc lm_addTransitionType:LMTransitionTypePageCamreaClose direction:LMTransitionDirectionLeft duration:2 completion:nil];
            vc.view.backgroundColor = LMRandomColor;
            
            [self.navigationController pushViewController:vc animated:NO];
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
    }
}

@end
