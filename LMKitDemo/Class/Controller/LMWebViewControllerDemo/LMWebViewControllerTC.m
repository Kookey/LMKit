//
//  LMWebViewControllerTC.m
//  LMKitDemo
//
//  Created by 李蒙 on 15/8/11.
//  Copyright (c) 2015年 李蒙. All rights reserved.
//

#import "LMWebViewControllerTC.h"
#import "LMKit.h"

@interface LMWebViewControllerTC ()

@end

@implementation LMWebViewControllerTC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self lm_prepareForSegueWithIdentifier:@"WebDemo" storyboardSegue:^(id sender, UIStoryboardSegue *segue, LMWebViewController *destinationViewController) {
        
        [destinationViewController.lm_webView lm_loadRequestURL:@"http://www.so.com"];
    }];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 1) {
        
        LMWebViewController *webVC = [LMWebViewController webViewControllerLoadRequestsURL:@"http://www.baidu.com"];
        webVC.lm_showHtmlTitle = YES;
        
        [self.navigationController pushViewController:webVC animated:YES];
    }
}

@end
