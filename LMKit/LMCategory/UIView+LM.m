//
//  UIView+LM.m
//  LMCategory
//
//  Created by 李蒙 on 15/7/21.
//  Copyright (c) 2015年 李蒙. All rights reserved.
//

#import "UIView+LM.h"
#import <objc/runtime.h>

@interface UIView ()

@property (copy, nonatomic) lm_TapGestureBlock tapGestureAction;

@property (copy, nonatomic) lm_LongPressGestureBlock longPressGestureAction;

@property (copy, nonatomic) lm_PanGestureBlock panGestureAction;

@end

static char tapGestureBlockKey, longPressGestureBlockKey, panGestureBlockKey;

@implementation UIView (LM)

#pragma mark - frame

- (CGPoint)lm_origin {
    
    return self.frame.origin;
}

- (void)setLm_origin:(CGPoint)lm_origin {
    
    CGRect frame = self.frame;
    frame.origin = lm_origin;
    
    self.frame = frame;
}

- (CGSize)lm_size {
    
    return self.frame.size;
}

- (void)setLm_size:(CGSize)lm_size {
    
    CGRect frame = self.frame;
    frame.size = lm_size;
    
    self.frame = frame;
}

- (CGFloat)lm_width {
    
    return self.frame.size.width;
}

- (void)setLm_width:(CGFloat)lm_width {
    
    CGRect frame = self.frame;
    frame.size.width = lm_width;

    self.frame = frame;
}

- (CGFloat)lm_height {
    
    return self.frame.size.height;
}

- (void)setLm_height:(CGFloat)lm_height {
    
    CGRect frame = self.frame;
    frame.size.height = lm_height;
    
    self.frame = frame;
}

- (CGFloat)lm_centerX {
    
    return self.center.x;
}

- (void)setLm_centerX:(CGFloat)lm_centerX {
    
    self.center = CGPointMake(lm_centerX, self.center.y);
}

- (CGFloat)lm_centerY {
    
    return self.center.y;
}

- (void)setLm_centerY:(CGFloat)lm_centerY {
    
    self.center = CGPointMake(self.center.x, lm_centerY);
}

- (CGFloat)lm_top {
    
    return self.frame.origin.y;
}

- (void)setLm_top:(CGFloat)lm_top {
    
    CGRect frame = self.frame;
    frame.origin.y = lm_top;
    
    self.frame = frame;
}

- (CGFloat)lm_bottom {
    
    return self.frame.origin.y + self.frame.size.height;
}

- (void)setLm_bottom:(CGFloat)lm_bottom {
    
    CGRect frame = self.frame;
    frame.origin.y = lm_bottom - self.frame.size.height;
    
    self.frame = frame;
}

- (CGFloat)lm_left {
    
    return self.frame.origin.x;
}

- (void)setLm_left:(CGFloat)lm_left {
    
    CGRect frame = self.frame;
    frame.origin.x = lm_left;
    
    self.frame = frame;
}

- (CGFloat)lm_right {
    
    return self.frame.origin.x + self.frame.size.width;
}

- (void)setLm_right:(CGFloat)lm_right {
    
    CGRect frame = self.frame;
    frame.origin.x = lm_right - self.frame.size.width;
    
    self.frame = frame;
}

#pragma mark -.-

- (void)setTapAction:(lm_TapGestureBlock)tapAction {
    
    objc_setAssociatedObject(self, &tapGestureBlockKey, tapAction, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (lm_TapGestureBlock)tapGestureAction {
    
    return objc_getAssociatedObject(self, &tapGestureBlockKey);
}

- (void)setLongPressGestureAction:(lm_LongPressGestureBlock)longPressGestureAction {
    
    objc_setAssociatedObject(self, &longPressGestureBlockKey, longPressGestureAction, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (lm_LongPressGestureBlock)longPressGestureAction {
    
    return objc_getAssociatedObject(self, &longPressGestureBlockKey);
}

- (void)setPanGestureAction:(lm_PanGestureBlock)panGestureAction {
    
    objc_setAssociatedObject(self, &panGestureBlockKey, panGestureAction, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (lm_PanGestureBlock)panGestureAction {
    
    return objc_getAssociatedObject(self, &panGestureBlockKey);
}

#pragma mark TapGesture回调

- (UITapGestureRecognizer *)lm_addTapGesture:(lm_TapGestureBlock)tapAction
{
    self.tapAction = tapAction;
    
    if (![self gestureRecognizers]) {
        
        self.userInteractionEnabled = YES;
        
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(lm_tapGesture:)];
        [self addGestureRecognizer:tapGesture];
        
        return tapGesture;
    }
    
    return nil;
}

#pragma mark LongPressGesture回调

- (UILongPressGestureRecognizer *)lm_addLongPressGesture:(lm_LongPressGestureBlock)longPressAction
{
    self.longPressGestureAction = longPressAction;
    
    if (![self gestureRecognizers]) {
        
        self.userInteractionEnabled = YES;
        
        UILongPressGestureRecognizer *longPressGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(lm_longGesture:)];
        [self addGestureRecognizer:longPressGesture];
        
        return longPressGesture;
    }
    
    return nil;
}

#pragma mark PanGesture回调

- (UIPanGestureRecognizer *)lm_addPanGesture:(lm_PanGestureBlock)panAction
{
    self.panGestureAction = panAction;
    
    if (![self gestureRecognizers]) {
        
        self.userInteractionEnabled = YES;
        
        UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(lm_panGesture:)];
        [self addGestureRecognizer:panGesture];
        
        return panGesture;
    }
    
    return nil;
}

- (void)lm_tapGesture:(UITapGestureRecognizer *)gestureRecognizer
{
    if (self.tapGestureAction) {
        
        self.tapGestureAction(gestureRecognizer);
    }
}

- (void)lm_longGesture:(UILongPressGestureRecognizer *)gestureRecognizer
{
    if (self.longPressGestureAction) {
        
        self.longPressGestureAction(gestureRecognizer);
    }
}

- (void)lm_panGesture:(UIPanGestureRecognizer *)gestureRecognizer
{
    if (self.panGestureAction) {
        
        self.panGestureAction(gestureRecognizer);
    }
}

#pragma mark -.-

- (void)lm_shakeAnimation
{
    CAKeyframeAnimation *shake = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    shake.values = @[[NSValue valueWithCATransform3D:CATransform3DMakeTranslation(-5.0f, 0.0f, 0.0f)], [NSValue valueWithCATransform3D:CATransform3DMakeTranslation(5.0f, 0.0f, 0.0f)]];
    shake.autoreverses = YES;
    shake.repeatCount = 2.0f;
    shake.duration = 0.07f;
    
    [self.layer addAnimation:shake forKey:nil];
}

- (void)lm_popAnimation
{
    CAKeyframeAnimation *popAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    popAnimation.values = @[[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.01f, 0.01f, 1.0f)], [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.1f, 1.1f, 1.0f)], [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9f, 0.9f, 1.0f)], [NSValue valueWithCATransform3D:CATransform3DIdentity]];
    popAnimation.timingFunctions = @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut], [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    popAnimation.duration = 0.4;
    popAnimation.keyTimes = @[@0.2f, @0.5f, @0.75f, @1.0f];
    
    [self.layer addAnimation:popAnimation forKey:nil];
}

@end
