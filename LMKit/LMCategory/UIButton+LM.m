//
//  UIButton+LM.m
//  LMCategory
//
//  Created by 李蒙 on 15/8/9.
//  Copyright (c) 2015年 李蒙. All rights reserved.
//

#import "UIButton+LM.h"
#import "LMKit.h"

@interface UIButton ()

@property (strong, nonatomic) UIActivityIndicatorView *lm_activityIndicatorView;

@property (copy, nonatomic) NSString *lm_buttonTitle;

@end

@implementation UIButton (LM)

- (void)setLm_buttonTitle:(NSString *)lm_buttonTitle {
    
    [self lm_setAssociated_ASSOCIATION_COPY_NONATOMIC:lm_buttonTitle selector:@selector(setLm_buttonTitle:)];
}

- (NSString *)lm_buttonTitle {
    
    return [self lm_getAssociatedObject:@selector(setLm_buttonTitle:)];
}

- (void)setLm_activityIndicatorView:(UIActivityIndicatorView *)lm_activityIndicatorView {
    
    [self lm_setAssociated_ASSOCIATION_RETAIN_NONATOMIC:lm_activityIndicatorView selector:@selector(setLm_activityIndicatorView:)];
}

- (UIActivityIndicatorView *)lm_activityIndicatorView {
    
    return [self lm_getAssociatedObject:@selector(setLm_activityIndicatorView:)];
}

- (void)lm_startActivityIndicator
{
    self.enabled = NO;
    
    self.lm_buttonTitle = [self titleForState:UIControlStateDisabled];
    
    [self setTitle:@"" forState:UIControlStateDisabled];
    
    self.lm_activityIndicatorView = [[UIActivityIndicatorView alloc] initWithFrame:self.bounds];
    
    self.lm_activityIndicatorView.color = self.currentTitleColor;
    
    [self addSubview:self.lm_activityIndicatorView];
    
    [self.lm_activityIndicatorView startAnimating];
}

- (void)lm_stopActivityIndicator
{
    self.enabled = YES;
    
    [self setTitle:self.lm_buttonTitle forState:UIControlStateDisabled];
    
    [self.lm_activityIndicatorView stopAnimating];
    
    [self.lm_activityIndicatorView removeFromSuperview];
    self.lm_activityIndicatorView = nil;
}

@end
