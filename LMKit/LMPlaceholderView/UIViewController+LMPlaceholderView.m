//
//  UIViewController+LMPlaceholderView.m
//  LMPlaceholderView
//
//  Created by 李蒙 on 15/6/29.
//  Copyright (c) 2015年 李蒙. All rights reserved.
//

#import "UIViewController+LMPlaceholderView.h"
#import "LMKit.h"
#import <objc/runtime.h>

@interface UIViewController ()

@property (copy, nonatomic) dispatch_block_t refreshBlock;

@end

static char const LMPlaceholderViewKey, LMRefreshKey;

@implementation UIViewController (LMPlaceholderView)

- (void)setLm_placeholderView:(LMPlaceholderView *)lm_placeholderView {
    
    objc_setAssociatedObject(self, &LMPlaceholderViewKey, lm_placeholderView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (LMPlaceholderView *)lm_placeholderView {
    
    return objc_getAssociatedObject(self, &LMPlaceholderViewKey);
}

- (void)setRefreshBlock:(dispatch_block_t)refreshBlock {
    
    objc_setAssociatedObject(self, &LMRefreshKey, refreshBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (dispatch_block_t)refreshBlock {
    
    return objc_getAssociatedObject(self, &LMRefreshKey);
}

- (void)lm_showPlaceholderInitWithBackgroundColor:(UIColor *)color imageName:(NSString *)imageName andTitle:(NSString *)title andFrame:(CGRect)frame andRefresBlock:(dispatch_block_t)block
{
    [self lm_showPlaceholderInitWithImageName:imageName andTitle:title andFrame:frame andRefresBlock:block];
    
    self.lm_placeholderView.backgroundColor = color;
}

- (void)lm_showPlaceholderInitWithBackgroundColor:(UIColor *)color imageName:(NSString *)imageName andTitle:(NSString *)title andRefresBlock:(dispatch_block_t)block
{
    [self lm_showPlaceholderInitWithImageName:imageName andTitle:title andRefresBlock:block];
    
    self.lm_placeholderView.backgroundColor = color;
}

- (void)lm_showPlaceholderInitWithImageName:(NSString *)imageName andTitle:(NSString *)title andRefresBlock:(dispatch_block_t)block
{
    [self lm_showPlaceholderInitWithImageName:imageName andTitle:title andFrame:CGRectMake(0, 0, LMScreenWidth, LMScreenHeight) andRefresBlock:block];
}

- (void)lm_showPlaceholderInitWithImageName:(NSString *)imageName andTitle:(NSString *)title andFrame:(CGRect)frame andRefresBlock:(dispatch_block_t)block
{
    self.refreshBlock = block;
    
    if (!self.lm_placeholderView) {
        
        self.lm_placeholderView = [[LMPlaceholderView alloc] initWithFrame:frame];
        
        if ([self respondsToSelector:@selector(setTableView:)]) {
            
            if ([((UITableViewController *)self).tableView respondsToSelector:@selector(setScrollEnabled:)]) {
                
                self.lm_placeholderView.lm_top = self.lm_placeholderView.lm_top - 30;
            }
        }
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(refreshAction)];
        [self.lm_placeholderView addGestureRecognizer:tap];
        
        [self.view addSubview:self.lm_placeholderView];
    }
    
    [self setScrollEnabled:NO];
    
    [self.lm_placeholderView lm_showViewWithImageName:imageName andTitle:title];
}

- (void)refreshAction
{
    if (self.refreshBlock) {
        
        [self lm_hidePlaceholder];
        
        self.refreshBlock();
    }
}

- (void)lm_hidePlaceholder
{
    [self.lm_placeholderView lm_hide];
    
    [self setScrollEnabled:YES];
}

- (void)setScrollEnabled:(BOOL)enabled
{
    if ([self respondsToSelector:@selector(setTableView:)]) {
        if ([((UITableViewController *)self).tableView respondsToSelector:@selector(setScrollEnabled:)]) {
            
            [((UITableViewController *)self).tableView setScrollEnabled:enabled];
        }
    }
    
    if ([self respondsToSelector:@selector(setCollectionView:)]) {
        if ([((UICollectionViewController *)self).collectionView respondsToSelector:@selector(setScrollEnabled:)]) {
            
            [((UICollectionViewController *)self).collectionView setScrollEnabled:enabled];
        }
    }
}

@end
