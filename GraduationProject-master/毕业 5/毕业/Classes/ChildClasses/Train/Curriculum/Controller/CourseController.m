//
//  curriculumController.m
//  校园帮(用户)
//
//  Created by 吴添培 on 2017/8/11.
//  Copyright © 2017年 吴添培. All rights reserved.
//

#import "CourseController.h"
#import "PullDownMenuController.h"
#import "CourseCell.h"
#import "CourseData.h"
#import "DetailCourseModel.h"
#import "DetailCourseController.h"
#import "InstDetailModel.h"

@interface CourseController ()<UITableViewDataSource,UITableViewDelegate,PullDownMenuControllerDelegate>
@property(nonatomic,strong)PullDownMenuController *pullDownMenu;
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSMutableArray *dataArray;
@property(nonatomic,copy)NSString *keyword;
@property(nonatomic,copy)NSString *orderBy;
@property(nonatomic,assign) int pageNum;

@end

static NSString *ID = @"Cell";
@implementation CourseController

bool isRefresh = YES;

-(PullDownMenuController *)pullDownMenu{
    if (_pullDownMenu == nil) {
        _pullDownMenu = [[PullDownMenuController alloc]init];
        _pullDownMenu.delegate = self;
        _pullDownMenu.view.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:_pullDownMenu.view];
        [self addChildViewController:_pullDownMenu];
    }
    return _pullDownMenu;
}

-(void)PullDownMenuControllerWithString:(NSString *)string{
    if ([string isEqual:@"价格升序"]) {
        _orderBy = @"price_asc";
    }
    else if ([string isEqual:@"价格降序"]){
        _orderBy = @"price_desc";
    }
    else{
        if ([string isEqual:@"培训"]) {
            _keyword = @"";
        }else{
            _keyword = string;
        }
    }

    _pageNum = 1;
    self.dataArray = nil;
    [self dataArray];
    
    [self RefreshData];
}


-(UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc]init];
        _tableView.frame = CGRectMake(0, 44, SCREENWIDTH , SCREENHEIGHT - 108);
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerNib:[UINib nibWithNibName:@"CourseCell" bundle:nil] forCellReuseIdentifier:ID];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        [_pullDownMenu.view addSubview:_tableView];
    }
    return _tableView;
}

-(NSMutableArray *)dataArray{
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"课程列表";
    _pageNum = 1;
    [self pullDownMenu];
    [self tableView];
    [self setUpRefresh];
    _keyword = @"";
    _orderBy = @"";
    [self RefreshData];
   
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CourseCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    DetailCourseModel *detail = _dataArray[indexPath.row];
    cell.detail = detail;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    DetailCourseModel *detailModel = _dataArray[indexPath.row];
    DetailCourseController *detail = [[DetailCourseController alloc] init];
    NSArray *array = [InstDetailModel getInstDetailModelArray];
    NSString *ID = [NSString stringWithFormat:@"%d",detailModel.id];
    for (int i = 0; i < array.count; i++) {
        InstDetailModel *instModel = array[i];
        for (NSString *str in instModel.courseID) {
            if ([str isEqual:ID]) {
                detail.ID = ID;
                detail.instModel = instModel;
            }
        }
        
    }
    [self.navigationController pushViewController:detail animated:YES];
}

- (void)RefreshData{
    NSString *urlString = [NetworkTool willConcatenationString:@"/product/list.do"];
    NSString * pageNum = [NSString stringWithFormat:@"%d",_pageNum];
    NSDictionary *params = @{@"categoryId": @"100001",
                             @"keyword": _keyword,
                             @"pageNum": pageNum,
                             @"orderBy": _orderBy
                             };
    [[NetworkTool sharedInstance] requestWithURLString:urlString params:params method:POST callBack:^(id data, bool isSuccess) {
        CourseData *model = [CourseData mj_objectWithKeyValues:data];
        if (isSuccess == YES) {
            NSArray *list = model.data[@"list"];
            if (model.status == 0) {
                for (NSDictionary *dict in list) {
                        DetailCourseModel *detailModel = [DetailCourseModel mj_objectWithKeyValues:dict];
                        [self.dataArray addObject:detailModel];
                    
                    
                }
                
                if (list.count != 0) {
                    _pageNum++;
                }
            }
            
        }
        else{
            [UIAlertController creatAlertControllerTitle:@"网络异常" withMessage:nil target:self];
        }
        
        [self.tableView reloadData];
        [self.tableView.mj_footer endRefreshing];
    }];
    
}

-(void)setUpRefresh{
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(RefreshData)];
   
}


@end
