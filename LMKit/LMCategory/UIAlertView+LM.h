//
//  UIAlertView+LM.h
//  LMCategory
//
//  Created by 李蒙 on 15/7/15.
//  Copyright (c) 2015年 李蒙. All rights reserved.
//

#import <UIKit/UIKit.h>

#define LMAlertShowFormat(_format_, ...) [UIAlertView lm_showAlertViewWithTitle:[NSString stringWithFormat:(_format_), ##__VA_ARGS__]]
#define LMAlertShowCancelFormat(cancelTitle, _format_, ...) [UIAlertView lm_showAlertViewWithTitle:[NSString stringWithFormat:(_format_), ##__VA_ARGS__] cancelButtonTitle:cancelTitle]

#define LMAlertShow(title) [UIAlertView lm_showAlertViewWithTitle:title]
#define LMAlertShowCancel(cancelTitle,title) [UIAlertView lm_showAlertViewWithTitle:title cancelButtonTitle:cancelTitle]

typedef void(^LMAlertHandler)(UIAlertView *alertView, NSInteger buttonIndex);

@interface UIAlertView (LM)

+ (void)lm_showAlertViewWithTitle:(NSString *)title cancelButtonTitle:(NSString *)cancelButtonTitle;

+ (void)lm_showAlertViewWithTitle:(NSString *)title;

+ (void)lm_showAlertViewWithTitle:(NSString *)title message:(NSString *)message cancelButtonName:(NSString *)cancelButtonName otherButtonTitles:(NSArray *)otherButtonTitles handler:(LMAlertHandler)block;

@end
