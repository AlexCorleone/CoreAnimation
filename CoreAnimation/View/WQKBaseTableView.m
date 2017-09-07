//
//  WQKBaseTableView.m
//  CoreAnimation
//
//  Created by AlexCorleone on 2017/9/7.
//  Copyright © 2017年 魏乾坤. All rights reserved.
//

#import "WQKBaseTableView.h"

@interface WQKBaseTableView ()<UITableViewDelegate, UITableViewDataSource>


@property (nonatomic, strong) UITableView *baseTableView;

@property (nonatomic, strong) NSDictionary *baseDataArray;

@end

@implementation WQKBaseTableView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self addSubview:self.baseTableView];
    }
    return self;
}

#pragma mark - setter && getter
- (UITableView *)baseTableView
{
    if (!_baseTableView)
    {
        self.baseTableView = [[UITableView alloc] initWithFrame:self.bounds style:UITableViewStylePlain];
        [_baseTableView setDelegate:self];
        [_baseTableView setDataSource:self];
        _baseTableView.tableFooterView = [UIView new];
        _baseTableView.tableHeaderView = [UIView new];
    }
    return _baseTableView;
}

#pragma marrk - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma marrk - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.baseDataArray.count;
}

static NSString * const cellIdentifier = @"cellidentifier";
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        UIView *bGView = [[UIView alloc] initWithFrame:cell.bounds];
        [bGView setBackgroundColor:[UIColor purpleColor]];
        [cell setSelectedBackgroundView:bGView];
    }
    return cell;
}
@end
