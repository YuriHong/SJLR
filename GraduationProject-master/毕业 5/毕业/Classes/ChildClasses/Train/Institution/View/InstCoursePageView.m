//
//  ChildCurriculumView.m
//  毕业
//
//  Created by 吴添培的黑苹果 on 2017/10/11.
//  Copyright © 2017年 吴添培. All rights reserved.
//

#import "InstCoursePageView.h"
#import "CourseCell.h"
#import "CourseData.h"
#import "DetailCourseModel.h"

static NSString *ID = @"Cell";
@interface InstCoursePageView ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *detailCourseArray;
@end

@implementation InstCoursePageView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self == [super initWithFrame:frame]) {
        [self tableView];
    }
    return self;
}

-(NSMutableArray *)detailCourseArray{
    if (_detailCourseArray == nil) {
        _detailCourseArray = [NSMutableArray array];
    }
    return _detailCourseArray;
}

-(void)setCourseArray:(NSArray *)courseArray{
    _courseArray = courseArray;
    [self detailCourseArray];
    for (NSString *str in courseArray) {
        NSString *urlString = [NetworkTool willConcatenationString:@"/product/detail.do"];
        NSDictionary *params = @{@"productId": str};
        [[NetworkTool sharedInstance] requestWithURLString:urlString params:params method:POST callBack:^(id data, bool isSuccess) {
            CourseData *model = [CourseData mj_objectWithKeyValues:data];
            if (isSuccess == YES) {
                if (model.status == 0) {
                   DetailCourseModel *detailModel = [DetailCourseModel mj_objectWithKeyValues:model.data];
                    [_detailCourseArray addObject:detailModel];
                    
                }
            }
            [self.tableView reloadData];
        }];
    }
   
    
   
}

-(UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] init];
        _tableView.frame = self.bounds;
        [_tableView registerNib:[UINib nibWithNibName:@"CourseCell" bundle:nil] forCellReuseIdentifier:ID];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        [self addSubview:_tableView];
    }
    return _tableView;
}


#pragma mark - Table view data source
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.detailCourseArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CourseCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    DetailCourseModel *detail = _detailCourseArray[indexPath.row];
    cell.detail = detail;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if ([_delegate respondsToSelector:@selector(pushCourseDetailViewControllerWithID:)]) {
        [_delegate pushCourseDetailViewControllerWithID:_courseArray[indexPath.row]];
    }
}

@end
