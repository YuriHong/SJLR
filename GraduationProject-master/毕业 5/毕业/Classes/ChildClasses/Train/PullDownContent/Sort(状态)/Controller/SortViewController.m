//
//  SortViewController.m
//  搜索下拉
//
//  Created by 吴添培 on 2017/8/7.
//  Copyright © 2017年 吴添培. All rights reserved.
//

#import "SortViewController.h"
#import "SortViewCell.h"
extern NSString * const UpdateMenuTitleNote;
static NSString * const ID = @"cell";

@interface SortViewController ()
@property (nonatomic, assign) NSInteger selectedCol;

@end

@implementation SortViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _selectedCol = 0;
    
    [self.tableView registerClass:[SortViewCell class] forCellReuseIdentifier:ID];
}

-(void)setTitleArray:(NSArray *)titleArray{
    _titleArray = titleArray;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:_selectedCol inSection:0];
    [self.tableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionNone];
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.titleArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SortViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    cell.textLabel.text = _titleArray[indexPath.row];
    if (indexPath.row == 0) {
        [cell setSelected:YES animated:NO];
    }
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    _selectedCol = indexPath.row;
    // 选中当前
    SortViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    // 更新菜单标题
    [[NSNotificationCenter defaultCenter] postNotificationName:UpdateMenuTitleNote object:self userInfo:@{@"title":cell.textLabel.text}];
    
    
}
@end
