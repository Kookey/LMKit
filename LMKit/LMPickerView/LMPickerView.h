//
//  LMPickerView.h
//  LMPickerView
//
//  Created by 李蒙 on 15/8/30.
//  Copyright (c) 2015年 李蒙. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LMPickerView : UIView

@property (assign,nonatomic) id <UIPickerViewDataSource> lm_dataSource;
@property (assign, nonatomic) id <UIPickerViewDelegate> lm_delegate;

@property (strong, nonatomic) NSDictionary *lm_itemBarAttributes;

- (void)lm_addBarItem:(UIBarButtonItem *)barItem;

- (void)lm_showPickerViewWithCancel:(dispatch_block_t)cancelAction done:(dispatch_block_t)doneAction;

- (void)lm_dismiss;

@end
