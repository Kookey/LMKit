//
//  UIImage+LM.m
//  LMCategory
//
//  Created by 李蒙 on 15/7/9.
//  Copyright (c) 2015年 李蒙. All rights reserved.
//

#import "UIImage+LM.h"
#import "LMCategory.h"
#import <objc/runtime.h>

@interface UIImage ()

@property(copy, nonatomic) lm_WriteToSavedPhotosSuccess writeToSavedPhotosSuccess;

@property(copy, nonatomic) lm_WriteToSavedPhotosError writeToSavedPhotosError;

@end

static char writeToSavedPhotosSuccessKey, writeToSavedPhotosErrorKey;

@implementation UIImage (LM)

#pragma mark -.-

- (void)setWriteToSavedPhotosSuccess:(lm_WriteToSavedPhotosSuccess)writeToSavedPhotosSuccess {
    
    objc_setAssociatedObject(self, &writeToSavedPhotosSuccessKey, writeToSavedPhotosSuccess, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (lm_WriteToSavedPhotosSuccess)writeToSavedPhotosSuccess {
    
    return objc_getAssociatedObject(self, &writeToSavedPhotosSuccessKey);
}

- (void)setWriteToSavedPhotosError:(lm_WriteToSavedPhotosError)writeToSavedPhotosError {
    
    objc_setAssociatedObject(self, &writeToSavedPhotosErrorKey, writeToSavedPhotosError, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (lm_WriteToSavedPhotosError)writeToSavedPhotosError {
    
    return objc_getAssociatedObject(self, &writeToSavedPhotosErrorKey);
}

#pragma mark 将图片大小转为新大小

- (UIImage *)lm_imageToSize:(CGSize)newSize
{
    UIGraphicsBeginImageContext(newSize);
    
    [self drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return newImage;
}

#pragma mark 将UIColor转为UIImage

+ (UIImage *)lm_imageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return theImage;
}

#pragma mark 根据设备加载图片名

+ (UIImage *)lm_imageWithName:(NSString *)name
{
    NSString *origin = name;
    
    NSString *suffix;
    
    if (LMiPhone4) {
        suffix = @"_480h";
    } else if (LMiPhone5) {
        suffix = @"_568h";
    } else if (LMiPhone6) {
        suffix = @"_667h";
    } else if (LMiPhone6Plus) {
        suffix = @"_736h";
    } else {
        suffix = @"";
    }
    
    NSString *fileName = [name stringByDeletingPathExtension];
    NSString *extenesion = [name pathExtension];
    
    if (extenesion.length) {
        name = [[fileName stringByAppendingString:suffix] stringByAppendingPathExtension:extenesion];
    } else {
        name = [fileName stringByAppendingString:suffix];
    }
    
    return [UIImage imageNamed:name] ? [UIImage imageNamed:name] : [UIImage imageNamed:origin];
}

#pragma mark 保存到相簿

- (void)lm_writeToSavedPhotosAlbumWithSuccess:(lm_WriteToSavedPhotosSuccess)success error:(lm_WriteToSavedPhotosError)error
{
    self.writeToSavedPhotosSuccess = success;
    self.writeToSavedPhotosError = error;
    
    UIImageWriteToSavedPhotosAlbum(self, self, @selector(image:didFinishSavingWithError:contextInfo:), NULL);
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    if (error) {
        
        if (self.writeToSavedPhotosError) {
            self.writeToSavedPhotosError(error);
        }
        
    } else {
        
        if (self.writeToSavedPhotosSuccess) {
            self.writeToSavedPhotosSuccess();
        }
    }
}

+ (UIImage *)screenshot
{
    CGSize imageSize = [[UIScreen mainScreen] bounds].size;
    
    UIGraphicsBeginImageContextWithOptions(imageSize, NO, 0);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    for (UIWindow *window in [[UIApplication sharedApplication] windows]) {
        
        if (![window respondsToSelector:@selector(screen)] || [window screen] == [UIScreen mainScreen]) {
            
            CGContextSaveGState(context);
            
            CGContextTranslateCTM(context, [window center].x, [window center].y);
            
            CGContextConcatCTM(context, [window transform]);
            
            CGContextTranslateCTM(context, -[window bounds].size.width * [[window layer] anchorPoint].x, -[window bounds].size.height * [[window layer] anchorPoint].y);
            
            [[window layer] renderInContext:context];
            
            CGContextRestoreGState(context);
        }
    }
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return image;
}

@end
