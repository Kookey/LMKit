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
    
    [UIApplication lm_firstOpenedKey:@"UIApplicationTC" flag:^(BOOL isFirstStart) {
        
        self.isFirstOpenedLabel.text = isFirstStart ? @"首次打开UIApplicationTC" : @"不是首次打开UIApplicationTC";
    }];
}

@end
