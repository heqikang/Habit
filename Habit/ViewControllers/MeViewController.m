//
//  MeViewController.m
//  Habit
//
//  Created by ZhengBob on 7/4/2017.
//  Copyright © 2017 Esquel. All rights reserved.
//

#import "MeViewController.h"

@interface MeViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation MeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.scrollView addSubview:self.tableView];
    [self.view addSubview:self.scrollView];
    
    self.dataArray = [NSMutableArray arrayWithObjects:@"运动", @"早睡", @"早起", @"看书", @"学习", nil];
    
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
}

#pragma mark -- 懒加载
- (UITableView *)tableView
{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:kScreenBounds style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

- (NSMutableArray *)dataArray
{
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (UIScrollView *)scrollView
{
    if (_scrollView == nil) {
        _scrollView = [[UIScrollView alloc] initWithFrame:kScreenBounds];
        _scrollView.contentSize = CGSizeMake(0, 2 * kScreenHeight);
    }
    return _scrollView;
}

#pragma mark -- tableView代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.01f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 5.f;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 180.f;
    }else
    {
        return 50.f;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    cell.textLabel.text = self.dataArray[indexPath.section];
    
    return cell;
}


@end
