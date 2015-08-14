//
//  UIView+LM.h
//  LMCategory
//
//  Created by 李蒙 on 15/7/21.
//  Copyright (c) 2015年 李蒙. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^lm_TapGestureBlock)(UITapGestureRecognizer *gestureRecognizer);
typedef void(^lm_LongPressGestureBlock)(UILongPressGestureRecognizer *gestureRecognizer);
typedef void(^lm_PanGestureBlock)(UIPanGestureRecognizer *gestureRecognizer);

@interface UIView (LM)

#pragma mark - frame

@property (nonatomic, assign) CGPoint lm_origin;
@property (nonatomic, assign) CGSize lm_size;

@property (nonatomic) CGFloat lm_width;
@property (nonatomic) CGFloat lm_height;

@property (nonatomic) CGFloat lm_centerX;
@property (nonatomic) CGFloat lm_centerY;

@property (nonatomic) CGFloat lm_top;
@property (nonatomic) CGFloat lm_bottom;
@property (nonatomic) CGFloat lm_left;
@property (nonatomic) CGFloat lm_right;

#pragma mark - TapGesture

/**
 *  TapGesture回调
 *
 *  @param panAction lm_TapGestureBlock
 *
 *  @return UITapGestureRecognizer
 */
- (UITapGestureRecognizer *)lm_addTapGesture:(lm_TapGestureBlock)tapAction;

/**
 *  LongPressGesture回调
 *
 *  @param panAction lm_LongPressGestureBlock
 *
 *  @return UILongPressGestureRecognizer
 */
- (UILongPressGestureRecognizer *)lm_addLongPressGesture:(lm_LongPressGestureBlock)longPressAction;

/**
 *  PanGesture回调
 *
 *  @param panAction lm_GestureBlock
 *
 *  @return UIPanGestureRecognizer
 */
- (UIPanGestureRecognizer *)lm_addPanGesture:(lm_PanGestureBlock)panAction;

#pragma mark - animation

/**
 *  shakeView
 */
- (void)lm_shakeAnimation;

/**
 *  popAnimation
 */
- (void)lm_popAnimation;

@end
