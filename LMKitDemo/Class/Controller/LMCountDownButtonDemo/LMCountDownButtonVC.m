//
//  LMCountDownButtonVC.m
//  LMKitDemo
//
//  Created by 李蒙 on 15/7/29.
//  Copyright (c) 2015年 李蒙. All rights reserved.
//

#import "LMCountDownButtonVC.h"
#import "LMKit.h"

@interface LMCountDownButtonVC ()

@property (weak, nonatomic) IBOutlet LMCountDownButton *button1;

@property (weak, nonatomic) LMCountDownButton *button2;

@end

@implementation LMCountDownButtonVC

- (LMCountDownButton *)button2 {
    
    if (!_button2) {
        
        _button2 = [LMCountDownButton buttonWithType:UIButtonTypeSystem];
        _button2.frame = CGRectMake(0, 200, 200, 30);
        _button2.center = CGPointMake(self.view.center.x, _button2.center.y);
        [_button2 setTitle:@"获取验证码" forState:UIControlStateNormal];
        [_button2 addTarget:self action:@selector(button2Action:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _button2;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:[self button2]];
}

- (void)dealloc {
    
    [self.button1 lm_stopTimer];
    [self.button2 lm_stopTimer];
}

- (IBAction)button1Action:(id)sender {
    
    [sender lm_startWithTotalSecond:10 didChange:^NSString *(LMCountDownButton *button, NSInteger second) {
        
        return [NSString stringWithFormat:@"还剩%zd秒可重新获取", second];
        
    } didFinished:^NSString *(LMCountDownButton *button, NSInteger second) {
        
        return @"点我重新获取";
    }];
}

- (void)button2Action:(LMCountDownButton *)sender {
    
    [sender lm_startWithTotalSecond:20 didChange:^NSString *(LMCountDownButton *button, NSInteger second) {
        
        return [NSString stringWithFormat:@"还剩%zd秒可重新获取", second];
        
    } didFinished:^NSString *(LMCountDownButton *button, NSInteger second) {
        
        return @"点我重新获取";
    }];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
