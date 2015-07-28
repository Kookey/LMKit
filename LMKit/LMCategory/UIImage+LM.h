//
//  UIImage+LM.h
//  LMCategory
//
//  Created by 李蒙 on 15/7/9.
//  Copyright (c) 2015年 李蒙. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^lm_WriteToSavedPhotosSuccess)();
typedef void(^lm_WriteToSavedPhotosError)(NSError *error);

@interface UIImage (LM)

/**
 *  将图片大小转为新大小
 *
 *  @param newSize 新大小
 *
 *  @return UIImage
 */
- (UIImage *)lm_imageToSize:(CGSize)newSize;

/**
 *  将UIColor转为UIImage
 *
 *  @param color UIColor
 *
 *  @return UIImage
 */
+ (UIImage *)lm_imageWithColor:(UIColor *)color;

/**
 *  根据设备加载图片名
 *
 *  @param name 图片名
 *
 *  @return UIImage
 */
+ (UIImage *)lm_imageWithName:(NSString *)name;

/**
 *  保存到相簿
 *
 *  @param success 成功回调
 *  @param error   失败回调
 */
- (void)lm_writeToSavedPhotosAlbumWithSuccess:(lm_WriteToSavedPhotosSuccess)success error:(lm_WriteToSavedPhotosError)error;

+ (UIImage *)screenshot;

@end
