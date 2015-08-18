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
 *  调整图片大小、质量
 *
 *  @param size    大小
 *  @param quality 质量
 *
 *  @return UIImage
 */

- (UIImage *)lm_imageWithResize:(CGSize)size quality:(CGInterpolationQuality)quality;

/**
 *  将UIColor转为UIImage
 *
 *  @param color UIColor
 *
 *  @return UIImage
 */
+ (UIImage *)lm_imageWithColor:(UIColor *)color;

/**
 *  将UIColor转为UIImage
 *
 *  @param color UIColor
 *  @param frame CGRect
 *
 *  @return UIImage
 */
+ (UIImage *)lm_imageWithColor:(UIColor *)color withFrame:(CGRect)frame;

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

/**
 *  截屏
 *
 *  @return UIImage
 */
+ (UIImage *)screenshot;

/**
 *  获取launchImage
 *
 *  @return UIImage
 */
+ (UIImage *)lm_launchImage;

/**
 *  创建二维码
 *
 *  @param QRCode 二维码内容
 *
 *  @return UIImage
 */
+ (UIImage *)lm_imageWithQRCode:(NSString *)QRCode;

/**
 *  创建条形码
 *
 *  @param QRCode 条形码内容
 *
 *  @return UIImage
 */
+ (UIImage *)lm_imageWithBarcodeCode:(NSString *)BarcodeCode;

@end
