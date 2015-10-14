//
//  UINavigationItem+LM.h
//  LMCategory
//
//  Created by 李蒙 on 15/8/9.
//  Copyright (c) 2015年 李蒙. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationItem (LM)

- (void)lm_blankBackBarButtonItem;

#pragma mark - ActivityIndicator

- (void)lm_startActivityIndicatorAtLeft;

- (void)lm_startActivityIndicatorAtCenter;

- (void)lm_startActivityIndicatorAtRight;

- (void)lm_stopActivityIndicator;

@end
