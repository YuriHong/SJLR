//
//  PersonController.m
//  毕业
//
//  Created by 吴添培的黑苹果 on 2017/11/2.
//  Copyright © 2017年 吴添培. All rights reserved.
//

#import "PersonController.h"
#import "PureLayout.h"
#import "saveService.h"
#import "loginViewController.h"
//#import "OrderBtnCell.h"
#import "PersonEditController.h"
//#import "CollectController.h"
#import "ShoppingCarController.h"
#import "AFNetworking.h"
#import "NetworkTool.h"
#import "PayViewController.h"
#import "AllOrderController.h"
#import "UerBaseModel.h"
#import "LBUerNetModel.h"
#import "ReceiverController.h"

#define kMyOrderCell @"myorderCellID"
#define korderBtnCell @"orderbtnCellID"
#define sfsafs @"sdfasdfdsaf"
#define HeadViewH 300

@interface PersonController ()<UITableViewDelegate,UITableViewDataSource>

@property (strong,nonatomic)UITableView *tableView;
@property(nonatomic,assign) CGFloat oriOffsetY;

@property(nonatomic,weak) NSLayoutConstraint *headTopCons ;

@property(nonatomic,weak) NSLayoutConstraint *headHeightCons ;

@property(nonatomic,weak) UILabel *titleLabel;

@property(nonatomic,strong) NSArray *nameArray1;
@property(nonatomic,strong) NSArray *nameArray2;
@property(nonatomic,strong) NSArray *nameArray3;
@property(nonatomic,strong) NSArray *imageArray1;
@property(nonatomic,strong) NSArray *imageArray2;

@property(nonatomic,strong) NSString *levelName;

@property(nonatomic,strong) NSNumber *scoring;
@property(nonatomic,strong) LBUerNetModel *netModel;
@property(nonatomic,strong) UIButton *nameBtn;

@end

@implementation PersonController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self UserData];
    NSLog(@"运行了吗");
    
}

- (void)UserData{
    if ([[saveService objectForKey:@"login"] isEqual:@"1"] ){
        NSString *urlString = [NetworkTool willConcatenationString:@"/user/get_user_info.do"];
        [[NetworkTool sharedInstance] requestWithURLString:urlString params:nil method:POST callBack:^(id data, bool isSuccess) {
            if (isSuccess) {
                UerBaseModel *baseModel = [UerBaseModel mj_objectWithKeyValues:data];
                if (baseModel.status.boolValue == 0) {
                    _netModel = [LBUerNetModel mj_objectWithKeyValues:baseModel.data];
                }else
                {
                    loginViewController *lc = [[loginViewController alloc]init];
                    [self.navigationController presentViewController:lc animated:YES completion:nil];
                }
            }
            
            [self setTableView];
            [self initUiData];
            [self setUpUI];
        }];
        
    }else
    {
        [self setTableView];
        [self initUiData];
        [self setUpUI];
        
    }
    
}

#pragma mark-------------UI----

-(void)setTableView{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    self.tableView.contentInset = UIEdgeInsetsMake(HeadViewH , 0, 0, 0);
    self.navigationItem.title = @"个人中心";
    [self setUpNavBtn];
    //    [self.tableView registerClass:[MyOrderCell class] forCellReuseIdentifier: kMyOrderCell];
    //    [self.tableView registerClass:[OrderBtnCell class] forCellReuseIdentifier: korderBtnCell];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:sfsafs];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    UIButton *footerButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 20, SCREENWIDTH-40 , 40)];;
    
    footerButton.layer.cornerRadius = 10;
    [footerButton setTitle:@"退出登录" forState:UIControlStateNormal];
    [footerButton addTarget:self action:@selector(footerBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [footerButton setBackgroundColor:[UIColor redColor]];
    if ([[saveService objectForKey:@"login"] isEqual:@"1"] ){
        _tableView.tableFooterView = footerButton;
        
    }
    
    
    [self.view addSubview:_tableView];
    
    _oriOffsetY = -(HeadViewH);
    
}

- (void)initUiData
{
    self.nameArray3 =@[@"全部订单",@"购物车"];
    self.imageArray2 =@[@"cat_btn.png",@"cart_btn",@"sfsdf"];
}

- (void)setUpUI
{
    UIView *headView = [[UIView alloc]init];
    headView.translatesAutoresizingMaskIntoConstraints = NO;
    headView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"heade_backimage1"]];
    
    [self.view addSubview:headView];
    //设置headView的约束高度
    
    _headHeightCons = [headView autoSetDimension:ALDimensionHeight toSize:HeadViewH];
    //    [headView autoSetDimension:ALDimensionHeight toSize:300];
    //设置headView的左距离
    
    [headView autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:0];
    
    //设置headView的上距离
    
    _headTopCons = [headView autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:0];
    
    //设置右边View的右边距
    
    [headView autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:0];
    
    
    
    //添加头像
    UIButton *iconImage = [[UIButton alloc]init];
    [iconImage setImage:[UIImage imageNamed:@"头3"] forState:UIControlStateNormal];
    iconImage.backgroundColor = [UIColor blackColor];
    iconImage.clipsToBounds=YES;
    iconImage.layer.cornerRadius = 50;
    [headView addSubview:iconImage];
    
    [iconImage autoSetDimensionsToSize:CGSizeMake(100, 100)];
    
    [iconImage autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:headView withOffset:-130];
    
    [iconImage autoAlignAxisToSuperviewAxis:ALAxisVertical];
    
    UIButton *nameBtn = [[UIButton alloc]init];
    
    
    nameBtn.backgroundColor = [UIColor clearColor];
    [headView addSubview:nameBtn];
    
    UIButton *sexBtn = [[UIButton alloc]init];
    
    sexBtn.backgroundColor = [UIColor clearColor];
    [headView addSubview:sexBtn];
    
    if ([[saveService objectForKey:@"login"] isEqual:@"1"]) {
        [nameBtn setTitle:_netModel.username forState:UIControlStateNormal];
        //[sexBtn setTitle:@"" forState:UIControlStateNormal];
    }
    else{
        [nameBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [nameBtn setTitle:@"未登录" forState:UIControlStateNormal];
        //[sexBtn setTitle:@"男" forState:UIControlStateNormal];
    }
    
    _nameBtn = nameBtn;
    
    [nameBtn autoSetDimensionsToSize:CGSizeMake(170, 30)];
    [nameBtn autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:iconImage withOffset:15];
    [nameBtn autoAlignAxisToSuperviewAxis:ALAxisVertical];
    
    [sexBtn autoSetDimensionsToSize:CGSizeMake(30, 30)];
    [sexBtn autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:iconImage withOffset:15];
    [sexBtn autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:nameBtn withOffset:5];
    
}


- (void)setUpNavBtn
{
    
    UIBarButtonItem *rightBtn = [[UIBarButtonItem alloc]initWithTitle:@"编辑" style:UIBarButtonItemStyleDone target:self action:@selector(editClick)];
    [rightBtn setTintColor:[UIColor whiteColor]];
    self.navigationItem.rightBarButtonItem = rightBtn;
    
}

//mark 退出登录按钮事件
- (void)footerBtnClick
{
    NSLog(@"点击了退出登录");
    [UIAlertController creatDoneAndCancerAlertControllerTitle:@"提示" withMessage:@"是否退出登录" target:self callBack:^(UIAlertAction * _Nonnull action) {
        NSString *urlString = [NetworkTool willConcatenationString:@"/user/logout.do"];
        [[NetworkTool sharedInstance] requestWithURLString:urlString params:nil method:POST callBack:^(id data, bool isSuccess) {
            if (isSuccess) {
                NSLog(@"返回信息：%@",data);
                [saveService setObject:@"" forKey:@"name"];
                [saveService setObject:@"" forKey:@"pwd"];
                [saveService setObject:@"0" forKey:@"login"];
                [[PersonInfo sharePersonInfo]cleanUserToken];
                self.tableView.tableFooterView = nil;
                [_nameBtn setTitle:@"未登录" forState:UIControlStateNormal];
                [_nameBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            }
            
            
        }];
        
    }];
    
}

//判断是否掉线
- (void)isLostOl:(void(^)(id responseObject))callBack
{
    AFHTTPSessionManager *mannager = [AFHTTPSessionManager manager];
    [mannager POST:@"http://47.93.33.181:8080/user/get_information.do" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSInteger status = [responseObject[@"status"] integerValue];
        if (status == 10) {
            loginViewController *login = [[loginViewController alloc] init];
            [self presentViewController:login animated:YES completion:nil];
            
        }else
        {
            callBack(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [UIAlertController creatAlertControllerTitle:@"提示" withMessage:@"网络出现错误" target:self];
    }];
    
}


- (void)editClick
{
    if ([[saveService objectForKey:@"login"] isEqual:@"1"]) {
        NSLog(@"点击了名字");
        [self isLostOl:^(id responseObject) {
            PersonEditController *qc = [[PersonEditController alloc]init];
            
            qc.model = _netModel;
            [self.navigationController pushViewController:qc animated:YES];
        }];
        
    }
    else{
        [UIAlertController creatDoneAndCancerAlertControllerTitle:@"用户未登录,请登录" withMessage:@"" target:self callBack:^(UIAlertAction * _Nonnull action) {
            if ([action.title isEqual:@"确定"]) {
                loginViewController *login = [[loginViewController alloc] init];
                [self presentViewController:login animated:YES completion:nil];
            }
        }];
    }
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    // 计算下tableView滚动了多少
    
    // 偏移量:tableView内容与可视范围的差值
    
    // 获取当前偏移量y值
    CGFloat curOffsetY = scrollView.contentOffset.y;
    //NSLog(@"%f",curOffsetY);
    // 计算偏移量的差值 == tableView滚动了多少
    // 获取当前滚动偏移量 - 最开始的偏移量(-244)
    CGFloat delta = curOffsetY - _oriOffsetY;
    
    // 计算下头部视图的高度
    CGFloat h = HeadViewH - delta;
    if (h < 64) {
        h = 64;
    }
    
    // 修改头部视图高度,有视觉差效果
    _headHeightCons.constant = h;
    
    
    
    
}

#pragma mark---------tableiView---delegate---

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 80;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.nameArray3.count;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:sfsafs];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = _nameArray3[indexPath.row];
    cell.imageView.image = [UIImage imageNamed:_imageArray2[indexPath.row]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([[saveService objectForKey:@"login"] isEqual:@"1"] ){
        if (indexPath.row == 0) {
            AllOrderController *bc = [[AllOrderController alloc]init];
            [self.navigationController pushViewController:bc animated:YES];
        }else
        {
            ShoppingCarController *ac = [[ShoppingCarController alloc]init];
            [self.navigationController pushViewController:ac animated:YES];
        }
        
    }
    else{
        [UIAlertController creatDoneAndCancerAlertControllerTitle:@"用户未登录,请登录" withMessage:@"" target:self callBack:^(UIAlertAction * _Nonnull action) {
            if ([action.title isEqual:@"确定"]) {
                loginViewController *login = [[loginViewController alloc] init];
                [self presentViewController:login animated:YES completion:nil];
            }
        }];
    }
    
}

-(void)viewDidAppear:(BOOL)animated
{
    [self viewDidLoad];
}

@end
