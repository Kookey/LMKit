
//
//  UIBarButtonItem+LM.m
//  LMCategory
//
//  Created by 李蒙 on 15/8/17.
//  Copyright (c) 2015年 李蒙. All rights reserved.
//

#import "UIBarButtonItem+LM.h"
#import "LMKit.h"

@implementation UIBarButtonItem (LM)

- (void)performActionBlock {
    
    LMBlock_Safe_Run(self.lm_barButtonAction, nil);
}

- (LMBarButtonActionBlock)lm_barButtonAction {
    
    return [self lm_getAssociatedObject:@selector(lm_setBarButtonAction:)];
}

- (void)lm_setBarButtonAction:(LMBarButtonActionBlock)action
{
    [self lm_setAssociated_ASSOCIATION_COPY_NONATOMIC:action selector:@selector(lm_setBarButtonAction:)];
    
    [self setTarget:self];
    [self setAction:@selector(performActionBlock)];
}

@end
