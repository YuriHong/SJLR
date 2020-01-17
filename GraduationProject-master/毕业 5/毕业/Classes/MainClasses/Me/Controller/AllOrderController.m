//
//  AllOrderController.m
//  test-个人
//
//  Created by 龙波 on 2017/10/31.
//  Copyright © 2017年 ----龙波. All rights reserved.
//


#import "AllOrderController.h"
#import "AFNetworking.h"
#import "MJExtension.h"
#import "AllOrderCell.h"
#import "OrderListModel.h"
#import "OrderItemVoListModel.h"
#import "MyOrderCell.h"
#import "UIView+ BorderLine.h"
#import "OrderDetailController.h"
#import "PayViewController.h"

#define kallordercell @"allorderCellID"
#define kVIewDSF @"sfjlksajfklds"
#define korderBtnCell @"orderbtnCellID"
#define kMyOrderCell @"myorderCellID"

@interface AllOrderController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong) UITableView *myTableView;
@property(nonatomic,strong) NSMutableArray *dataSourceOrder;
@property(nonatomic,strong) NSMutableArray *statusDataSource;
@property(nonatomic,strong) NSMutableArray *OrderNoDataSorce;
@property(nonatomic,assign) NSInteger pageNum;


@end

@implementation AllOrderController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    //    self.navigationItem.title = @"所有订单";
    [self initData];
    [self loadData];
    [self  setUpUI];
    
}

#pragma mark ------------------数据加载-----------
-(void)initData
{
    _pageNum =1;
    _dataSourceOrder = [[NSMutableArray alloc]init];
    _statusDataSource = [[NSMutableArray alloc]init];
    _OrderNoDataSorce = [[NSMutableArray alloc]init];
}
-(void)loadData
{
    NSString *pageNumStr = [NSString stringWithFormat:@"%ld",_pageNum];;
    NSDictionary *params = @{@"pageNum":pageNumStr,
                          
                             };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager POST:@"http://47.93.33.181:8080/order/list.do" parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //NSLog(@"LLLLOader%@",responseObject);
        NSMutableDictionary *dict = responseObject[@"data"];
        NSMutableArray *listArray = dict[@"list"];
        if (_pageNum == 1) {
            [_dataSourceOrder removeAllObjects];
            [_statusDataSource removeAllObjects];
            [_OrderNoDataSorce removeAllObjects];

        }
        
        for (int i = 0; i < listArray.count; i ++) {
            OrderListModel *listModel = [OrderListModel mj_objectWithKeyValues:listArray[i]];
            NSString *statusStr = listModel.status;
            NSString *orderNoStr = listModel.orderNo;
            [_dataSourceOrder addObject:listModel];
            [_statusDataSource addObject:statusStr];
            [_OrderNoDataSorce addObject:orderNoStr];
        }
        [self.myTableView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"申请失败");
    }];
    
}

- (void)loadMoreData
{
        _pageNum = _pageNum +1;
        //NSLog(@"刷新了%ld",_pageNum);
        [self loadData];
        [self.myTableView reloadData];
        [self.myTableView.mj_footer endRefreshing];
    

}

#pragma mark--------------UI设计--------------
- (void)setUpUI
{
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT - 70)style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    [tableView registerClass:[AllOrderCell class] forCellReuseIdentifier: kallordercell];
    [tableView registerClass:[MyOrderCell class] forCellReuseIdentifier:kMyOrderCell];
    
    NSMutableArray *refreshingImages = [NSMutableArray array];
    for (NSInteger i = 1; i<=3; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"dropdown_loading_0%zd",i]];
        [refreshingImages addObject:image];
    }
    
    
    MJRefreshAutoGifFooter *footer = [MJRefreshAutoGifFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    [footer setImages:refreshingImages forState:MJRefreshStateRefreshing];
    [footer setTitle:@"数据正在加载中 ..." forState:MJRefreshStateRefreshing];
    
    tableView.mj_footer = footer;
    self.myTableView = tableView;
    
    [self.view addSubview:tableView];
    
    
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    CGFloat sectionFooterHeight = 80;
    CGFloat ButtomHeight = scrollView.contentSize.height - self.myTableView.frame.size.height;
    
    if (ButtomHeight-sectionFooterHeight <= scrollView.contentOffset.y && scrollView.contentSize.height > 0) {
        scrollView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    } else  {
        scrollView.contentInset = UIEdgeInsetsMake(0, 0, -(sectionFooterHeight), 0);
    }
    
}


#pragma mark----------tableviewDelegate---------


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _dataSourceOrder.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section

{
    OrderListModel *listDict = _dataSourceOrder[section];
    NSMutableArray *listArray = listDict.orderItemVoList;
    return listArray.count+1;
}



-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 40;
    }
    return 150;
}

//-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
//{
//    return 13;
//}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    int status = [_statusDataSource[indexPath.section] intValue];
    
    if (indexPath.row == 0) {
        MyOrderCell *cell = [MyOrderCell cellwithTableView: tableView];
        cell.title = [NSString stringWithFormat:@"订单编号: %@",_OrderNoDataSorce[indexPath.section]];
        if (status == 0) {
            cell.statusTitle = @"已取消";
        }else if (status == 10)
        {
            
            cell.statusTitle = @"未支付";
        }else if (status == 20)
        {
            cell.statusTitle = @"已支付";
        }else if (status == 50)
        {
            cell.statusTitle = @"交易完成";
        }
        
        return cell;
    }
    
    
    AllOrderCell *cell = [AllOrderCell cellWithTableView: tableView];
    
    OrderListModel *dict = _dataSourceOrder[indexPath.section];
    NSMutableArray *voListArray = dict.orderItemVoList;
    OrderItemVoListModel *voListModel =  [OrderItemVoListModel mj_objectWithKeyValues:voListArray[indexPath.row - 1]];
    [cell reloadDataWithModel:voListModel];
    return cell;
    
}



-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *footerView = [[UIView alloc] init];
    footerView.userInteractionEnabled = YES;
   // footerView.backgroundColor = [UIColor grayColor];
    footerView.backgroundColor = RGBAColor(128, 128, 128, 0.5);
    
    [footerView borderForColor:[UIColor blackColor] borderWidth:2 borderType:UIBorderSideTypeTop];
    
    UIView *backView = [[UIView alloc]init];
    backView.backgroundColor = [UIColor whiteColor];
    backView.frame = CGRectMake(0, 0, SCREENWIDTH, 40);
    [footerView addSubview:backView];
    NSInteger status = [_statusDataSource[section] integerValue];
    NSLog(@"sjfijefi   %ld",section);
    
    if (status == 10) {
        UIButton *payBtn = [[UIButton alloc]init];
        payBtn.frame  = CGRectMake(330, 0, 60, 36) ;
        payBtn.backgroundColor = [UIColor whiteColor];
        payBtn.layer.masksToBounds = YES;
        payBtn.layer.borderWidth = 1;
        payBtn.layer.cornerRadius = 10;
        payBtn.tag = section;
        [payBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [payBtn setTitle:@"付款" forState:UIControlStateNormal];
        [payBtn.titleLabel setFont:[UIFont systemFontOfSize:15]];
        [payBtn setTranslatesAutoresizingMaskIntoConstraints:NO];
        [payBtn addTarget:self action:@selector(goPayOrder:) forControlEvents:UIControlEventTouchUpInside];
        //[footerView addSubview:btnExit];
        
        [footerView addSubview:payBtn];
    }
    
    
    
    
    return footerView;
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 44;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    OrderDetailController *oc = [[OrderDetailController alloc]init];
    oc.orderNo = _OrderNoDataSorce[indexPath.section];
    [self.navigationController pushViewController:oc animated:YES];
}

- (void)goPayOrder:(UIButton *)button
{
    PayViewController *pc = [[PayViewController alloc]init];
    
    pc.orderNO = _OrderNoDataSorce[button.tag];
    [self.navigationController pushViewController:pc animated:YES];
    NSLog(@"付款");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
