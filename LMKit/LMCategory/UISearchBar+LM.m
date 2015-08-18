//
//  UISearchBar+LM.m
//  LMCategory
//
//  Created by 李蒙 on 15/8/18.
//  Copyright (c) 2015年 李蒙. All rights reserved.
//

#import "UISearchBar+LM.h"
#import "LMKit.h"

@implementation UISearchBar (LM)

- (void)lm_backgroundColor:(UIColor *)backgroundColor
{
    static NSInteger backgroundTag = 99999;
    
    UIView *view = [[self subviews] firstObject];
    
    [[view subviews] enumerateObjectsUsingBlock:^(UIView *obj, NSUInteger idx, BOOL *stop) {
        
        if (obj.tag == backgroundTag) {
            
            [obj removeFromSuperview];
        }
    }];
    
    if (backgroundColor) {
        
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage lm_imageWithColor:backgroundColor withFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame) + 20)]];
        
        [imageView setLm_top:-20];
        imageView.tag = backgroundTag;
        
        [[[self subviews] firstObject] insertSubview:imageView atIndex:1];
    }
}

@end
