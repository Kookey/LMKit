//
//  LMCityTableViewController.m
//  LMKitDemo
//
//  Created by 李蒙 on 15/9/20.
//  Copyright © 2015年 李蒙. All rights reserved.
//

#import "LMCityTableViewController.h"
#import "LMKit.h"

@interface LMCityTableViewController ()

@property (strong, nonatomic) NSArray *data;

@property (strong, nonatomic) NSArray *cities;

@property (strong, nonatomic) NSArray *indexTitles;

@property (copy, nonatomic) NSString *cityKey;

@property (copy, nonatomic) NSString *indexKey;

@property (copy, nonatomic) void (^completionBlock)(NSString *);

@end

@implementation LMCityTableViewController

- (instancetype)initWithData:(NSArray *)data cityForKey:(NSString *)city indexForKey:(NSString *)index completion:(void (^)(NSString *))completionBlock {
    
    if (self == [super initWithStyle:UITableViewStylePlain]) {
        
        self.data = data;
        self.cityKey = city;
        self.indexKey = index;
        
        self.completionBlock = completionBlock;
        
        NSMutableArray *indexTitles = [NSMutableArray array];
        
        for (NSDictionary *city in self.data) {
            
            [indexTitles addObject:city[self.indexKey]];
        }
        
        self.indexTitles = indexTitles;
        
        [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"LMCityCell"];
    }
    
    return self;
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return self.data.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return ((NSArray *)self.data[section][self.cityKey]).count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LMCityCell" forIndexPath:indexPath];
    
    cell.textLabel.text = self.data[indexPath.section][self.cityKey][indexPath.row];
    
    return cell;
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return self.indexTitles;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    return self.data[section][self.indexKey];
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    LMBlock_Safe_Run(self.completionBlock, self.data[indexPath.section][self.cityKey][indexPath.row]);
}

@end
