//
//  UITableView+LM.m
//  LMCategory
//
//  Created by 李蒙 on 15/11/3.
//  Copyright © 2015年 李蒙. All rights reserved.
//

#import "UITableView+LM.h"

@implementation UITableView (LM)

- (void)lm_reloadDataWithAnimate:(LMTableViewAnimate)animation
{
    [self setContentOffset:self.contentOffset animated:NO];
    
    [UIView animateWithDuration:.2 animations:^{
        
        [self setHidden:YES];
        [self reloadData];
        
    } completion:^(BOOL finished) {
        
        [self setHidden:NO];
        [self visibleRowsAnimation:animation];
    }];
}

- (void)visibleRowsAnimation:(LMTableViewAnimate)animation
{
    NSArray *visibleRows = [self indexPathsForVisibleRows];
    
    for (int i = 0; i < visibleRows.count; i++) {
        
        NSIndexPath *path = [visibleRows objectAtIndex:i];
        UITableViewCell *cell = [self cellForRowAtIndexPath:path];
        cell.hidden = YES;
        
        NSArray *animate = @[path, [NSNumber numberWithInt:animation]];
        
        [self performSelector:@selector(animationStart:) withObject:animate afterDelay:.1 * (i + 1)];
    }
}

- (void)animationStart:(NSArray *)animate
{
    NSIndexPath *path = [animate objectAtIndex:0];
    float i = [((NSNumber *)[animate objectAtIndex:1]) floatValue] ;
    
    UITableViewCell *cell = [self cellForRowAtIndexPath:path];
    CGPoint originPoint = cell.center;
    cell.center = CGPointMake(cell.frame.size.width * i, originPoint.y);
    
    [UIView animateWithDuration:.25 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        
        cell.center = CGPointMake(originPoint.x - i * 2, originPoint.y);
        cell.hidden = NO;
        
    } completion:^(BOOL finished) {
       
        [UIView animateWithDuration:.1 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
            
            cell.center = CGPointMake(originPoint.x + i * 2, originPoint.y);
            
        } completion:^(BOOL finished) {
            
            [UIView animateWithDuration:0.1 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
                
                cell.center = originPoint;
                
            } completion:nil];
        }];
    }];
}

@end
