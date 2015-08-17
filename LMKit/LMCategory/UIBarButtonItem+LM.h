//
//  UIBarButtonItem+LM.h
//  LMCategory
//
//  Created by 李蒙 on 15/8/17.
//  Copyright (c) 2015年 李蒙. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^LMBarButtonActionBlock)();

@interface UIBarButtonItem (LM)

- (void)lm_setBarButtonAction:(LMBarButtonActionBlock)action;

@end
