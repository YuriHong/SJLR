//
//  InstitutionViewController.m
//  毕业
//
//  Created by 吴添培的黑苹果 on 2017/10/5.
//  Copyright © 2017年 吴添培. All rights reserved.
//

#import "InstitutionController.h"
#import "DetailInstController.h"
#import "InstViewCell.h"
#import "InstDetailModel.h"

@interface InstitutionController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,copy)NSArray *array;
@end

@implementation InstitutionController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"机构列表";
    [self tableView];
}

-(NSArray *)array{
    if (_array == nil) {
        _array = [InstDetailModel getInstDetailModelArray];
        
    }
    return _array;
}

-(UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc]init];
        _tableView.frame = CGRectMake(0, 0, SCREENWIDTH , SCREENHEIGHT - 64);
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.dataSource = self;
        _tableView.delegate = self;
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.array.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    InstViewCell *cell = [InstViewCell creatCellWithTableView:tableView];
    InstDetailModel *detail = _array[indexPath.row];
    cell.instModel = detail;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    DetailInstController *instcurriculum = [[DetailInstController alloc] init];
    instcurriculum.model = _array[indexPath.row];
    [self.navigationController pushViewController:instcurriculum animated:YES];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}

@end
