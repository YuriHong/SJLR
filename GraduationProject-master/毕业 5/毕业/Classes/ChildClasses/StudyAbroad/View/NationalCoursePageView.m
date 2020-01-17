//
//  nationalCoursePageView.m
//  毕业
//
//  Created by 吴添培的黑苹果 on 2017/10/15.
//  Copyright © 2017年 吴添培. All rights reserved.
//

#import "NationalCoursePageView.h"
#import "majorCell.h"
#import "CourseData.h"
#import "DetailCourseModel.h"

static NSString *ID = @"majorCellID";
@interface NationalCoursePageView ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *detailArray;
@end

@implementation NationalCoursePageView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self tableView];
    }
    return self;
}

-(NSMutableArray *)detailArray{
    if (_detailArray == nil) {
        _detailArray = [NSMutableArray array];
    }
    return _detailArray;
}

-(void)setArray:(NSArray *)array{
    _array = array;
    
    [self detailArray];
    for (NSString *str in array) {
        NSString *urlString = [NetworkTool willConcatenationString:@"/product/detail.do"];
        NSDictionary *params = @{@"productId": str};
        [[NetworkTool sharedInstance] requestWithURLString:urlString params:params method:POST callBack:^(id data, bool isSuccess) {
            CourseData *model = [CourseData mj_objectWithKeyValues:data];
            if (isSuccess == YES) {
                if (model.status == 0) {
                    DetailCourseModel *detailModel = [DetailCourseModel mj_objectWithKeyValues:model.data];
                    [_detailArray addObject:detailModel];
                    [self.tableView reloadData];
                }
                else{
                    [UIAlertController creatAlertControllerTitle:model.msg withMessage:nil target:self];
                }
            }
            else{
                [UIAlertController creatAlertControllerTitle:@"网络异常" withMessage:nil target:self];
            }
            
        }];
    }
}


-(UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] init];
        _tableView.frame = self.bounds;
        [_tableView registerNib:[UINib nibWithNibName:@"majorCell" bundle:nil] forCellReuseIdentifier:ID];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        [self addSubview:_tableView];
    }
    return _tableView;
}


//MARK: - tableViewDataSource,tableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.detailArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    majorCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    DetailCourseModel *model = self.detailArray[indexPath.row];
    cell.model = model;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([_delegate respondsToSelector:@selector(pushMajorDetailViewControllerWithID:)]) {
        [_delegate pushMajorDetailViewControllerWithID:_array[indexPath.row]];
    }
}

@end
