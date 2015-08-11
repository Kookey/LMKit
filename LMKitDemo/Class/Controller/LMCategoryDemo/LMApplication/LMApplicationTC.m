//
//  LMApplicationTC.m
//  LMKitDemo
//
//  Created by 李蒙 on 15/7/29.
//  Copyright (c) 2015年 李蒙. All rights reserved.
//

#import "LMApplicationTC.h"
#import "LMKit.h"
#import "SVProgressHUD.h"

@import CoreLocation;

@interface LMApplicationTC ()

@property (weak, nonatomic) IBOutlet UILabel *isFirstOpenedLabel;

@end

@implementation LMApplicationTC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[UIApplication sharedApplication] lm_firstOpenedKey:@"UIApplicationTC" flag:^(BOOL isFirstStart) {
        
        self.isFirstOpenedLabel.text = isFirstStart ? @"首次打开UIApplicationTC" : @"不是首次打开UIApplicationTC";
    }];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [super tableView:tableView cellForRowAtIndexPath:indexPath];
    
    if (indexPath.row == 0) {
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    } else{
        cell.selectionStyle = UITableViewCellSelectionStyleDefault;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (TARGET_IPHONE_SIMULATOR && indexPath.row < 5 && indexPath.row > 0) {
    
        LMAlertShow(@"不支持模拟器");
        
        return;
    }
    
    switch (indexPath.row) {
        case 1:
            if (!LMCallTelephone(@"010-65919155,1379")) {
                
                LMAlertShow(@"拨打失败");
            }
            break;
        case 2:
            if (!LMOpenAppStoreDetails(414478124)) {
                
                LMAlertShow(@"跳转失败");
            }
            break;
        case 3:
            if (!LMOpenAppStoreReviews(414478124)) {
                
                LMAlertShow(@"跳转失败");
            }
            break;
        case 4:
            if (!LMOpenAppForURLSchemes(@"weixin://")) {
                
                LMAlertShow(@"跳转失败");
            }
            break;
        case 5:
            [[UIApplication sharedApplication] lm_requestAccessGrantedToCalendarWithSuccess:^{
                LMAlertShow(@"授权成功");
            } andFailure:^{
                LMAlertShow(@"授权失败");
            }];
            break;
        case 6:
            [[UIApplication sharedApplication] lm_requestAccessGrantedToContactsWithSuccess:^{
                LMAlertShow(@"授权成功");
            } andFailure:^{
                LMAlertShow(@"授权失败");
            }];
            break;
        case 7:
            [[UIApplication sharedApplication] lm_requestAccessGrantedToMicrophoneWithSuccess:^{
                LMAlertShow(@"授权成功");
            } andFailure:^{
                LMAlertShow(@"授权失败");
            }];
            break;
        case 8:
            [[UIApplication sharedApplication] lm_requestAccessGrantedToPhotosWithSuccess:^{
                LMAlertShow(@"授权成功");
            } andFailure:^{
                LMAlertShow(@"授权失败");
            }];
            break;
        case 9:
            [[UIApplication sharedApplication] lm_requestAccessGrantedToRemindersWithSuccess:^{
                LMAlertShow(@"授权成功");
            } andFailure:^{
                LMAlertShow(@"授权失败");
            }];
            break;
        case 10:
            [[UIApplication sharedApplication] lm_requestAccessGrantedToMotionWithSuccess:^{
                LMAlertShow(@"授权成功");
            }];
            break;
        case 11:
            [[UIApplication sharedApplication] lm_requestAccessGrantedToLocationWithSuccess:^{
                LMAlertShow(@"授权成功");
            } andFailure:^{
                LMAlertShow(@"授权失败");
            }];
            break;
        case 12:
            if (TARGET_IPHONE_SIMULATOR) {
                
                LMAlertShow(@"不支持模拟器");
                
                return;
            }
            
            [[UIApplication sharedApplication] lm_requestAccessGrantedToLocationWithSuccess:^{
                
                [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeClear];
                
                [[UIApplication sharedApplication] lm_locationDidUpdate:^(NSArray *locations, NSError *error) {
                    
                    if (error) {
                        
                        LMAlertShowFormat(@"%@", error);
                        
                        [SVProgressHUD dismiss];
                        
                        return ;
                    }
                    
                    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
                    
                    [geocoder reverseGeocodeLocation:locations.lastObject completionHandler:^(NSArray *placemarks, NSError *error) {
                        
                        [SVProgressHUD dismiss];
                        
                        if (placemarks) {
                            LMAlertShowFormat(@"%@", placemarks.lastObject);
                        } else {
                            LMAlertShowFormat(@"%@", error);
                        }
                    }];
                }];
                
            } andFailure:^{
                
                LMAlertShow(@"授权失败");
                
                [SVProgressHUD dismiss];
            }];

            break;
        default:
            break;
    }
}

@end
