//
//  UIActionSheet+LM.m
//  LMCategory
//
//  Created by 李蒙 on 15/8/16.
//  Copyright (c) 2015年 李蒙. All rights reserved.
//

#import "UIActionSheet+LM.h"
#import "LMKit.h"

@interface UIActionSheet () <UIActionSheetDelegate>

@property (copy, nonatomic) LMActionSheet actionSheeHandlet;

@end

@implementation UIActionSheet (LM)

+ (void)lm_showInView:(UIView *)view withTitle:(NSString *)title cancelButtonTitle:(NSString *)cancelButtonTitle destructiveButtonTitle:(NSString *)destructiveButtonTitle otherButtonTitles:(NSArray *)otherButtonTitles handler:(LMActionSheet)block
{
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:title delegate:nil cancelButtonTitle:cancelButtonTitle destructiveButtonTitle:destructiveButtonTitle otherButtonTitles:nil];
    actionSheet.delegate = actionSheet;
    actionSheet.actionSheeHandlet = block;
    
    for (NSString *title in otherButtonTitles) {
        
        [actionSheet addButtonWithTitle:title];
    }
    
    [actionSheet showInView:view];
}

- (LMActionSheet)actionSheeHandlet {
    
    return [self lm_getAssociatedObject:@selector(setActionSheeHandlet:)];
}

- (void)setActionSheeHandlet:(LMActionSheet)actionSheeHandlet {
    
    [self lm_setAssociated_ASSOCIATION_COPY_NONATOMIC:actionSheeHandlet selector:@selector(setActionSheeHandlet:)];
}

#pragma mark - UIActionSheetDelegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    LMBlock_Safe_Run(actionSheet.actionSheeHandlet, actionSheet,  buttonIndex);
}

@end
