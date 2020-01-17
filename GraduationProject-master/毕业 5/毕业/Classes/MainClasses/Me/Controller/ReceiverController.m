//
//  ReceiverController.m
//  毕业
//
//  Created by 龙波 on 2017/11/11.
//  Copyright © 2017年 吴添培. All rights reserved.
//

#import "ReceiverController.h"
#import "ConsigneeTableCell.h"
#import "ShoppingListModel.h"
#import "AddReceiverController.h"
#import "ConfirmOrderController.h"
#import "UIImage+Image.h"
#define kconsigneetablecell @"consigneetableCellID"


@interface ReceiverController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong) UITableView *maiTableView;
@property(nonatomic,strong) NSMutableArray *dataReceiverList;


@end

@implementation ReceiverController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"收货地址";
    [self initData];
    [self setUpUi];
}

-(void)initData{
    _dataReceiverList = [[NSMutableArray alloc]init];
    [self loadData];
    
}


-(void)loadData
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager POST:@"http://47.93.33.181:8080/shipping/list.do" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"sfsaf%@",responseObject);
        NSDictionary *dict = responseObject[@"data"];
        NSArray *listArray = dict[@"list"];
        [_dataReceiverList removeAllObjects];
        for (int i = 0; i <listArray.count; i++) {
            ShoppingListModel *listModel = [ShoppingListModel mj_objectWithKeyValues:listArray[i]];
            [_dataReceiverList addObject:listModel];
        }
        _dataReceiverList = (NSMutableArray *)[[_dataReceiverList reverseObjectEnumerator]allObjects];
        [self.maiTableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"网络有问题");
    }];
    
}


-(void)setUpUi
{
    [self setUpRightBtn];
    _maiTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT - 70) style:UITableViewStylePlain];
    _maiTableView.delegate = self;
    _maiTableView.dataSource = self;
    [_maiTableView registerClass:[ConsigneeTableCell class] forCellReuseIdentifier: kconsigneetablecell];
    [self.view addSubview:_maiTableView];
    
    
}

-(void)setUpRightBtn
{
    UIBarButtonItem *rightBtn = [[UIBarButtonItem alloc]initWithTitle:@"添加" style:UIBarButtonItemStyleDone target:self action:@selector(addReceiver)];
    self.navigationItem.rightBarButtonItem = rightBtn;
    
    
   self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageWithOriginalImageName:@"navback"] style: UIBarButtonItemStylePlain target:self action:@selector(back)];
    
}

- (void)addReceiver{
    AddReceiverController *ac = [[AddReceiverController alloc]init];
    [self.navigationController pushViewController:ac animated:YES];
}

- (void)back
{
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        [manager POST:@"http://47.93.33.181:8080/cart/un_select_all.do" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            [self.navigationController popViewControllerAnimated:YES];
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"移除失败");
        }];
        
    
}

#pragma mark ----------tableview---delegate

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataReceiverList.count;
    
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 150;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ConsigneeTableCell *cell = [ConsigneeTableCell cellWithTableView: tableView];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    ShoppingListModel *model = _dataReceiverList[indexPath.row];
    [cell reloadDataWithModel:model];
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ShoppingListModel *model = _dataReceiverList[indexPath.row];
    ConfirmOrderController *cc = [[ConfirmOrderController alloc]init];
    cc.getListModel = model;
    [self.navigationController pushViewController:cc animated:YES];
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"确定要删除该收货地址?删除后无法恢复!" preferredStyle:1];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            ShoppingListModel *model = _dataReceiverList[indexPath.row];
            NSDictionary *params = @{@"shippingId": model.id};
            
            AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
            [manager POST:@"http://47.93.33.181:8080/shipping/del.do" parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                NSLog(@"移除成功");
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                NSLog(@"移除失败");
            }];
            
            
            
            
            [_dataReceiverList removeObjectAtIndex:indexPath.row];
            //    删除
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            
            
            
            
            
            if (_dataReceiverList == 0) {
                NSLog(@"没有数据了，没有数据了");
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
- (void)reloadTable
{
    [self.maiTableView reloadData];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    [self loadData];
}


@end

