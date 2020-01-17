//
//  StudyListController.m
//  毕业
//
//  Created by 吴添培的黑苹果 on 2017/10/15.
//  Copyright © 2017年 吴添培. All rights reserved.
//

#import "SchoolListController.h"
#import <Popover.OC/PopoverView.h>
#import "SchoolDetailController.h"
#import "SchoolsModel.h"
#import "SchoolsCell.h"

static NSString *identify = @"ScroolsCellID";
@interface SchoolListController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *schoolsModelArray;
@end

@implementation SchoolListController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self schoolsModelArray];
    [self setupNavigationBar];
    [self tableView];
    [self setUpRefresh];
    
}

-(NSMutableArray *)schoolsModelArray{
    if (_schoolsModelArray == nil) {
        _schoolsModelArray = [SchoolsModel getSchoolsModelArray];
        for (int i = 0; i < 9; i++) {
            [_schoolsModelArray addObject:_schoolsModelArray[0]];
        }
    }
    return _schoolsModelArray;
}

-(void)setupNavigationBar{
    self.navigationItem.title = @"高校列表";
   
}

-(void)setUpRefresh{
    //默认【上拉加载】
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMore)];
}

-(void)loadMore
{
    if (_schoolsModelArray.count < 50) {
        for (int i = 0; i < 10; i++) {
            [_schoolsModelArray addObject:_schoolsModelArray[0]];
        }
    }
    [self.tableView reloadData];
    [self.tableView.mj_footer endRefreshing];
}

-(UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] init];
        _tableView.frame = self.view.bounds;
        [_tableView registerNib:[UINib nibWithNibName:@"SchoolsCell" bundle:nil] forCellReuseIdentifier:identify];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        [self.view addSubview: _tableView];
    }
    return _tableView;
}


//MARK: - tableViewDataSource,tableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.schoolsModelArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SchoolsCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    SchoolsModel *model = _schoolsModelArray[indexPath.row];
    cell.model = model;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    SchoolDetailController *detail = [[SchoolDetailController alloc] init];
    detail.model = _schoolsModelArray[indexPath.row];
    [self.navigationController pushViewController:detail animated:YES];
}

@end
