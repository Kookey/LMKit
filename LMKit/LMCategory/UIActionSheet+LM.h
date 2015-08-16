//
//  UIActionSheet+LM.h
//  LMCategory
//
//  Created by 李蒙 on 15/8/16.
//  Copyright (c) 2015年 李蒙. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^LMActionSheet)(UIActionSheet *actionSheet, NSUInteger buttonIndex);

@interface UIActionSheet (LM)

+ (void)lm_showInView:(UIView *)view withTitle:(NSString *)title cancelButtonTitle:(NSString *)cancelButtonTitle destructiveButtonTitle:(NSString *)destructiveButtonTitle otherButtonTitles:(NSArray *)otherButtonTitles handler:(LMActionSheet)block;

@end
