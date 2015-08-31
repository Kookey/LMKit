//
//  LMPickerViewTC.m
//  LMKitDemo
//
//  Created by 李蒙 on 15/8/30.
//  Copyright (c) 2015年 李蒙. All rights reserved.
//

#import "LMPickerViewTC.h"
#import "LMKit.h"

@interface LMPickerViewTC () <UIPickerViewDataSource, UIPickerViewDelegate>

@property (strong, nonatomic) LMPickerView *pickerView;

@end

@implementation LMPickerViewTC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.pickerView = [LMPickerView new];
    self.pickerView.delegate = self;
    self.pickerView.dataSource = self;
    
    self.pickerView.itemBarAttributes = @{NSFontAttributeName: [UIFont boldSystemFontOfSize:17], NSForegroundColorAttributeName: LMColorWithRed};
    
    [self.pickerView lm_addBarItem:[[UIBarButtonItem alloc] initWithTitle:@"自定义" style:UIBarButtonItemStylePlain target:self action:@selector(customAction)]];
}

- (void)customAction
{
    LMLog(@"customAction");
    
    [self.pickerView lm_dismiss];
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    [self.pickerView lm_showPickerViewWithCancel:^{
        LMLog(@"Cancel");
    } done:^{
        LMLog(@"Done");
    }];
}

#pragma mark - UIPickerViewDataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    
    return 2;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    
    return 10;
}

#pragma mark - UIPickerViewDelegate

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    
    return [NSString stringWithFormat:@"%zd-%zd", row, component];
}

@end
