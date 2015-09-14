//
//  UIImageView+LM.h
//  LMCategory
//
//  Created by 李蒙 on 15/7/3.
//  Copyright (c) 2015年 李蒙. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (LM)

/**
 *  圆角
 */
- (void)lm_circle;

/**
 *  圆角
 *
 *  @param radius 半径
 */
- (void)lm_circleWithRadius:(CGFloat)radius;

/**
 *  非圆角
 */
- (void)lm_circleNot;

@end
