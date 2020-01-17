//
//  VacationClassController.m
//  毕业
//
//  Created by 龙波 on 2017/10/15.
//  Copyright © 2017年 吴添培. All rights reserved.
//

#import "VacationClassController.h"
#import "VacationListViewCell.h"
#import "ClassFilterView.h"
#import "VacationListModel.h"
#import "PriceClassView.h"
#import "DetailVacationController.h"
#define kVacationListViewCell @"vacationlistviewCellID"

@interface VacationClassController ()<UITableViewDelegate,UITableViewDataSource,UIGestureRecognizerDelegate,ClassFilterViewDelegate,PriceClassViewDelegate>
{
    UIView *_maskView;
    UIView *_priceView;
}
@property (nonatomic, strong)UIImageView *imageView;
@property(nonatomic,strong) UITableView *myTableView;

//@property(nonatomic,strong) UIView *maskView;
@property(nonatomic,strong) NSString *keyWord;
@property(nonatomic,strong) NSMutableArray *listDataSource;
@property(nonatomic,assign) NSInteger pageNum;
@property(nonatomic,strong) NSString *categoryId;
@property(nonatomic,strong) NSString *orderBy;

@end

@implementation VacationClassController

- (void)viewDidLoad {
    [super viewDidLoad];
    //NSLog(@"%@",self.titleStr);
    self.view.backgroundColor = [UIColor whiteColor];
    [self inidata];
    [self loadData];
    [self initView];
    [self initMaskView];
    [self initPriceView];
    
}

- (void)inidata{
    _categoryId = @"200000";
    if ( [_titleStr isEqualToString:@"全部"]) {
        self.keyWord = @"";
    }else if ([_titleStr isEqualToString:@"展馆展览"])
    {

        self.keyWord = @"馆";
    }else if([_titleStr isEqualToString:@"自然风光"])
    {

        self.keyWord = @"区";
    }else if ([_titleStr isEqualToString:@"动植物园"])
    {
        self.keyWord = @"";
        _categoryId = @"200001";

    }else if ([_titleStr isEqualToString:@"名胜古迹"])
    {
        self.keyWord = @"古";
    }else if([_titleStr isEqualToString:@"景点／门票"])
    {
        self.keyWord = @"景区";
    }else if ([_titleStr isEqualToString:@"公园游乐场"])
    {
        self.keyWord = @"园";
    }else if([_titleStr isEqualToString:@"景+酒"])
    {
        self.keyWord = @"";
        _categoryId = @"200002";

    }
    else
    {
        self.keyWord = _titleStr;
    }
    _pageNum = 1;
    _orderBy = @"";
    _listDataSource = [[NSMutableArray alloc]init];
}

- (void)loadData{
    NSString *pageNumStr = [NSString stringWithFormat:@"%ld",_pageNum];;
    NSDictionary *params = @{@"categoryId": _categoryId,
                             @"keyword":_keyWord,
                             @"pageNum":pageNumStr,
                             @"orderBy":_orderBy
                             };
    //NSLog(@"pppppppp:%@",params);
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager POST:@"http://47.93.33.181:8080/product/list.do" parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //NSLog(@"ccccccccreat-----%@",responseObject);
        NSMutableDictionary *dict = responseObject[@"data"];
        NSMutableArray *listArray = dict[@"list"];
        if (_pageNum == 1) {
            [_listDataSource removeAllObjects];
            
        }
        for (int i = 0 ; i<listArray.count; i++) {
            VacationListModel *listaModel = [VacationListModel mj_objectWithKeyValues:listArray[i]];
            [_listDataSource addObject:listaModel];
        }
        [self.myTableView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
       NSLog(@"申请失败%@",error);
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

- (void)initView
{
    UIView *filterView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 40)];
    filterView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:filterView];
    
    NSArray *filterName = @[@"全部分类",@"价格排序"];
    
    for (int i =0; i<2; i++) {
        UIButton *filterBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        filterBtn.frame = CGRectMake(i*SCREENWIDTH/2, 0, SCREENWIDTH/2-15, 40);
        filterBtn.tag = 100+i;
        filterBtn.titleLabel.font = [UIFont systemFontOfSize:13];
        [filterBtn setTitle:filterName[i] forState:UIControlStateNormal];
        [filterBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [filterBtn setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        [filterBtn addTarget:self action:@selector(filterBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [filterView addSubview:filterBtn];
        
        //三角
        UIButton *triangleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        triangleBtn.frame = CGRectMake((i+1)*SCREENWIDTH/2-15, 16, 8, 7);
        triangleBtn.tag = 120+i;
        [triangleBtn setImage:[UIImage imageNamed:@"标签-向下箭头"] forState:UIControlStateNormal];
        [triangleBtn setImage:[UIImage imageNamed:@"标签-向上箭头"] forState:UIControlStateSelected];
        [filterView addSubview:triangleBtn];

        
    }
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 39.5, SCREENWIDTH, 0.5)];
    lineView.backgroundColor = RGBColor(192, 192, 192);
    [filterView addSubview:lineView];
    
    
    UITableView *merchantTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 40, SCREENWIDTH, SCREENHEIGHT-64) style:UITableViewStylePlain];
    [merchantTableView registerClass:[VacationListViewCell class] forCellReuseIdentifier: kVacationListViewCell];
    merchantTableView.dataSource = self;
    merchantTableView.delegate = self;
    
    NSMutableArray *refreshingImages = [NSMutableArray array];
    for (NSInteger i = 1; i<=3; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"dropdown_loading_0%zd",i]];
        [refreshingImages addObject:image];
    }
    
 
    MJRefreshAutoGifFooter *footer = [MJRefreshAutoGifFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    [footer setImages:refreshingImages forState:MJRefreshStateRefreshing];
    [footer setTitle:@"数据正在加载中 ..." forState:MJRefreshStateRefreshing];
    
    merchantTableView.mj_footer = footer;
    self.myTableView = merchantTableView;
    [self.view addSubview:merchantTableView];
    
    self.imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT)];
    self.imageView.image = [UIImage imageNamed:@"Default"];
    self.imageView.hidden = YES;
    [self.view addSubview:self.imageView];
    
}

- (void)initMaskView
{
    _maskView = [[UIView alloc]initWithFrame:CGRectMake(0, 40, SCREENWIDTH, SCREENHEIGHT - 150)];
    _maskView.backgroundColor = RGBAColor(0, 0, 0, 0.5);
    _maskView.hidden = YES;
    [self.view addSubview:_maskView];
    
    //添加手势
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(OnTapMaskView:)];
    tap.delegate = self;
    [_maskView addGestureRecognizer:tap];
    
    ClassFilterView *filterView =  [[ClassFilterView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT- 250)];
    filterView.backgroundColor =RandColor;
    filterView.delegate = self;
    [_maskView addSubview:filterView];
    
}

-(void)initPriceView
{
    _priceView = [[UIView alloc]initWithFrame:CGRectMake(0, 40, SCREENWIDTH, SCREENHEIGHT - 150)];
    _priceView.backgroundColor = RGBAColor(0, 0, 0, 0.5);
    _priceView.hidden = YES;
    [self.view addSubview:_priceView];
    
    //添加手势
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(OnTapPriceView:)];
    tap.delegate = self;
    [_priceView addGestureRecognizer:tap];
    
    PriceClassView *priceView = [[PriceClassView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENWIDTH - 300)];
    priceView.delegate = self;
    [_priceView addSubview:priceView];
}

- (void)OnTapPriceView:(UITapGestureRecognizer *)sender
{
    
    _maskView.hidden = YES;
    _priceView.hidden = YES;
    
}


- (void)OnTapMaskView:(UITapGestureRecognizer *)sender
{
   
    _priceView.hidden = YES;
        _maskView.hidden = YES;
}

-(void)filterBtnClick:(UIButton *)sender
{
    for (int i = 0; i < 2; i++) {
        UIButton *menubtn = (UIButton *)[self.view viewWithTag:100+i];
        UIButton *arrowBtn = (UIButton *)[self.view viewWithTag:120+i];
        menubtn.selected = NO;
        arrowBtn.selected = NO;
    }
    sender.selected = YES;
    UIButton *sjBtn = (UIButton *)[self.view viewWithTag:sender.tag+20];
    sjBtn.selected = YES;
    if (sender.tag == 100) {
        _maskView.hidden = NO;

    }else{
    _priceView.hidden = NO;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPat
{
    return  119;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _listDataSource.count;
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    VacationListViewCell *cell = [VacationListViewCell cellWithTableView:tableView];
    VacationListModel *listModel = [VacationListModel mj_objectWithKeyValues:_listDataSource[indexPath.row]];
    [cell reloadDataWithModel:listModel];
    return cell;
}

//MARK: - 跳转
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    DetailVacationController *detail = [[DetailVacationController alloc] init];
    VacationListModel *model = _listDataSource[indexPath.row];
    detail.productID = model.id;
    [self.navigationController pushViewController:detail animated:YES];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath withWord:(NSString *)Word
{
    if ([Word isEqual:@"价格升序"]) {
        _orderBy = @"price_asc";
    }
    else if ([Word isEqual:@"价格降序"]){
        _orderBy = @"price_desc";
    }
    _pageNum = 1;
    _priceView.hidden = YES;
    [self loadData];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath withKeyWord:(NSString *)keyWord
{
   // NSLog(@"%@",keyWord);
    if ( [keyWord isEqualToString:@"全部"]) {
        self.keyWord = @"";
        _pageNum = 1;
    }else if ([keyWord isEqualToString:@"其他展馆展览"])
    {        _pageNum = 1;

        self.keyWord = @"馆";
    }else if([keyWord isEqualToString:@"自然风光"])
    {        _pageNum = 1;

        self.keyWord = @"景区";
    }else if ([keyWord isEqualToString:@"海洋馆"])
    {        _pageNum = 1;

        self.keyWord = @"海洋";
    }else if ([keyWord isEqualToString:@"植物园"])
    {        _pageNum = 1;

        self.keyWord = @"植物";
    }else
    {
    self.keyWord = keyWord;
        _pageNum = 1;

    }
    _categoryId = @"200000";
    _maskView.hidden = YES;
    [self loadData];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    if ([touch.view isKindOfClass:[UITableView class]]) {
        return NO;
    }
    if ([touch.view.superview isKindOfClass:[UITableView class]]) {
        return NO;
    }
    if ([touch.view.superview.superview isKindOfClass:[UITableView class]]) {
        return NO;
    }
    if ([touch.view.superview.superview.superview isKindOfClass:[UITableView class]]) {
        
        return NO;
    }
    
    return YES;
    
}


@end
