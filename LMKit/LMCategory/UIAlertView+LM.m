//
//  UIAlertView+LM.m
//  LMCategory
//
//  Created by 李蒙 on 15/7/15.
//  Copyright (c) 2015年 李蒙. All rights reserved.
//

#import "UIAlertView+LM.h"
#import "LMKit.h"

@interface UIAlertView () <UIAlertViewDelegate>

@property (copy, nonatomic) LMAlertHandler alertHandle;

@end

@implementation UIAlertView (LM)

+ (void)lm_showAlertViewWithTitle:(NSString *)title cancelButtonTitle:(NSString *)cancelButtonTitle
{
    [[[UIAlertView alloc] initWithTitle:title message:nil delegate:nil cancelButtonTitle:cancelButtonTitle otherButtonTitles:nil] show];
}

+ (void)lm_showAlertViewWithTitle:(NSString *)title
{
    [[[UIAlertView alloc] initWithTitle:title message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil] show];
}

+ (void)lm_showAlertViewWithTitle:(NSString *)title message:(NSString *)message cancelButtonName:(NSString *)cancelButtonName otherButtonTitles:(NSArray *)otherButtonTitles handler:(LMAlertHandler)block
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:message delegate:nil cancelButtonTitle:cancelButtonName otherButtonTitles:nil];
    alert.delegate = alert;
    alert.alertHandle = block;
    
    for (NSString *title in otherButtonTitles) {
        
        [alert addButtonWithTitle:title];
    }
    
    [alert show];
}

- (LMAlertHandler)alertHandle {
    
    return [self lm_getAssociatedObject:@selector(setAlertHandle:)];
}

- (void)setAlertHandle:(LMAlertHandler)alertHandle {
    
    [self lm_setAssociated_ASSOCIATION_COPY_NONATOMIC:alertHandle selector:@selector(setAlertHandle:)];
}

#pragma mark - UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (alertView.alertHandle) {
        
        alertView.alertHandle(alertView, buttonIndex);
    }
}

@end
