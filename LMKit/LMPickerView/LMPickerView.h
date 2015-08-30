//
//  LMPickerView.h
//  LMPickerView
//
//  Created by 李蒙 on 15/8/30.
//  Copyright (c) 2015年 李蒙. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LMPickerView : UIView

@property (assign,nonatomic) id <UIPickerViewDataSource> dataSource;
@property (assign, nonatomic) id <UIPickerViewDelegate>   delegate;

@property (strong, nonatomic) NSDictionary *itemBarAttributes;

- (void)addBarItem:(UIBarButtonItem *)barItem;

- (void)showPickerViewWithCancel:(dispatch_block_t)cancelAction done:(dispatch_block_t)doneAction;

- (void)dismiss;

@end
