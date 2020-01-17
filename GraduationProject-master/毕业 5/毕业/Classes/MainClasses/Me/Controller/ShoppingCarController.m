//
//  ShoppingCarController.m
//  test-个人
//
//  Created by 龙波 on 2017/10/25.
//  Copyright © 2017年 ----龙波. All rights reserved.
//

#import "ShoppingCarController.h"
#import "OrderTableViewCell.h"
#import "AFNetworking.h"
#import "MJExtension.h"
#import "CartBaseModel.h"
#import "CartDataModel.h"
#import "CartListModel.h"
#import "OrderFooterView.h"
#import "ReceiverController.h"
#import "NetworkTool.h"
#import "UIAlertController+Extention.h"
#define kordertableviewcell @"ordertableviewCellID"

@interface ShoppingCarController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray *_dataSourceArray;
    UIView *_backgroundView;
}
@property(nonatomic,strong) UITableView *tableView;
@property (strong,nonatomic)NSMutableArray *selectedArray;

@property(nonatomic,strong) NSString *orderNoStr;

@property (strong,nonatomic)UIButton *allSellectedButton;
@property (strong,nonatomic)UILabel *totlePriceLabel;


@end

@implementation ShoppingCarController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
    self.view.backgroundColor = [UIColor whiteColor];
    UITableView *tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT - 50)];
    [tableview registerClass:[OrderTableViewCell class] forCellReuseIdentifier: kordertableviewcell];
    tableview.delegate = self;
    tableview.dataSource =self;
    tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView = tableview;
    [self.view addSubview:tableview];
    //  [self setupCustomBottomView];
    
    
}

#pragma 获取当前时间
- (NSString *)getNowTime
{
    NSDate *date = [NSDate date];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    
    [formatter setDateFormat:@"YYMMddhhmm"];
    NSString *DateTime = [formatter stringFromDate:date];
    NSLog(@"%@===",DateTime);
    return DateTime;
}

#pragma mark-----数量-------
-(void)productNumberChange:(NSNumber *)productID andCount:(NSInteger )count
{
    NSString *coutStr =[NSString stringWithFormat:@"%ld",count];
    NSDictionary *params = @{@"productId": productID,
                             @"count":coutStr
                             };
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager POST:@"http://47.93.33.181:8080/cart/update.do" parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        CartDataModel *dataModel = [CartDataModel mj_objectWithKeyValues:responseObject[@"data"]];
        
        
        
        [_dataSourceArray removeAllObjects];
        
        for (int i =0; i < dataModel.cartProductVoList.count; i ++) {
            CartListModel *listModel = [CartListModel mj_objectWithKeyValues:dataModel.cartProductVoList[i]];
            [_dataSourceArray addObject:listModel];
            
        }
        NSLog(@"_dadadadad%@",_dataSourceArray);
        [self.tableView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"移除失败");
    }];
    
}


#pragma mark --------点击选中。。。。。。
- (void)productSelect:(NSNumber *)productID
{
    NSDictionary *params = @{@"productId": productID};
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager POST:@"http://47.93.33.181:8080/cart/select.do" parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        CartDataModel *data = [CartDataModel mj_objectWithKeyValues:responseObject[@"data"]];
        NSString *totalPrice = [NSString stringWithFormat:@"¥%@",data.cartTotalPrice];
        self.totlePriceLabel.attributedText = [self PriceSetString:totalPrice];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"移除失败");
    }];
    
}

- (void)productCancelSelect:(NSNumber *)productID
{
    NSDictionary *params = @{@"productId": productID};
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager POST:@"http://47.93.33.181:8080/cart/un_select.do" parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"ccccccccccc%@",responseObject);
        CartDataModel *data = [CartDataModel mj_objectWithKeyValues:responseObject[@"data"]];
        NSString *totalPrice = [NSString stringWithFormat:@"¥%@",data.cartTotalPrice];
        self.totlePriceLabel.attributedText = [self PriceSetString:totalPrice];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"移除失败");
    }];
    
}

- (void)productAllSelect
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager POST:@"http://47.93.33.181:8080/cart/select_all.do" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"ccccccccccc%@",responseObject);
        CartDataModel *data = [CartDataModel mj_objectWithKeyValues:responseObject[@"data"]];
        NSString *totalPrice = [NSString stringWithFormat:@"¥%@",data.cartTotalPrice];
        self.totlePriceLabel.attributedText = [self PriceSetString:totalPrice];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"移除失败");
    }];
    
}

- (void)productCancelAllSelect
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager POST:@"http://47.93.33.181:8080/cart/un_select_all.do" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"ccccccccccc%@",responseObject);
        CartDataModel *data = [CartDataModel mj_objectWithKeyValues:responseObject[@"data"]];
        NSString *totalPrice = [NSString stringWithFormat:@"¥%@",data.cartTotalPrice];
        self.totlePriceLabel.attributedText = [self PriceSetString:totalPrice];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"移除失败");
    }];
    
}

- (void)initData{
    _dataSourceArray = [[NSMutableArray alloc]init];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager POST:@"http://47.93.33.181:8080/cart/un_select_all.do" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {

        [self loadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"移除失败");
    }];

    
}

- (NSMutableArray *)selectedArray {
    if (_selectedArray == nil) {
        _selectedArray = [NSMutableArray arrayWithCapacity:0];
    }
    
    return _selectedArray;
}


- (void)loadData
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [manager POST:[NSString stringWithFormat:@"http://47.93.33.181:8080/cart/list.do"]parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@",responseObject);
        CartDataModel *dataModel = [CartDataModel mj_objectWithKeyValues:responseObject[@"data"]];
        
        
        
        [_dataSourceArray removeAllObjects];
        
        for (int i =0; i < dataModel.cartProductVoList.count; i ++) {
            CartListModel *listModel = [CartListModel mj_objectWithKeyValues:dataModel.cartProductVoList[i]];
            [_dataSourceArray addObject:listModel];
            
        }
        NSLog(@"_dadadadad%@",_dataSourceArray);
        [self.tableView reloadData];
        [self changeView];
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
    
}

#pragma mark -----当购物车显示为空的时候


- (void)changeView {
    if (_dataSourceArray.count > 0) {
        UIView *view = [self.view viewWithTag:100];
        if (view != nil) {
            [view removeFromSuperview];
        }
        
        [self setupCustomBottomView];
    } else {
        UIView *bottomView = [self.view viewWithTag: 101];
        [bottomView removeFromSuperview];
        
        [self.tableView removeFromSuperview];
        self.tableView = nil;
        [self setUpCartNil];
    }
}


- (void)setUpCartNil
{
    //默认视图背景
    UIView *backgroundView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT)];
    backgroundView.tag = 100;
    [self.view addSubview:backgroundView];
    
    //默认图片
    UIImageView *img = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"cart_noproduct"]];
    img.center = CGPointMake(SCREENWIDTH/2.0, SCREENHEIGHT/2.0 - 120);
    img.bounds = CGRectMake(0, 0, 247.0/187 * 100, 100);
    [backgroundView addSubview:img];
    
    UILabel *warnLabel = [[UILabel alloc]init];
    warnLabel.center = CGPointMake(SCREENWIDTH/2.0, SCREENHEIGHT/2.0 - 10);
    warnLabel.bounds = CGRectMake(0, 0, SCREENWIDTH, 30);
    warnLabel.textAlignment = NSTextAlignmentCenter;
    warnLabel.text = @"购物车为空!";
    warnLabel.font = [UIFont systemFontOfSize:15];
    warnLabel.textColor =RGBColor(0, 115, 113);
    [backgroundView addSubview:warnLabel];
    
}


#pragma mark -- 自定义底部视图
- (void)setupCustomBottomView {
    
    UIView *backgroundView = [[UIView alloc]init];
    backgroundView.backgroundColor = RGBColor(0, 50, 104);
    backgroundView.tag = 100 + 1;
    _backgroundView = backgroundView;
    [self.view addSubview:backgroundView];
    
    backgroundView.frame = CGRectMake(0, SCREENHEIGHT -  110, SCREENWIDTH, 60);
    UIView *lineView = [[UIView alloc]init];
    
    
    lineView.frame = CGRectMake(0, 0, SCREENWIDTH, 1);
    lineView.backgroundColor = [UIColor lightGrayColor];
    [backgroundView addSubview:lineView];
    
    //全选按钮
    UIButton *selectAll = [UIButton buttonWithType:UIButtonTypeCustom];
    selectAll.titleLabel.font = [UIFont systemFontOfSize:16];
    selectAll.frame = CGRectMake(10, 5, 80, 49 - 10);
    [selectAll setTitle:@" 全选" forState:UIControlStateNormal];
    [selectAll setImage:[UIImage imageNamed:@"cart_unSelect_btn"] forState:UIControlStateNormal];
    [selectAll setImage:[UIImage imageNamed:@"cart_selected_btn"] forState:UIControlStateSelected];
    [selectAll setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [selectAll addTarget:self action:@selector(selectAllBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [backgroundView addSubview:selectAll];
    self.allSellectedButton = selectAll;
    
    //结算按钮
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"btn_order_gotopay"]];
    btn.frame = CGRectMake(SCREENWIDTH - 100, 0, 100, 49);
    [btn setTintColor:[UIColor whiteColor]];
    [btn setTitle:@"去结算" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(goToPayButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [backgroundView addSubview:btn];
    
    //合计
    UILabel *label = [[UILabel alloc]init];
    label.font = [UIFont systemFontOfSize:16];
    label.textColor = RGBColor(255, 109, 0);
    [backgroundView addSubview:label];
    
    label.attributedText = [self PriceSetString:@"¥0"];
    CGFloat maxWidth = SCREENWIDTH - selectAll.bounds.size.width - btn.bounds.size.width - 30;
    //    CGSize size = [label sizeThatFits:CGSizeMake(maxWidth, DWQTabBarHeight)];
    label.frame = CGRectMake(selectAll.bounds.size.width + 20, 0, maxWidth - 10, 49);
    self.totlePriceLabel = label;
}

//MARK: -  svd
- (void)goToPayButtonClick:(UIButton *)button
{
    //    NSDictionary *params = @{@"shippingId": [self getNowTime]};
    //
    //
    //    [[NetworkTool sharedInstance] requestWithURLString:[NSString stringWithFormat:@"http://47.93.33.181:8080/order/create.do"] params:params method:POST callBack:^(id data, bool isSuccess) {
    //        NSLog(@"%@",data);
    //        if (isSuccess == YES) {
    //            CartListModel *listModel = [CartListModel mj_objectWithKeyValues:data[@"data"]];
    //            self.orderNoStr = [NSString stringWithFormat:@"%@",listModel.orderNo];
    //            NSLog(@"%@",self.orderNoStr);
    //        }else
    //        {
    //            NSLog(@"失败了");
    //        }
    //
    //
    //    }];
    ////    [self getNowTime];
    
    if ([self.totlePriceLabel.text isEqualToString:@"合计:¥0"]) {
        [UIAlertController creatAlertControllerTitle:@"提示" withMessage:@"请选择商品" target:self];
    }else{
        ReceiverController *rc = [[ReceiverController alloc]init];
        [self.navigationController pushViewController:rc animated:YES];
    }
}

- (void)selectAllBtnClick:(UIButton*)button {
    button.selected = !button.selected;
    
    //点击全选时,把之前已选择的全部删除
    for (CartListModel *model in self.selectedArray) {
        model.select = NO;
    }
    
    [self.selectedArray removeAllObjects];
    
    if (button.selected) {
        
        //        for (CartDataModel *shop in _dataSourceArray) {
        //            shop.select = YES;
        //            for (CartDataModel *model in shop.cartProductVoList) {
        //                model.select = YES;
        //                [self.selectedArray addObject:model];
        //            }
        //        }
        [self productAllSelect];
        for (CartListModel *list in _dataSourceArray) {
            list.select = YES;
            [self.selectedArray addObject:list];
        }
        
    } else {
        [self productCancelAllSelect];
        for (CartListModel *shop in _dataSourceArray) {
            shop.select = NO;
        }
    }
    
    [self.tableView reloadData];
    //   [self countPrice];
}


-(void)countPrice {
    double totlePrice = 0.0;
    
    for (CartListModel *model in self.selectedArray) {
        
        double price = [model.productTotalPrice doubleValue];
        
        totlePrice += price;
    }
    NSString *string = [NSString stringWithFormat:@"￥%.2f",totlePrice];
    self.totlePriceLabel.attributedText = [self PriceSetString:string];
}


- (void)verityAllSelectState {
    
    
    if (self.selectedArray.count == _dataSourceArray.count) {
        _allSellectedButton.selected = YES;
    } else {
        _allSellectedButton.selected = NO;
    }
}


- (NSMutableAttributedString*)PriceSetString:(NSString*)string {
    
    NSString *text = [NSString stringWithFormat:@"合计:%@",string];
    NSMutableAttributedString *DWQString = [[NSMutableAttributedString alloc]initWithString:text];
    NSRange rang = [text rangeOfString:@"合计:"];
    [DWQString addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:rang];
    [DWQString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:16] range:rang];
    return DWQString;
}

#pragma mark---------tableivewDelagate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 180;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataSourceArray.count;
    
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    OrderTableViewCell *cell = [OrderTableViewCell cellWithTableView: tableView];
    //    cell.titileLabel.text = @"名字测试测试测试测试测试";
    //    cell.priceLabel.text = @"1000";
    //    cell.mainImage.image = [UIImage imageNamed:@"3"];
    
    CartListModel *listModel = _dataSourceArray[indexPath.row];
    
    
    [cell cellSelectedWithBlock:^(BOOL select) {
        NSLog(@"skfjklasjflasdjfl");
        listModel.select = select;
        if (select) {
            [self.selectedArray addObject:listModel];
            [self productSelect:listModel.productId];
        } else {
            [self.selectedArray removeObject:listModel];
            [self productCancelSelect:listModel.productId];
        }
        
        [self verityAllSelectState];
        //        [self verityGroupSelectState:indexPath.section];
        //
        //   [self countPrice];
    }];
    
    [cell numberAddWithBlock:^(NSInteger number) {
        //NSLog(@"给我传过来的值：%ld",number);
        if ([self.selectedArray containsObject:listModel]) {
            //从已选中删除,重新计算价格
            [self.selectedArray removeObject:listModel];
            [self productCancelSelect:listModel.productId callBack:^(id responseObject) {
                [self verityAllSelectState];
                [self productNumberChange:listModel.productId andCount:number];
                
            }];
        }else{
            
            [self productNumberChange:listModel.productId andCount:number];
        }
        
    }];
    [cell numberCutWithBlock:^(NSInteger number) {
        if ([self.selectedArray containsObject:listModel]) {
            //从已选中删除,重新计算价格
            [self.selectedArray removeObject:listModel];
            //  [self productCancelSelect:listModel.productId];
            [self productCancelSelect:listModel.productId callBack:^(id responseObject) {
                [self verityAllSelectState];
                
                [self productNumberChange:listModel.productId andCount:number];
                
            }];
            
            
        }else{
            
            [self productNumberChange:listModel.productId andCount:number];
        }
    }];
    
    
    NSLog(@"jjjjjjjj%@",[NSString stringWithFormat:@"%@",listModel.productPrice]);
    
    [cell reloadDataWithModel:listModel];
    return cell;
}

- (void)productCancelSelect:(NSNumber *)productID callBack:(void(^)(id responseObject))callBack{
    NSDictionary *params = @{@"productId": productID};
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager POST:@"http://47.93.33.181:8080/cart/un_select.do" parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"ccccccccccc%@",responseObject);
        CartDataModel *data = [CartDataModel mj_objectWithKeyValues:responseObject[@"data"]];
        NSString *totalPrice = [NSString stringWithFormat:@"¥%@",data.cartTotalPrice];
        self.totlePriceLabel.attributedText = [self PriceSetString:totalPrice];
        callBack(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"移除失败");
    }];
    
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"确定要删除该商品?删除后无法恢复!" preferredStyle:1];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            CartListModel *model = _dataSourceArray[indexPath.row];
            NSDictionary *params = @{@"productIds": model.productId};
            
            AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
            [manager POST:@"http://47.93.33.181:8080/cart/delete_product.do" parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                NSLog(@"移除成功");
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                NSLog(@"移除失败");
            }];
            
            
            
            
            [_dataSourceArray removeObjectAtIndex:indexPath.row];
            //    删除
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            
            
            //判断删除的商品是否已选择
            if ([self.selectedArray containsObject:model]) {
                //从已选中删除,重新计算价格
                [self.selectedArray removeObject:model];
                [self countPrice];
            }
            
                        if (self.selectedArray.count == _dataSourceArray.count) {
                _allSellectedButton.selected = YES;
            } else {
                _allSellectedButton.selected = NO;
            }
            
            if (_dataSourceArray.count== 0) {
                _backgroundView.hidden = YES;
                [self changeView];
            }
            
            //如果删除的时候数据紊乱,可延迟0.5s刷新一下
            [self performSelector:@selector(reloadTable) withObject:nil afterDelay:0.5];
            
        }];
        
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        
        [alert addAction:okAction];
        [alert addAction:cancel];
        [self presentViewController:alert animated:YES completion:nil];
    }
    
}
- (void)reloadTable {
    [self.tableView reloadData];
}
-(void)viewWillAppear:(BOOL)animated
{
    [self loadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
