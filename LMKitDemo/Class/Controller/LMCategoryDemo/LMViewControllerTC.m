//
//  LMViewControllerTC.m
//  LMKitDemo
//
//  Created by 李蒙 on 15/8/6.
//  Copyright (c) 2015年 李蒙. All rights reserved.
//

#import "LMViewControllerTC.h"
#import "LMKit.h"

@interface LMViewControllerTC ()

@end

@implementation LMViewControllerTC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (TARGET_IPHONE_SIMULATOR && indexPath.row == 0) {
        
        LMAlertShow(@"不支持模拟器");
        
        return;
    }
    
    switch (indexPath.row) {
        case 0:
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
    }
}

@end
