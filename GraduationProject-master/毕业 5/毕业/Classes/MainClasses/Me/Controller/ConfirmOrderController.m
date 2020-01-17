//
//  ConfirmOrderController.m
//  test-个人
//
//  Created by 龙波 on 2017/10/27.
//  Copyright © 2017年 ----龙波. All rights reserved.
//

#import "ConfirmOrderController.h"
#import "ConsigneeTableCell.h"
#import "OrderItemCell.h"
#import "UIView+SYWLExtension.h"
#import "AFNetworking.h"
#import "MJExtension.h"
#import "ShoppingDataModel.h"
#import "ShoppingListModel.h"
#import "CartListModel.h"
#import "OrderDataModel.h"
#import "OderItemListModel.h"
#import "PayViewController.h"
#define kconsigneetablecell @"consigneetableCellID"
#define korderitemcell @"orderitemCellID"

@interface ConfirmOrderController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong) UITableView *myTableView;
@property (strong,nonatomic)UILabel *totlePriceLabel;
@property(nonatomic,strong) NSMutableArray *dataSourceShoppingArray;
@property(nonatomic,strong) NSString *shippingID;
@property(nonatomic,strong) NSMutableArray *orderSourceListData;
@property(nonatomic,strong) NSString *orderNo;


@end

@implementation ConfirmOrderController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self initData];
//    [self loadData];
    [self getShippingData];
    
    [self setUpUI];
    
}

- (void)initData{
    _orderSourceListData = [[NSMutableArray alloc]init];
    _dataSourceShoppingArray = [[NSMutableArray alloc]init];
    _shippingID = [[NSString alloc]init];
    _orderNo = [[NSString alloc]init];
}

- (void)setUpUI
{
    [self setUpRightBtn];

    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT)];
    tableView.delegate = self;
    tableView.dataSource = self;
    [tableView registerClass:[ConsigneeTableCell class] forCellReuseIdentifier: kconsigneetablecell];
    [tableView registerClass:[OrderItemCell class] forCellReuseIdentifier: korderitemcell];
    self.myTableView = tableView;
    [self.view addSubview:tableView];
    
    [self setupCustomBottomView];
    
}

-(void)setUpRightBtn
{
    UIBarButtonItem *rightBtn = [[UIBarButtonItem alloc]initWithTitle:@"取消订单" style:UIBarButtonItemStyleDone target:self action:@selector(cancelOrder)];
    self.navigationItem.leftBarButtonItem = rightBtn;
    
}


#pragma mark -- 自定义底部视图
- (void)setupCustomBottomView {
    
    UIView *backgroundView = [[UIView alloc]init];
    backgroundView.backgroundColor = [UIColor whiteColor];
    backgroundView.tag = 100 + 1;
    [self.view addSubview:backgroundView];
    
    backgroundView.frame = CGRectMake(0, SCREENHEIGHT -  110, SCREENWIDTH, 60);
    UIView *lineView = [[UIView alloc]init];
    
    
    lineView.frame = CGRectMake(0, 0, SCREENWIDTH, 1);
    lineView.backgroundColor = [UIColor lightGrayColor];
    [backgroundView addSubview:lineView];
    
    
    //提交订单按钮
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"btn_order_gotopay"]];
    btn.frame = CGRectMake(SCREENWIDTH - 100, 0, 100, 49);
    [btn setTintColor:[UIColor whiteColor]];
    [btn setTitle:@"提交订单" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(goToPayClick:) forControlEvents:UIControlEventTouchUpInside];
    [backgroundView addSubview:btn];
    
    //合计
    UILabel *label = [[UILabel alloc]init];
    label.font = [UIFont systemFontOfSize:16];
    label.textColor = RGBColor(228, 94, 0);
    [backgroundView addSubview:label];
    
    label.attributedText = [self PriceSetString:@"¥0.00"];
    CGFloat maxWidth = SCREENWIDTH - btn.width - 30;
    //    CGSize size = [label sizeThatFits:CGSizeMake(maxWidth, DWQTabBarHeight)];
    label.frame = CGRectMake(SCREENWIDTH - maxWidth, 0, maxWidth - 10, 49);
    self.totlePriceLabel = label;
}


- (void)goToPayClick:(UIButton *)button
{
   //     NSDictionary *params = @{@"orderNo":self.orderNo};
     //   NSLog(@"NONONONONONO%@",self.orderNo);
       // AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
      //  [manager POST:@"http://47.93.33.181:8080/order/cancel.do" parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
      //      NSLog(@"-----------------------%@",responseObject[@"msg"]);
     //   } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
      //      NSLog(@"申请失败");
       // }];
    

  
        

    
    
    PayViewController *qc = [[PayViewController alloc]init];
    qc.orderNO = self.orderNo;
    [self.navigationController pushViewController:qc animated:YES];
}



- (void)getShippingData
{
    _shippingID = self.getListModel.id;
    [self creatOrder];

}

- (void)creatOrder{
        NSDictionary *params = @{@"shippingId": _shippingID};
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager POST:@"http://47.93.33.181:8080/order/create.do" parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"ccccccccreat-----%@",responseObject);
        OrderDataModel *listModel = [OrderDataModel mj_objectWithKeyValues:responseObject[@"data"]];
        self.orderNo = listModel.orderNo;
        
        [self loadOrderData:listModel.orderNo];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"申请失败");
    }];

}

- (void)loadOrderData:(NSString *)orderNO
{
    NSDictionary *params = @{@"orderNo":orderNO};
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager POST:@"http://47.93.33.181:8080/order/detail.do" parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"LLLLOader%@",responseObject);
        NSDictionary *dataDic = [responseObject objectForKey:@"data"];
        self.totlePriceLabel.attributedText = [self PriceSetString:dataDic[@"payment"]];
        NSMutableArray *listArra = [dataDic objectForKey:@"orderItemVoList"];
        [_orderSourceListData removeAllObjects];
        for (int i =0; i < listArra.count; i ++) {
            OderItemListModel *listModel = [OderItemListModel mj_objectWithKeyValues:listArra[i] ];
            [_orderSourceListData addObject:listModel];
            
        }
        NSLog(@"%ld",_orderSourceListData.count);
//        self.totlePriceLabel.text = dataDic[@"payment"];
        [self.myTableView reloadData];
        
//        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"申请失败");
    }];
}




- (NSMutableAttributedString*)PriceSetString:(NSString*)string {
    
    NSString *text = [NSString stringWithFormat:@"合计:%@",string];
    NSMutableAttributedString *DWQString = [[NSMutableAttributedString alloc]initWithString:text];
    NSRange rang = [text rangeOfString:@"合计:"];
    [DWQString addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:rang];
    [DWQString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:16] range:rang];
    return DWQString;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }
    //    return 3;
    return _orderSourceListData.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 140;
    }
    return 180;
}

//-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
//{
//    return 13;
//}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        
        ConsigneeTableCell *cell = [ConsigneeTableCell cellWithTableView: tableView];
        [cell reloadDataWithModel:self.getListModel];
        
        return cell;
        
    }
    OrderItemCell *cell = [OrderItemCell cellWithTableView: tableView];
    OderItemListModel *itemListModel = _orderSourceListData[indexPath.row];
    [cell reloadDataWithModel:itemListModel];
    return cell;

}

- (void)cancelOrder
{
    NSDictionary *params = @{@"orderNo":self.orderNo};
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager POST:@"http://47.93.33.181:8080/order/cancel.do" parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"CCCCCCCC%@",responseObject);
        
        [self.navigationController popToRootViewControllerAnimated:YES];
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"申请失败");
    }];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
