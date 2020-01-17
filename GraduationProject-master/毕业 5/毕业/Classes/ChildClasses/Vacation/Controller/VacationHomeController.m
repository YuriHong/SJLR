//
//  VacationHomeController.m
//  毕业
//
//  Created by 龙波 on 2017/10/11.
//  Copyright © 2017年 吴添培. All rights reserved.
//

#import "VacationHomeController.h"
#import "VacationHomeCell.h"
#import "HotViewCell.h"
#import "HotCollectionView.h"
#import "TitleViewCell.h"
#import "VacationListViewCell.h"
#import "LikeViewCell.h"
#import "VacationListModel.h"
#import "VacationClassController.h"
#import "NSMutableArray+Extension.h"
#import "VacationClassController.h"
#import "DetailVacationController.h"

#define kVacationHomeCell @"VacationHomeCellID"
#define kHotViewCell @"hotviewCellID"
#define kTitleViewCell @"titleviewCellID"
#define kVacationListViewCell @"vacationlistviewCellID"
#define kLikeViewCell @"likeviewCellID"

@interface VacationHomeController ()<UITableViewDelegate,UITableViewDataSource,VacationHomeCellDelegate>
@property(nonatomic,strong) UITableView *mainTableView;
@property(nonatomic,strong) NSArray *menuArray;
@property(nonatomic,strong) NSMutableArray *dataSourceData;
@property(nonatomic,strong) NSMutableArray *dataHotData;
@property(nonatomic,strong) NSMutableArray *imageUrlarray;
@property(nonatomic,strong) NSMutableArray *productIdArray;
@end

@implementation VacationHomeController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self initmenuBtnData];
    [self setUpNav];
    [self initData];
    [self loadData];
}

-(void)setUpNav{
    self.navigationItem.title =@"旅游";
}

- (void)initData
{
    _dataSourceData = [[NSMutableArray alloc]init];
    _dataHotData = [[NSMutableArray alloc]init];
    _imageUrlarray = [[NSMutableArray alloc]init];
    _productIdArray = [[NSMutableArray alloc]init];
}

- (void)loadData
{
    NSDictionary *params = @{@"categoryId": @"200000",
                             @"pageSize":@"15"
                             };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager POST:@"http://47.93.33.181:8080/product/list.do" parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
       // NSLog(@"ccccccccreat-----%@",responseObject);
        NSMutableDictionary *dict = responseObject[@"data"];
        NSMutableArray *listArray = dict[@"list"];
        [_dataSourceData removeAllObjects];
        NSArray *araa = @[@"2",@"5",@"6",@"7",@"9",@"10",@"12"];
        for (int i = 0; i<listArray.count; i++) {
            VacationListModel *listModel = [VacationListModel mj_objectWithKeyValues:listArray[i]];
            [_dataSourceData addObject:listModel];
            
        }
        
        for (int i = 0; i<araa.count; i ++) {
            NSInteger index = [araa[i] integerValue];
            VacationListModel *listModle = [VacationListModel mj_objectWithKeyValues:listArray[index]];
            [_dataHotData addObject:listModle];
        }
        
        [self setUpTableView];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"申请失败");
    }];

}



- (void)initmenuBtnData{
    self.menuArray = [NSMutableArray arrayWithPlistFileResource:@"menuData"];
}

-(void)setUpTableView
{
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT - 120)];
  
    [tableView registerClass:[HotViewCell class] forCellReuseIdentifier: kHotViewCell];
    [tableView registerClass:[TitleViewCell class] forCellReuseIdentifier: kTitleViewCell];
    [tableView registerClass:[VacationListViewCell class] forCellReuseIdentifier: kVacationListViewCell];
    [tableView registerClass:[LikeViewCell class] forCellReuseIdentifier: kLikeViewCell];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.mainTableView = tableView;
    
    UIButton *footerButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 10, SCREENWIDTH , 40)];;

    footerButton.layer.cornerRadius = 10;
    [footerButton setTitle:@"查看全部周边游" forState:UIControlStateNormal];
    [footerButton addTarget:self action:@selector(footerBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [footerButton setBackgroundColor:[UIColor brownColor]];
    tableView.tableFooterView = footerButton;
    [self.view addSubview:tableView];
}

- (void)homeMenuCellClick:(long)sender
{
    VacationClassController *classC = [[VacationClassController alloc]init];
    classC.titleStr = self.menuArray[sender -10][@"title"];
    [self.navigationController pushViewController:classC animated:YES];
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    CGFloat sectionHeaderHeight = 9;//设置你footer高度
    if (scrollView.contentOffset.y<=sectionHeaderHeight&&scrollView.contentOffset.y>=0) {
        scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
    } else if (scrollView.contentOffset.y>=sectionHeaderHeight) {
        scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 9;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 180;

    }else if (indexPath.section == 1)
    {
        if (indexPath.row == 0) {
            return 35;
        }
        return 119;
    }else
    {
        if (indexPath.row == 0) {
            return 35;
        }
        return 127;
    }
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 1) {
        return 2;
    }else if (section == 0)
    {
        return 1;
    }else
    {
        return _dataSourceData.count;
    }
  
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        VacationHomeCell *cell = [VacationHomeCell cellWithTableView:tableView menuArray:self.menuArray];
        
        cell.delegate = self;
        return cell;
    }
    
    else if (indexPath.section == 1)
    {
        if (indexPath.row == 0) {
            TitleViewCell *cell = [TitleViewCell cellwithTableView:tableView];
            return cell;
        }
        [_imageUrlarray removeAllObjects];
        [_productIdArray removeAllObjects];
        for (int i = 0; i < _dataHotData.count; i++) {
            VacationListModel *listmodel =[VacationListModel mj_objectWithKeyValues:_dataHotData[i]];
            [_imageUrlarray addObject:listmodel.mainImage];
            [_productIdArray addObject:listmodel.id];
        }

        HotViewCell *cell = [HotViewCell cellWithTableView:tableView];
        HotCollectionView *hotCollectionView = [[HotCollectionView alloc]initWithFrame:CGRectMake(0, 0,414,119)collectionViewItemSize:CGSizeMake(109, 109) withImageArr:_imageUrlarray WithProductIdArray:_productIdArray];
        
        [hotCollectionView setBlock:^(NSString *productId){
            [self passTwoControllor:productId];
        }];
    
        hotCollectionView.backgroundColor = [UIColor whiteColor];
        
        [cell.contentView addSubview:hotCollectionView];

      
        return cell;
    }
    
    else
    {
        if (indexPath.row == 0) {
            LikeViewCell *cell = [LikeViewCell cellwithTableView:tableView];
            return cell;
        }
        VacationListViewCell *cell = [VacationListViewCell cellWithTableView:tableView];
        VacationListModel *listModel = _dataSourceData[indexPath.row];
        [cell reloadDataWithModel:listModel];
        return cell;
    }
}

- (void)passTwoControllor:(NSString *)productId
{
    DetailVacationController *detail = [[DetailVacationController alloc] init];
    detail.productID = productId;
    [self.navigationController pushViewController:detail animated:YES];

}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 2) {
        DetailVacationController *detail = [[DetailVacationController alloc] init];
        VacationListModel *model = _dataSourceData[indexPath.row];
        detail.productID = model.id;
        [self.navigationController pushViewController:detail animated:YES];
    };
}


- (void)footerBtnClick
{
    VacationClassController *qc = [[VacationClassController alloc]init];
    qc.titleStr= @"";
    [self.navigationController pushViewController:qc animated:YES];
    //NSLog(@"点击了全部周边游");
}


@end
