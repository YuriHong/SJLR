//
//  USOpenSourceListViewController.m
//  JKSQ
//
//  Created by YU on 2019/8/15.
//  Copyright © 2019 fengzifeng. All rights reserved.
//

#import "USOpenSourceListViewController.h"
#import "USOpenSourceTableViewCell.h"
#import "USOpenSourceModel.h"
#import "USWebViewViewController.h"

@interface USOpenSourceListViewController () <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topConstraint;
@property (strong, nonatomic) NSArray *dataSource;
@end

@implementation USOpenSourceListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"感谢第三方开源软件";
    self.hidesBottomBarWhenPushed = YES;
    [self setNavigationBackButtonDefault];
//    self.topConstraint.constant = ([[UIApplication sharedApplication]statusBarFrame].size.height == 44.0) ? 88 : 64;
    self.topConstraint.constant = 44;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerNib:[UINib nibWithNibName:@"USOpenSourceTableViewCell" bundle:nil] forCellReuseIdentifier:@"USOpenSourceTableViewCell"];
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
    [self requestData];
}

- (void)requestData {
    [[DrHttpManager defaultManager] getRequestToUrl:OpenSourceUrl params:nil complete:^(BOOL successed, HttpResponse *response) {
        if (successed) {
            NSLog(@"%@", response);
            NSArray *data = response.payload[@"data"];
            self.dataSource = [USOpenSourceModel objectArrayWithKeyValuesArray:data];
            [self.tableView reloadData];
        }
    }];
}

#pragma mark -- UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    USOpenSourceTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"USOpenSourceTableViewCell"];
    USOpenSourceModel *model = self.dataSource[indexPath.row];
    cell.title.text = model.title;
    cell.source.text = [NSString stringWithFormat:@"%@", model.url];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    USWebViewViewController *vc = [[USWebViewViewController alloc]init];
    USOpenSourceModel *model = self.dataSource[indexPath.row];
    vc.title = model.title;
    vc.url = model.url;
    [self.navigationController pushViewController:vc animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
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
