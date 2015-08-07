//
//  LMTransitionVC.m
//  LMKitDemo
//
//  Created by 李蒙 on 15/8/7.
//  Copyright (c) 2015年 李蒙. All rights reserved.
//

#import "LMTransitionVC.h"

@interface LMTransitionVC ()

@end

@implementation LMTransitionVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (IBAction)cancel:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
