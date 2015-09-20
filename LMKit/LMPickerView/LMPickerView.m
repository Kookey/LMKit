//
//  LMPickerView.m
//  LMPickerView
//
//  Created by 李蒙 on 15/8/30.
//  Copyright (c) 2015年 李蒙. All rights reserved.
//

#import "LMPickerView.h"
#import "LMKit.h"

@interface LMPickerView ()

@property (strong, nonatomic) UIToolbar *toolBar;

@property (strong, nonatomic) UIBarButtonItem *spaceBarButtonItem;

@property (strong, nonatomic) UIBarButtonItem *edgeBarButtonItem;

@property (strong, nonatomic) UIBarButtonItem *cancelBarButtonItem;

@property (strong, nonatomic) UIBarButtonItem *doneBarButtonItem;

@property (strong, nonatomic) UIControl *control;

@property (strong, nonatomic) UIView *backgroundView;

@property (assign, nonatomic) BOOL isShow;

@property (copy, nonatomic) dispatch_block_t cancelBlock;

@property (copy, nonatomic) dispatch_block_t doneBlock;

@end

@implementation LMPickerView

- (UIPickerView *)pickerView {
    
    if (!_lm_pickerView) {
        
        _lm_pickerView = [[UIPickerView alloc] init];
        _lm_pickerView.delegate = self.lm_delegate;
        _lm_pickerView.dataSource = self.lm_dataSource;
        _lm_pickerView.backgroundColor = LMColorWithWhite;
        
        _lm_pickerView.frame = CGRectMake(0, LMScreenHeight - 216, LMScreenWidth, 216);
    }
    
    return _lm_pickerView;
}

- (UIToolbar *)toolBar {
    
    if (!_toolBar) {
        
        _toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, LMScreenHeight - 44 - 216, LMScreenWidth, 44)];
        
        _toolBar.items = @[self.edgeBarButtonItem, self.cancelBarButtonItem, self.spaceBarButtonItem, self.doneBarButtonItem, self.edgeBarButtonItem];
    }
    
    return _toolBar;
}

- (UIBarButtonItem *)spaceBarButtonItem {
    
    if (!_spaceBarButtonItem) {
        
        _spaceBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    }
    
    return _spaceBarButtonItem;
}

- (UIBarButtonItem *)edgeBarButtonItem {
    
    if (!_edgeBarButtonItem) {
        
        _edgeBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:[[UIView alloc] initWithFrame:CGRectMake(0, 0, 1, 0)]];
    }
    
    return _edgeBarButtonItem;
}

- (UIBarButtonItem *)cancelBarButtonItem {
    
    if (!_cancelBarButtonItem) {
        
        _cancelBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelAction)];
    }
    
    return _cancelBarButtonItem;
}

- (UIBarButtonItem *)doneBarButtonItem {
    
    if (!_doneBarButtonItem) {
        
        _doneBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneAction)];
    }
    
    return _doneBarButtonItem;
}

- (void)lm_addBarItem:(UIBarButtonItem *)barItem
{
    if (self.lm_itemBarAttributes) {
        
        [barItem setTitleTextAttributes:self.lm_itemBarAttributes forState:UIControlStateNormal];
    }
    
    self.toolBar.items = @[self.edgeBarButtonItem, self.cancelBarButtonItem, self.spaceBarButtonItem, barItem, self.spaceBarButtonItem, self.doneBarButtonItem, self.edgeBarButtonItem];
}

- (void)lm_showPickerViewWithCancel:(dispatch_block_t)cancelAction done:(dispatch_block_t)doneAction
{
    if (self.lm_itemBarAttributes) {
        
        [self.cancelBarButtonItem setTitleTextAttributes:self.lm_itemBarAttributes forState:UIControlStateNormal];
        [self.doneBarButtonItem setTitleTextAttributes:self.lm_itemBarAttributes forState:UIControlStateNormal];
    }
    
    self.cancelBlock = cancelAction;
    self.doneBlock = doneAction;
    
    if (_isShow) {
        
        [self cancelAction];
        
        return;
    }
    
    _isShow = YES;
    
    _control = [[UIControl alloc] initWithFrame:LMScreenBounds];
    _backgroundView = [[UIView alloc] initWithFrame:LMScreenBounds];
    
    _control.lm_top = LMScreenHeight;
    
    [UIView animateWithDuration:.25 animations:^{
        
        _control.lm_top = 0;
        
    }];
    
    [UIView animateWithDuration:.25 animations:^{
        
        _backgroundView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
    }];
    
    [_control addSubview:self.toolBar];
    [_control addSubview:self.pickerView];
    [[UIApplication sharedApplication].keyWindow addSubview:_backgroundView];
    [[UIApplication sharedApplication].keyWindow addSubview:_control];
    
    [_control lm_addTapGesture:^(UITapGestureRecognizer *gestureRecognizer) {
        
        [self cancelAction];
    }];
}

- (void)lm_dismiss
{
    if (!_isShow) {
        
        return;
    }
    
    _isShow = NO;
    
    [UIView animateWithDuration:.25 animations:^{
        
        _control.lm_top = LMScreenHeight;
        _backgroundView.backgroundColor = LMColorWithClear;
        
    } completion:^(BOOL finished) {
        
        if (finished) {
            
            [_lm_pickerView removeFromSuperview];
            [_control removeFromSuperview];
            [_backgroundView removeFromSuperview];
        }
    }];
}

- (void)cancelAction
{
    LMBlock_Safe_Run(self.cancelBlock);
    
    [self lm_dismiss];
}

- (void)doneAction
{
    LMBlock_Safe_Run(self.doneBlock);
    
    [self lm_dismiss];
}

@end
