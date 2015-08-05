//
//  LMApplicationTC.m
//  LMKitDemo
//
//  Created by 李蒙 on 15/7/29.
//  Copyright (c) 2015年 李蒙. All rights reserved.
//

#import "LMApplicationTC.h"
#import "LMKit.h"

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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    switch (indexPath.row) {
        case 1:
            [self lm_presentAppStoreWithITunesItemIdentifier:414478124 loading:^{
                
                LMLog(@"正在跳转到微信");
                
            } loaded:^(NSError *error) {
                
                if (error) {
                    LMAlertShow(error.localizedDescription);
                }
                
            } didFinish:^{
                LMLog(@"取消");
            }];
            break;
        case 2:
            LMOpenAppStoreDetails(414478124);
            break;
        case 3:
            LMOpenAppStoreReviews(414478124);
            break;
        case 4:
            LMOpenAppForURLSchemes(@"weixin://");
            break;
        default:
            break;
    }
}

@end
