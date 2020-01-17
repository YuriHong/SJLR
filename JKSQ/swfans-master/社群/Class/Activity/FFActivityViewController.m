//
//  FFActivityViewController.m
//  FZFBase
//
//  Created by fengzifeng on 2017/8/16.
//  Copyright © 2017年 fengzifeng. All rights reserved.
//

#import "FFActivityViewController.h"
#import "FFActivityListCell.h"
#import "FFActivityModel.h"
#import "FFPostDetailViewController.h"


@interface FFActivityViewController ()

@property (nonatomic, assign) NSInteger page;
@property (nonatomic, strong) NSMutableArray *dataArray;
    @property (weak, nonatomic) IBOutlet NSLayoutConstraint *topConstraint;
    
@end

@implementation FFActivityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSNumber *flag = [userDefaults objectForKey:@"jiluapp"];
    _tableView.backgroundColor = RGBCOLOR(242, 244, 247);
    self.view.backgroundColor = RGBCOLOR(242, 244, 247);
    self.topConstraint.constant = ([UIApplication sharedApplication].statusBarFrame.size.height == 44) ? 88 : 64;
    if ([flag integerValue] == 0) {
        __weak typeof(self) weakSelf = self;
        MJRefreshNormalHeader *refreshHeader = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [weakSelf requestData];
        }];
        self.tableView.mj_header = refreshHeader;
    
        [self.tableView.mj_header beginRefreshing];
    } else {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        UIImage *image = [UIImage imageNamed:@"200123768.jpg"];
        [button setImage:image forState:UIControlStateNormal];
        [button addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
        button.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH*image.size.height/image.size.width);
        _tableView.tableHeaderView = button;
    }
}

- (void)click
{
//    USSafariViewController *vc = [USSafariViewController initWithTitle:@"使用协议" url:@"assets.solidworks.com.cn/html/turntable"];
//    
//    [self.navigationController pushViewController:vc animated:YES];
}

//-(void)headerRereshing{
//    [self requestData];
//}

- (void)requestData
{
    NSString *requestUrl = [NSString stringWithFormat:@"%@%@",url_articles,@(_page)];
    [[DrHttpManager defaultManager] getRequestToUrl:requestUrl params:nil complete:^(BOOL successed, HttpResponse *response) {
        if (successed) {
            FFActivityModel *model = [FFActivityModel objectWithKeyValues:response.payload];
            _dataArray = [model.data mutableCopy];
            [_tableView reloadData];
        }
        
        [self.tableView.mj_header endRefreshing];

    }];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.parentViewController setNavigationTitleView:nil];
    self.parentViewController.title = @"活动";
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"FFActivityListCell";
    FFActivityListCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:cellID owner:self options:nil].lastObject;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    FFActivityItemModel *model = _dataArray[indexPath.row];
    [cell updateCell:model];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    FFPostDetailViewController *vc = [FFPostDetailViewController viewController];
    FFActivityItemModel *model = _dataArray[indexPath.row];
    vc.postId = model.tid;
    
    [self.navigationController pushViewController:vc animated:YES];
    
    
   


    
}

@end
