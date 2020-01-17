//
//  MassTextController.m
//  毕业设计
//
//  Created by 龙波 on 2017/9/7.
//  Copyright © 2017年 吴添培. All rights reserved.
//

#import "MassTextController.h"
#import "MassTableViewCell.h"
#import "MassPersonCell.h"
#import "MassMainModel.h"
#import "MassAcidityTextController.h"

#define kmasstabeleCell @"masstableCellID"
#define kmasspersonCell @"masspersonCelID"
@interface MassTextController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong) NSArray *getArray;
@property(nonatomic,strong) NSMutableArray *dataListSrouce;
@property(nonatomic,strong) UITableView *myTableView;

@end

@implementation MassTextController


-(instancetype)initWithFrame:(CGRect)frame WithArray:(NSArray *)array
{
    if (self = [super init]) {
        self.view.frame = frame;
        [self initData];
        self.view.backgroundColor = [UIColor whiteColor];
       // self.getArray = [NSArray arrayWithObject:array];
      // NSLog(@"传过来了数组个数%@",self.getArray,self.getArray.count);
        
        self.navigationItem.title = array[1];
        
        UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 200)];
        headView.backgroundColor = RandColor;
        
        UIImageView *backImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 198)];
        backImage.image = [UIImage imageNamed:@"mass_acidity_back"];
        [headView addSubview:backImage];
       // [self.view addSubview:headView];
        
        UIImageView *iconView = [[UIImageView alloc]init];
        iconView.image = [UIImage imageNamed:array[2]];
        iconView.backgroundColor = RandColor;
        iconView.layer.masksToBounds =YES;
        iconView.layer.cornerRadius = 65/2;
        iconView.centerX = backImage.centerX-35;
        iconView.centerY = backImage.centerY -75;
        iconView.height = 65;
        iconView.width = 65;
        [backImage addSubview:iconView];
        
        UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT -70)];
        tableView.delegate = self;
        tableView.dataSource = self;
        
        [tableView registerClass:[MassPersonCell class] forCellReuseIdentifier: kmasspersonCell];
        [tableView registerClass:[MassTableViewCell class] forCellReuseIdentifier: kmasstabeleCell];
        
        tableView.tableHeaderView = headView;
        [self loadData:array[0]];
        _myTableView = tableView;
        [self.view addSubview:tableView];
        
        
        
    }
    return  self;
}

- (void)initData{
    _dataListSrouce = [[NSMutableArray alloc]init];
}

- (void)loadData:(NSString *)categoryId
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSDictionary *request = @{
                              @"categoryId":categoryId,
                              };
    NSString *urlString = [NetworkTool willConcatenationString:@"/product/list.do"];
    [manager POST:urlString parameters:request progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@",responseObject);
        NSMutableDictionary *dict = responseObject[@"data"];
        NSMutableArray *listArray = dict[@"list"];
        [_dataListSrouce removeAllObjects];
        for (int i = 0; i <listArray.count; i ++) {
            MassMainModel *model = [MassMainModel mj_objectWithKeyValues:listArray[i]];
            [_dataListSrouce addObject:model];
        }

        [self.myTableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
        return _dataListSrouce.count;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
        return 150;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath  
{
    
    MassTableViewCell *cell = [MassTableViewCell cellWithTabelView:tableView];
        MassMainModel *listModel = [MassMainModel mj_objectWithKeyValues:_dataListSrouce[indexPath.row]];
        [cell reloadDataWithModel:listModel];
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MassAcidityTextController *tc = [[MassAcidityTextController alloc]init];
    MassMainModel *listModle = [MassMainModel mj_objectWithKeyValues:_dataListSrouce[indexPath.row]];
    
    tc.productID =listModle.id;
    [self.navigationController pushViewController:tc animated:YES];
    
}



@end
