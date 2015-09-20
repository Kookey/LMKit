//
//  LMCityTC.m
//  LMKitDemo
//
//  Created by 李蒙 on 15/9/20.
//  Copyright © 2015年 李蒙. All rights reserved.
//

#import "LMCityTC.h"
#import "LMKit.h"

@interface LMCityTC ()

@end

@implementation LMCityTC

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    LMCityTableViewController *city = [[LMCityTableViewController alloc] initWithData:[[NSArray alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"City.plist" ofType:nil]] cityForKey:@"cities" indexForKey:@"state" completion:^(NSString *city) {
        
        LMLog(@"%@", city);
        
        if (indexPath.row == 0) {
            
            [LMCurrentViewController().navigationController popViewControllerAnimated:YES];
            
        } else {
            
            [LMCurrentViewController() dismissViewControllerAnimated:YES completion:nil];
        }
        
    }];
    
    city.title = @"选择城市";
    
    if (indexPath.row == 0) {
        
        [self.navigationController pushViewController:city animated:YES];
        
    } else {
        
        [city.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(dismiss)]];
        
        [self presentViewController:[[UINavigationController alloc] initWithRootViewController:city] animated:YES completion:nil];
    }
}

- (void)dismiss {
    
    [LMCurrentViewController() dismissViewControllerAnimated:YES completion:nil];
}

@end
