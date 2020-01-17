//
//  MassViewController.m
//  毕业设计
//
//  Created by 龙波 on 2017/8/16.
//  Copyright © 2017年 吴添培. All rights reserved.
//

#import "MassViewController.h"
#import "PureLayout.h"
#import "MassProductListCell.h"
#import "MassNameViewController.h"
#import "TitleCell.h"
#import "NoticCell.h"
#import "BtnCell.h"
#import "MassPersonController.h"
#import "LBUerNetModel.h"
#import "MassActivityController.h"
#import "UIImage+Image.h"
#import "MassMainModel.h"
#import "MassPersonController.h"
#define headH 65

#define knoticCell @"noticeCellID"
#define ktitleCell @"titleCellID"
#define kbtnCell   @"btnCellID"
#define kmassproductCell @"massproductCellID"
@interface MassViewController ()<UITableViewDelegate,UITableViewDataSource,BtnCellDelegate>

@property(nonatomic,strong) NSMutableArray *massArray;//社团信息源
@property(nonatomic,strong) NSMutableArray *NoticeArray;//公告信息源
@property(nonatomic,strong) UITableView *tableView;
@property(nonatomic,assign) NSInteger pageNum;


@end

@implementation MassViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor grayColor];
    [self initData];
    [self setupNav];
    [self loadMassData];
    [self setuptableview];
    
    
}

-(BOOL)isUserLogin
{
   // NSString *userId =[NSString stringWithFormat:@"%@",[[PersonInfo sharePersonInfo]getLoginUserId]];
    //NSLog(@"uerID是什么%zd",[LBUerNetModel getLoginUserModel].id);
    NSLog(@"uerID是什么%zd",[[PersonInfo sharePersonInfo]getLoginUserId].intValue);

    if ([[PersonInfo sharePersonInfo]getLoginUserId].intValue > 0)
    {
        //已经登录
        return YES;
    }
    return NO;
}

- (void)setupNav
{
    self.navigationItem.title = @"社团";
}

- (void)initData{
    _massArray = [[NSMutableArray alloc]init];
    _pageNum = 1;
}

- (void)loadMassData{
    //1.请求数据路径
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSString *pageNumStr = [NSString stringWithFormat:@"%ld",_pageNum];
    NSDictionary *request = @{
                              @"categoryId":@"400001",
                              @"pageNum":pageNumStr
                              };
    NSString *urlString = [NetworkTool willConcatenationString:@"/product/list.do"];
    [manager POST:urlString parameters:request progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@",responseObject);
        NSDictionary *dict = responseObject[@"data"];
        NSMutableArray *listArray = dict[@"list"];
        if (_pageNum == 1) {
            [_massArray removeAllObjects];

        }
        for (int i = 0; i < listArray.count; i ++) {
            MassMainModel *listModel = [MassMainModel mj_objectWithKeyValues:listArray[i]];
            [_massArray addObject:listModel];
        }
        
        [self.tableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
    
    
    
}



- (void)btn2Click
{
    NSLog(@"所有社团");
    MassNameViewController *massName = [[MassNameViewController alloc]init];
    [self.navigationController pushViewController:massName animated:YES];
}

- (void)setuptableview
{
    
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,-65, SCREENWIDTH, SCREENHEIGHT)];
    tableView.delegate = self;
    tableView.dataSource = self;
    [tableView registerClass:[NoticCell class] forCellReuseIdentifier: knoticCell];
    [tableView registerClass:[MassProductListCell class] forCellReuseIdentifier: kmassproductCell];
    [tableView registerClass:[TitleCell class] forCellReuseIdentifier: ktitleCell];
    [tableView registerClass:[BtnCell class] forCellReuseIdentifier: kbtnCell];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;


    self.tableView = tableView;
    
    /*
    
    MJRefreshGifHeader *header = [MJRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    
    // 设置普通状态的动画图片
    NSArray *idleImages = @[@"头3", @"AppIcon-1", @"u=2082200720,3833509299&fm=26&gp=0"];
    [header setImages:idleImages forState:MJRefreshStateIdle];
    
    // 设置即将刷新状态的动画图片（一松开就会刷新的状态）
    NSArray *pullingImages = @[@"头3", @"AppIcon-1", @"u=2082200720,3833509299&fm=26&gp=0"];
    [header setImages:pullingImages forState:MJRefreshStatePulling];
    
    // 设置正在刷新状态的动画图片
    NSArray *refreshingImages = @[@"头3", @"AppIcon-1", @"u=2082200720,3833509299&fm=26&gp=0"];
    [header setImages:refreshingImages forState:MJRefreshStateRefreshing];
    // 设置 header
    tableView.mj_header = header;
    */
    
    
    tableView.contentInset = UIEdgeInsetsMake(65, 0, 0, 0);
        [self.view addSubview:tableView];
    
}


- (void)didSelectAtIndexBtnCell:(NSInteger)toIndex
{
    //NSLog(@"%ld",(long)toIndex);
    if (toIndex == 233) {
       // NSLog(@"点击来我的社团");
    
        if ([self isUserLogin] == YES ) {
            MassPersonController *personMass = [[MassPersonController alloc]init];
            [self.navigationController pushViewController:personMass animated:YES];

        }else
        {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"登陆失败" message:@"请您登录" preferredStyle:  UIAlertControllerStyleAlert];
            
            [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                //点击按钮的响应事件；
            }]];
            
            //弹出提示框；
            [self presentViewController:alert animated:true completion:nil];
           

        }
        
     
      //  MassPersonController *personMass = [[MassPersonController alloc]init];
      //  [self.navigationController pushViewController:personMass animated:YES];
        

        
    }else if(toIndex == 2333)
    {
        MassNameViewController *massName = [[MassNameViewController alloc]init];
        [self.navigationController pushViewController:massName animated:YES];
    }else
    {
//        [[PersonInfo sharePersonInfo]cleanUserToken];
        MassActivityController *massActivity = [[MassActivityController alloc]init];
        [self.navigationController pushViewController:massActivity animated:YES];
        NSLog(@"点击了社团活动");
    }
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            return 40;
        }else{
            return 110;
        }
    }  else if (indexPath.section == 1){
        return 80;
    }else
    {
        return 127;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 9;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 2;
    }else if (section == 1)
    {
        return 1;
    }
    return _massArray.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            TitleCell *cell = [TitleCell cellwithTableView: tableView];
            
            return cell;
        }else
        {
            NoticCell *cell = [NoticCell cellWithTabelView: tableView];
            return cell;
        }
    }else if (indexPath.section == 1)
    {
        BtnCell *cell = [BtnCell cellWithTableView: tableView];
        cell.delegate = self;
        return cell;
    }
    else
    {
        MassProductListCell *cell = [MassProductListCell cellWithTableView: tableView];
        MassMainModel *dataModel = _massArray[indexPath.row];
        [cell reloadDataWithModel:dataModel];
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 2) {
        MassPersonController *mc = [[MassPersonController alloc]init];
        MassMainModel *dataModel = _massArray[indexPath.row];
        mc.productID = dataModel.id;
        [self.navigationController pushViewController:mc animated:YES];

    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
