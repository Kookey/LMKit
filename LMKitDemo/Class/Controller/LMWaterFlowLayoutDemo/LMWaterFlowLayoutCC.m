//
//  LMWaterFlowLayoutCC.m
//  LMKitDemo
//
//  Created by 李蒙 on 15/8/27.
//  Copyright (c) 2015年 李蒙. All rights reserved.
//

#import "LMWaterFlowLayoutCC.h"
#import "LMKit.h"

#define kInsets 5

@interface LMWaterFlowLayoutCC () <UICollectionViewDelegateFlowLayout>

@property (strong, nonatomic) NSMutableArray *dataSource;

@property (assign, nonatomic) NSUInteger column;

@end

@implementation LMWaterFlowLayoutCC

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    [self refresh:nil];
}

- (IBAction)refresh:(id)sender {
    
    self.column = self.column == 3 ? 2 : 3;
    
    [self loadData];
}

- (void)loadData
{
    self.dataSource = [NSMutableArray array];
    
    for (NSUInteger index = 0; index < 100; index ++) {
        
        [self.dataSource addObject:@{@"size": [NSValue valueWithCGSize:CGSizeMake((LMScreenWidth - (self.column + 1) * kInsets) / self.column, LMRandomInteger(100, 300))], @"color": LMRandomColor}];
        
        [self.collectionView reloadData];
        [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0] atScrollPosition:UICollectionViewScrollPositionTop animated:YES];
    }
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.dataSource.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    cell.backgroundColor = self.dataSource[indexPath.row][@"color"];
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    return [self.dataSource[indexPath.row][@"size"] CGSizeValue];
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    
    return UIEdgeInsetsMake(kInsets, kInsets, kInsets, kInsets);
}

@end
