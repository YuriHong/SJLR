//
//  majorListController.m
//  毕业
//
//  Created by 吴添培的黑苹果 on 2017/10/16.
//  Copyright © 2017年 吴添培. All rights reserved.
//

#import "majorListController.h"
#import <Popover.OC/PopoverView.h>
#import "majorDetailController.h"
#import "CourseData.h"
#import "DetailCourseModel.h"
#import "majorCell.h"

static NSString *identify = @"majorCellID";
@interface majorListController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@end

@implementation majorListController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNavigationBar];
    [self tableView];
    [self setUpRefresh];
    [self RefreshData];
    
}

-(NSMutableArray *)dataArray{
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

-(void)setupNavigationBar{
    self.navigationItem.title = @"专业列表";
}

- (void)RefreshData{
    NSString *urlString = [NetworkTool willConcatenationString:@"/product/list.do"];
    NSDictionary *params = @{@"categoryId": @"100002",};
    [[NetworkTool sharedInstance] requestWithURLString:urlString params:params method:POST callBack:^(id data, bool isSuccess) {
        CourseData *model = [CourseData mj_objectWithKeyValues:data];
        if (isSuccess == YES) {
            NSArray *list = model.data[@"list"];
            if (model.status == 0) {
                for (NSDictionary *dict in list) {
                    DetailCourseModel *detailModel = [DetailCourseModel mj_objectWithKeyValues:dict];
                    [self.dataArray addObject:detailModel];
                }
                for (int i = 0; i < 9; i++) {
                    [self.dataArray addObject:self.dataArray[0]];
                }
                [self.tableView reloadData];
            }
        }
    }];
    
}

-(void)setUpRefresh{
    //默认【上拉加载】
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMore)];
}

-(void)loadMore
{
    if (self.dataArray.count < 50) {
        for (int i = 0; i < 10; i++) {
            [self.dataArray addObject:self.dataArray[0]];
        }
    }
    
    [self.tableView reloadData];
    [self.tableView.mj_footer endRefreshing];
}

-(UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] init];
        _tableView.frame = CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT - 64);
        [_tableView registerNib:[UINib nibWithNibName:@"majorCell" bundle:nil] forCellReuseIdentifier:identify];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        [self.view addSubview: _tableView];
    }
    return _tableView;
}


//MARK: - tableViewDataSource,tableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    majorCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    DetailCourseModel *model = self.dataArray[indexPath.row];
    cell.model = model;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    majorDetailController *major = [[majorDetailController alloc] init];
    DetailCourseModel *model = self.dataArray[indexPath.row];
    major.ID = [NSString stringWithFormat:@"%d",model.id];
    [self.navigationController pushViewController:major animated:YES];
}


@end
