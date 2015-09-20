//
//  LMCityTableViewController.h
//  LMKitDemo
//
//  Created by 李蒙 on 15/9/20.
//  Copyright © 2015年 李蒙. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LMCityTableViewController : UITableViewController

- (instancetype)initWithData:(NSArray *)data cityForKey:(NSString *)city indexForKey:(NSString *)index completion:(void (^) (NSString *city))completionBlock ;

@end
