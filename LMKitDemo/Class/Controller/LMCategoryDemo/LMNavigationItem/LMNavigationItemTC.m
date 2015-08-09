//
//  LMNavigationItemTC.m
//  LMKitDemo
//
//  Created by 李蒙 on 15/8/9.
//  Copyright (c) 2015年 李蒙. All rights reserved.
//

#import "LMNavigationItemTC.h"
#import "LMKit.h"

@interface LMNavigationItemTC ()

@end

@implementation LMNavigationItemTC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSMutableArray *colors = [NSMutableArray arrayWithObject:self.view.tintColor];
    
    for (NSUInteger index = 0; index < 5; index++) {
        
        [colors addObject:[UIColor lm_colorWithRamdom]];
    }
    
    CGFloat size = CGRectGetWidth(self.view.frame) / colors.count;
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, size + 15)];
    
    [colors enumerateObjectsUsingBlock:^(UIColor *color, NSUInteger index, BOOL *stop) {
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.backgroundColor = color;
        [button addTarget:self action:@selector(changeColor:) forControlEvents:UIControlEventTouchUpInside];
        
        button.frame = CGRectOffset(CGRectMake(0, 0, size, size), size * index, 0);
        
        [view addSubview:button];
    }];
    
    self.tableView.tableHeaderView = view;
    
    [self.navigationItem lm_startActivityIndicatorAtCenter];
    
    [self lm_performBlock:^{
        
        [self.navigationItem lm_stopActivityIndicator];
        
    } afterDelay:3];
}

- (void)changeColor:(UIButton *)button
{
    [UIActivityIndicatorView appearanceWhenContainedIn:[UINavigationBar class], nil].color = button.backgroundColor;
    
    [self.navigationItem lm_startActivityIndicatorAtCenter];
}

- (IBAction)startLeft:(id)sender {
    
    [self.navigationItem lm_startActivityIndicatorAtLeft];
}

- (IBAction)startRight:(id)sender {
    
    [self.navigationItem lm_startActivityIndicatorAtRight];
}

- (IBAction)stop:(id)sender {
    
    [self.navigationItem lm_stopActivityIndicator];
}

- (IBAction)back:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}
@end
