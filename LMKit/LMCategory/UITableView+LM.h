//
//  UITableView+LM.h
//  LMCategory
//
//  Created by 李蒙 on 15/11/3.
//  Copyright © 2015年 李蒙. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, LMTableViewAnimate) {
    LMTableViewAnimateLeft,
    LMTableViewAnimateRight,
};

@interface UITableView (LM)

- (void)lm_reloadDataWithAnimate:(LMTableViewAnimate)animation;

@end
