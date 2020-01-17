//
//  OrderDetailController.m
//  毕业
//
//  Created by 龙波 on 2017/11/14.
//  Copyright © 2017年 吴添培. All rights reserved.
//

#import "OrderDetailController.h"
#import "ConsigneeTableCell.h"
#import "OrderItemCell.h"
#import "UIView+SYWLExtension.h"
#import "CartListModel.h"
#import "OrderDataModel.h"
#import "OderItemListModel.h"
#import "PayViewController.h"
#import "ShoppingListModel.h"
#define kconsigneetablecell @"consigneetableCellID"
#define korderitemcell @"orderitemCellID"


@interface OrderDetailController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong) UITableView *myTableView;
@property (strong,nonatomic)UILabel *totlePriceLabel;
@property(nonatomic,strong) NSMutableArray *dataSourceShoppingArray;
@property(nonatomic,strong) NSMutableArray *orderSourceListData;
@property(nonatomic,strong) NSString *status;
@property(nonatomic,strong) ShoppingListModel *shoppingModel;
@property(nonatomic,strong) NSString *price;
@property(nonatomic,strong) UIButton *payBtn;
@property(nonatomic,strong) UIButton *canselBtn;

@end

@implementation OrderDetailController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self initData];
    //    [self loadData];
    [self loadData];
    
    [self setUpUI];
    
}

- (void)initData{
    _orderSourceListData = [[NSMutableArray alloc]init];
    _dataSourceShoppingArray = [[NSMutableArray alloc]init];
}

- (void)setUpUI
{
    
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT)];
    tableView.delegate = self;
    tableView.dataSource = self;
    [tableView registerClass:[ConsigneeTableCell class] forCellReuseIdentifier: kconsigneetablecell];
    [tableView registerClass:[OrderItemCell class] forCellReuseIdentifier: korderitemcell];
    self.myTableView = tableView;
    [self.view addSubview:tableView];
    
    [self setupCustomBottomView];
    
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
    btn.frame = CGRectMake(SCREENWIDTH - 100, 3, 100, 40);
    btn.layer.borderWidth = 1;
    btn.layer.cornerRadius = 10;

    [btn setTintColor:[UIColor whiteColor]];
    [btn setTitle:@"提交订单" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(goToPayClick:) forControlEvents:UIControlEventTouchUpInside];
    btn.hidden = YES;
    self.payBtn = btn;
            [backgroundView addSubview:btn];
    
    
    
    UIButton *Canselbtn =[UIButton buttonWithType:UIButtonTypeCustom];
    Canselbtn.backgroundColor = RGBAColor(128, 128, 128, 0.3);
    Canselbtn.frame =CGRectMake(btn.x - 110, 3, 100, 40);
    [Canselbtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [Canselbtn setTitle:@"取消订单" forState:UIControlStateNormal];
    Canselbtn.layer.borderWidth = 1;
    Canselbtn.layer.cornerRadius = 10;
    [Canselbtn addTarget:self action:@selector(cancelOrder) forControlEvents:UIControlEventTouchUpInside];
    self.canselBtn = Canselbtn;
    [backgroundView addSubview:Canselbtn];
    
    
    
    //合计
    UILabel *label = [[UILabel alloc]init];
    label.font = [UIFont systemFontOfSize:16];
    label.textColor = RGBColor(228, 94, 0);
    [backgroundView addSubview:label];
    
    label.attributedText = [self PriceSetString:@"¥0.00"];
    CGFloat maxWidth = SCREENWIDTH - btn.width - 30;
    //    CGSize size = [label sizeThatFits:CGSizeMake(maxWidth, DWQTabBarHeight)];
    label.frame = CGRectMake(20, 0, maxWidth - 10, 49);
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




- (void)loadData{
    NSDictionary *params = @{@"orderNo": self.orderNo};
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager POST:@"http://47.93.33.181:8080/order/detail.do" parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"ccccccccreat-----%@",responseObject);
        NSMutableDictionary *dataDict = responseObject[@"data"];
        self.totlePriceLabel.attributedText = [self PriceSetString:dataDict[@"payment"]];
                self.status = dataDict[@"status"];
        NSInteger statuIn = [self.status integerValue];
        if (statuIn == 10) {
            self.payBtn.hidden = NO;
        
        }else if (statuIn == 0 || statuIn == 20)
        {
            self.canselBtn.hidden = YES;
        }
        
        _shoppingModel = [ShoppingListModel mj_objectWithKeyValues:dataDict[@"shippingVo"]];
        NSMutableArray *orderArray = dataDict[@"orderItemVoList"];
        [_orderSourceListData removeAllObjects];
        for (int i = 0; i<orderArray.count; i++) {
            OderItemListModel *listModel = [OderItemListModel mj_objectWithKeyValues:orderArray[i]];
            [_orderSourceListData addObject:listModel];
        }
        [self.myTableView reloadData];

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"申请失败");
    }];
    
}





- (NSMutableAttributedString*)PriceSetString:(NSString*)string {
    
    NSString *text = [NSString stringWithFormat:@"合计: ¥%@",string];
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
    }else{
        

    //    return 3;
    return _orderSourceListData.count;
    }
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
        [cell reloadDataWithModel:_shoppingModel];
        
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
