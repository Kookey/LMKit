//
//  UINavigationItem+LM.m
//  LMCategory
//
//  Created by 李蒙 on 15/8/9.
//  Copyright (c) 2015年 李蒙. All rights reserved.
//

#import "UINavigationItem+LM.h"
#import "LMKit.h"

typedef NS_ENUM(NSUInteger, LMNavBar) {
    LMNavBarLeft,
    LMNavBarCenter,
    LMNavBarRight,
};

@implementation UINavigationItem (LM)

- (void)lm_blankBackBarButtonItem
{
    UIBarButtonItem *temporaryBarButtonItem = [[UIBarButtonItem alloc] init];
    temporaryBarButtonItem.title = @"";
    self.backBarButtonItem = temporaryBarButtonItem;
}

- (void)lm_startActivityIndicatorAtLeft
{
    [self startActivityIndicator:LMNavBarLeft];
}

- (void)lm_startActivityIndicatorAtCenter
{
    [self startActivityIndicator:LMNavBarCenter];
}

- (void)lm_startActivityIndicatorAtRight
{
    [self startActivityIndicator:LMNavBarRight];
}

- (void)startActivityIndicator:(LMNavBar)position
{
    [self lm_stopActivityIndicator];
    
    [self lm_setAssociated_ASSOCIATION_ASSIGN:@(position) selector:@selector(setPosition:)];
    
    UIActivityIndicatorView *activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];

    switch (position) {
        case LMNavBarLeft:
            [self lm_setAssociated_ASSOCIATION_RETAIN_NONATOMIC:self.leftBarButtonItem.customView selector:@selector(setCustomView:)];
            self.leftBarButtonItem.customView = activityIndicatorView;
            break;
        case LMNavBarCenter:
            [self lm_setAssociated_ASSOCIATION_RETAIN_NONATOMIC:self.titleView selector:@selector(setCustomView:)];
            self.titleView = activityIndicatorView;
            break;
        case LMNavBarRight:
            [self lm_setAssociated_ASSOCIATION_RETAIN_NONATOMIC:self.rightBarButtonItem.customView selector:@selector(setCustomView:)];
            self.rightBarButtonItem.customView = activityIndicatorView;
            break;
        default:
            break;
    }
    
    [activityIndicatorView startAnimating];
}

- (void)lm_stopActivityIndicator
{
    NSNumber *position = [self lm_getAssociatedObject:@selector(setPosition:)];
    
    if (position) {
        
        id view = [self lm_getAssociatedObject:@selector(setCustomView:)];
        
        switch (position.unsignedIntegerValue) {
            case LMNavBarLeft:
                self.leftBarButtonItem.customView = view;
                break;
            case LMNavBarCenter:
                self.titleView = view;
                break;
            case LMNavBarRight:
                self.rightBarButtonItem.customView = view;
                break;
            default:
                break;
        }
    }
    
    [self lm_setAssociated_ASSOCIATION_ASSIGN:nil selector:@selector(setPosition:)];
    [self lm_setAssociated_ASSOCIATION_RETAIN_NONATOMIC:nil selector:@selector(setCustomView:)];
}

@end
