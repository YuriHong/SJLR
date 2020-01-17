//
//  AllCourseViewController.m
//  搜索下拉
//
//  Created by 吴添培 on 2017/8/7.
//  Copyright © 2017年 吴添培. All rights reserved.
//

#import "twoMenuController.h"
#import "menuModel.h"

extern NSString * const UpdateMenuTitleNote;
static NSString * const leftTableViewID = @"leftID";
static NSString * const rightTableViewID = @"rightID";


@interface twoMenuController ()
@property (strong, nonatomic) IBOutlet UITableView *leftTableView;
@property (strong, nonatomic) IBOutlet UITableView *rightTableView;

@property (strong, nonatomic) menuModel *selectesModel;

@end

@implementation twoMenuController

-(void)setTwoMenu:(NSMutableArray *)twoMenu{
    _twoMenu = twoMenu;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.leftTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:leftTableViewID];
    [self.rightTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:rightTableViewID];
}

#pragma mark - <UITableViewDataSource>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.leftTableView) {
        return _twoMenu.count;
        
    } else {
        return self.selectesModel.secondMenu.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.leftTableView) {
        UITableViewCell *cell =  [tableView dequeueReusableCellWithIdentifier:leftTableViewID];
        menuModel *AC = [_twoMenu objectAtIndex:indexPath.row];
        cell.textLabel.text = AC.firstName;
        if (AC.secondMenu.count) {
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }else{
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
        return cell;
    }else{
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:rightTableViewID];
        cell.textLabel.text = _selectesModel.secondMenu[indexPath.row];
        
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.leftTableView) {
        menuModel *AC = [_twoMenu objectAtIndex:indexPath.row];
        if (!AC.secondMenu.count) {
            UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
            [[NSNotificationCenter defaultCenter] postNotificationName:UpdateMenuTitleNote object:self userInfo:@{@"title":cell.textLabel.text}];
        }
        _selectesModel = [_twoMenu objectAtIndex:indexPath.row];
        [self.rightTableView reloadData];
        return;
    }
    else{
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        if (indexPath.row == 0) {
            [[NSNotificationCenter defaultCenter] postNotificationName:UpdateMenuTitleNote object:self userInfo:@{@"title":_selectesModel.firstName}];
        }else{
        [[NSNotificationCenter defaultCenter] postNotificationName:UpdateMenuTitleNote object:self userInfo:@{@"title":cell.textLabel.text}];
        }
    }
}

@end
