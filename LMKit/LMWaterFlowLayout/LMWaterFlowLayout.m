//
//  LMWaterFlowLayout.m
//  LMKitDemo
//
//  Created by 李蒙 on 15/8/27.
//  Copyright (c) 2015年 李蒙. All rights reserved.
//

#import "LMWaterFlowLayout.h"

@interface LMWaterFlowLayout ()

@property (strong, nonatomic) NSMutableDictionary *attributes;

@property (strong, nonatomic) NSMutableArray *columns;

@property (assign, nonatomic) UIEdgeInsets edgeInsets;

@end

@implementation LMWaterFlowLayout

- (void)prepareLayout {
    [super prepareLayout];
    
    NSUInteger itemCount = [self.collectionView numberOfItemsInSection:0];
    
    if (!itemCount) {
        
        return;
    }
    
    self.attributes = [NSMutableDictionary dictionary];
    self.columns = [NSMutableArray array];
    
    CGFloat top = 0;
    
    for (NSUInteger index = 0; index < 3; index++) {
        
        [self.columns addObject:@(top)];
    }
    
    for (NSUInteger index = 0; index < itemCount; index++) {
        
        [self layoutForItemAtIndexPath:[NSIndexPath indexPathForItem:index inSection:0]];
    }
}

- (void)layoutForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UIEdgeInsets edgeInsets = self.sectionInset;
    
    if ([self.collectionView.delegate respondsToSelector:@selector(collectionView:layout:insetForSectionAtIndex:)]) {
        
        edgeInsets = [((id<UICollectionViewDelegateFlowLayout>)self.collectionView.delegate) collectionView:self.collectionView layout:self insetForSectionAtIndex:indexPath.row];
    }
    
    CGSize itemSize = self.itemSize;
    
    if ([self.collectionView.delegate respondsToSelector:@selector(collectionView:layout:sizeForItemAtIndexPath:)]) {
        itemSize = [((id<UICollectionViewDelegateFlowLayout>)self.collectionView.delegate) collectionView:self.collectionView layout:self sizeForItemAtIndexPath:indexPath];
    }
    
    __block NSUInteger column = 0;
    __block CGFloat shortHeight = [self.columns.firstObject floatValue];
    
    [self.columns enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        
        if ([obj floatValue] < shortHeight) {

            shortHeight = [obj floatValue];
            column = idx;
        }
    }];
    
    float top = [self.columns[column] floatValue];
    CGRect frame = CGRectMake(edgeInsets.left + column * (edgeInsets.left + itemSize.width), top + edgeInsets.top, itemSize.width, itemSize.height);
    
    [self.attributes setObject:indexPath forKey:NSStringFromCGRect(frame)];
    
    [self.columns replaceObjectAtIndex:column withObject:@(top + edgeInsets.top + itemSize.height)];
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {
    
    NSMutableArray *indexPaths = [NSMutableArray array];
    
    for (NSString *rectString in self.attributes) {
        
        CGRect rectCell = CGRectFromString(rectString);
        
        if (CGRectIntersectsRect(rectCell, rect)) {
            
            [indexPaths addObject:self.attributes[rectString]];
        }
    }
    
    NSMutableArray *attributes = [NSMutableArray array];
    
    for (NSIndexPath *indexPath in indexPaths) {
        
        [attributes addObject:[self layoutAttributesForItemAtIndexPath:indexPath]];
    }
    
    return attributes;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    
    for (NSString *frame in self.attributes) {
        
        if (self.attributes[frame] == indexPath) {
            
            attributes.frame = CGRectFromString(frame);
        }
    }
    
    return attributes;
}

- (CGSize)collectionViewContentSize {
    
    __block CGSize size = self.collectionView.frame.size;
    __block CGFloat maxHeight = [self.columns.firstObject floatValue];
    
    [self.columns enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        
        if ([obj floatValue] > maxHeight) {
            
            maxHeight = [obj floatValue];
        }

    }];
    
    size.height = maxHeight + self.edgeInsets.bottom;
    
    return size;
}

@end
