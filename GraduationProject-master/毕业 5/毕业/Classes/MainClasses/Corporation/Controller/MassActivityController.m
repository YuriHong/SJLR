//
//  MassActivityController.m
//  毕业设计
//
//  Created by 龙波 on 2017/9/22.
//  Copyright © 2017年 ----龙波. All rights reserved.
//

#import "MassActivityController.h"
#import "Carousel.h"
#import "MassTableViewCell.h"
#import "MassAcidityTextController.h"
#import "PureLayout.h"
#import "MassMainModel.h"
#import "FlowViewCell.h"
#define kmasstabeleCell @"masstableCellID"
#define kflowviewcell @"flowviewCellId"

@interface MassActivityController ()<UITableViewDelegate,UITableViewDataSource,FlowViewCellDelegate>
@property(nonatomic,strong) UITableView *myTableView;
@property(nonatomic,weak) NSLayoutConstraint *headHeightCons ;
@property(nonatomic,assign) NSInteger pageNum;
@property(nonatomic,strong) NSMutableArray *data;
@property(nonatomic,strong) Carousel *carousel;

@end

@implementation MassActivityController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
    
    [self loadData];

    [self setUpTabelView];
  //  [self setUpFlowView];
    
    self.navigationItem.title = @"社团活动";
    // Do any additional setup after loading the view.
}

- (void)setUpTabelView
{
        UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT-64)];
        tableView.delegate = self;
        tableView.dataSource = self;
    [tableView registerClass:[MassTableViewCell class] forCellReuseIdentifier: kmasstabeleCell];
    [tableView registerClass:[FlowViewCell class] forCellReuseIdentifier: kflowviewcell];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    //
    NSMutableArray *refreshingImages = [NSMutableArray array];
    for (NSInteger i = 1; i<=3; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"dropdown_loading_0%zd",i]];
        [refreshingImages addObject:image];
    }
   
    MJRefreshAutoGifFooter *footer = [MJRefreshAutoGifFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    [footer setImages:refreshingImages forState:MJRefreshStateRefreshing];
    [footer setTitle:@"数据正在加载中 ..." forState:MJRefreshStateRefreshing];
    tableView.mj_footer = footer;
    
    _myTableView = tableView;
        [self.view addSubview:tableView];
}



- (void)initData{
    _pageNum = 1;
    _data = [[NSMutableArray alloc]init];

}


-(void)loadData{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSString *pageNumStr = [NSString stringWithFormat:@"%ld",_pageNum];
    NSDictionary *params = @{@"categoryId":@"430000",
                             @"pageNum":pageNumStr
                             };
    
    [manager POST:@"http://47.93.33.181:8080/product/list.do" parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"LLLLOader%@",responseObject);
        NSMutableDictionary *dict = responseObject[@"data"];
        NSMutableArray *listArray = dict[@"list"];
        if (_pageNum == 1) {
            [_data removeAllObjects];

        }
       
        
        for (int i = 0; i < listArray.count; i ++) {
            MassMainModel *listModel = [MassMainModel mj_objectWithKeyValues:listArray[i]];
            
            [_data addObject:listModel];
        }
        [self.myTableView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"申请失败");
    }];
}

- (void)loadMoreData
{
    _pageNum = _pageNum+1;
    [self loadData];
    [self.myTableView reloadData];
    [self.myTableView.mj_footer endRefreshing];

}
#pragma -----mark------tableviewDelegate---

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 120;
    }
    return 150;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
        
    }
    return _data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        FlowViewCell *cell = [FlowViewCell cellWithTableView:tableView];
        cell.delegate = self;
        return cell;
    }
    
    MassTableViewCell *cell = [MassTableViewCell cellWithTabelView:tableView];
    MassMainModel *listModle = [MassMainModel mj_objectWithKeyValues:_data[indexPath.row]];
    [cell reloadDataWithModel:listModle];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1) {
        MassAcidityTextController *acivity = [[MassAcidityTextController alloc]init];
        MassMainModel *listModel = [MassMainModel mj_objectWithKeyValues:_data[indexPath.row]];
        acivity.productID = listModel.id;
        
        [self.navigationController pushViewController:acivity animated:YES];

    }
}

- (void)didCarouselIndex:(NSInteger)produId
{
    NSLog(@"ppppppppppppp%ld",produId);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
