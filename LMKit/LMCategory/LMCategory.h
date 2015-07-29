//
//  LMCategory.h
//  LMCategory
//
//  Created by 李蒙 on 15/7/2.
//  Copyright (c) 2015年 李蒙. All rights reserved.
//

#ifndef LMCategory_LMCategory_h
#define LMCategory_LMCategory_h

#ifndef __OPTIMIZE__

#define LMLog(format, ...) NSLog(@"%s(%d): %@", __FUNCTION__, __LINE__, [NSString stringWithFormat:(format), ##__VA_ARGS__])

#else

#define LMLog(...)

#endif

#define LMScreenWidth [UIScreen mainScreen].bounds.size.width
#define LMScreenHeight [UIScreen mainScreen].bounds.size.height
#define LMScreenSize [UIScreen mainScreen].bounds.size
#define LMScreenBounds [UIScreen mainScreen].bounds

#define LMiPad (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define LMiPhone (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)

#define LMScreenMax (MAX(LMScreenWidth, LMScreenHeight))
#define LMScreenMin (MIN(LMScreenWidth, LMScreenHeight))

#define LMiPhone4 (LMiPhone && LMScreenMax == 480.0)
#define LMiPhone5 (LMiPhone && LMScreenMax == 568.0)
#define LMiPhone6 (LMiPhone && LMScreenMax == 667.0)
#define LMiPhone6Plus (LMiPhone && LMScreenMax == 736.0)

#import "NSString+LM.h"
#import "NSDate+LM.h"
#import "NSBundle+LM.h"
#import "NSObject+LM.h"
#import "NSArray+LM.h"
#import "NSDictionary+LM.h"
#import "NSURL+LM.h"

#import "UIDevice+LM.h"
#import "UIImage+LM.h"
#import "UIImageView+LM.h"
#import "UITextField+LM.h"
#import "UITextView+LM.h"
#import "UIColor+LM.h"
#import "UIStoryboard+LM.h"
#import "UIAlertView+LM.h"
#import "UIApplication+LM.h"
#import "UIView+LM.h"
#import "UIViewController+LM.h"

#endif
