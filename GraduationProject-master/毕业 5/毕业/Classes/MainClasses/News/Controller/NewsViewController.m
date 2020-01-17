//
//  NewsViewController.m
//  毕业设计
//
//  Created by 吴添培的黑苹果 on 2017/9/18.
//  Copyright © 2017年 吴添培. All rights reserved.
//

#import "NewsViewController.h"
#import "NewsCell.h"
#import "DetailNewsViewController.h"
#import "DetailNewsModel.h"

static NSString * identify = @"NewsCellID";
@interface NewsViewController ()
@property(nonatomic,strong)NSArray *array;

@end

@implementation NewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNavigationBar];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"NewsCell" bundle:nil] forCellReuseIdentifier:identify];
}

-(void)setupNavigationBar{
    self.navigationItem.title = @"新闻资讯";
}

-(NSArray *)array{
    if (_array == nil) {
        _array = [DetailNewsModel getDetailNewsModelArray];
    }
    return _array;
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.array.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NewsCell *cell = [tableView dequeueReusableCellWithIdentifier:identify forIndexPath:indexPath];
    DetailNewsModel *model = _array[indexPath.row];
    cell.titleLabel.text = model.title;
    cell.timeLabel.text = model.timer;
    cell.BrowsingLabel.text = model.Browsing;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    DetailNewsViewController *detail = [[DetailNewsViewController alloc] init];
    detail.model = _array[indexPath.row];
    [self.navigationController pushViewController:detail animated:YES];
}



@end
