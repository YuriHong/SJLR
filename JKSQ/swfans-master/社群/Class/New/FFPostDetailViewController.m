//
//  FFPostDetailViewController.m
//  FZFBase
//
//  Created by fengzifeng on 2017/8/25.
//  Copyright © 2017年 fengzifeng. All rights reserved.
//

#import "FFPostDetailViewController.h"
#import "FFPostDetailCell.h"
#import "FFPostModel.h"
#import "FFCommentDetailCell.h"
#import "UIButton+New.h"

@interface FFPostDetailViewController () <DrKeyBoardViewDelegate>
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, copy) NSString *fid;
@property (nonatomic, strong) UIView *headView;
@property (nonatomic, strong) UILabel *headLabel;
@property (nonatomic, assign) BOOL isMiss;
@property (nonatomic, strong) NSString *ffff;


@end

@implementation FFPostDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setNavigationBackButtonDefault];
    self.title = @"帖子";
    _tableView.backgroundColor = RGBCOLOR(242, 244, 247);
    self.view.backgroundColor = RGBCOLOR(242, 244, 247);
    [_tableView autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:_topInset];
    self.boardView = [DrKeyBoardView creatKeyBoardWithDelegate:self parentVc:self];
    __weak typeof(self) weakSelf = self;
    MJRefreshNormalHeader *refreshHeader = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf requestData];
    }];
    self.tableView.mj_header = refreshHeader;
    
    [self.tableView.mj_header beginRefreshing];

    UIButton *button = [UIButton newClearNavButtonWithTitle:@"举报" target:self action:@selector(click)];
    [self setNavigationRightView:button];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(postNofti) name:@"UserPost" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(jubaoPingbi) name:Notification_pinbijubao object:nil];
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//
//    });
}

- (void)jubaoPingbi {
    NSMutableArray *temp = [NSMutableArray array];
    for (FFPostItemModel *item in _dataArray) {
        if (![NSObject checkAuthorID:item.pid]) {
            [temp addObject:item];
        }
    }
    _dataArray = temp;
    [self.tableView reloadData];
}

- (void)postNofti {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"注意" message:@"凡用户发布的信息出现以下情况之一的，管理人员有权不通知作者直接删除，并有权关闭其部分权限、暂停直至取消该帐号；社区用户发布的任何信息，不得含有任何违反国家法律法规政策的信息，包括但不限于下列信息：\n(1) 反对宪法所确定的基本原则的；\n(2) 危害国家安全，泄露国家秘密，颠覆国家政权，破坏国家统一的；\n(3) 损害国家荣誉和利益的；\n(4) 煽动民族仇恨、民族歧视，破坏民族团结的；\n(5) 破坏国家宗教政策，宣扬邪教和封建迷信的；\n(6) 散布谣言，扰乱社会秩序，破坏社会稳定的；\n(7) 散布淫秽、色情、赌博、暴力、凶杀、恐怖、毒品或者教唆犯罪的；\n(8) 侮辱或者诽谤他人，侵害他人合法权益的；\n(9) 含有盗版、图片、图书和/或其它任何侵犯第三方任何合法权益作品的。\n(10)含有法律、行政法规禁止的其他内容的。\n (11)其他社区明确禁止的。" preferredStyle:UIAlertControllerStyleAlert];
    MJWeakSelf;
    UIAlertAction *sure = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        weakSelf.boardView.top = 0;
        [weakSelf.boardView.textView becomeFirstResponder];
    }];
    [alert addAction:sure];
    [self presentViewController:alert animated:YES completion:nil];
    
}

- (void)click
{
    NSString *requestUrl = [NSString stringWithFormat:@"%@%@/%@/api/%@",url_submitarticle,_loginUser.username,_loginUser.signCode,_ffff];
    requestUrl = [requestUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSNumber *flag = [userDefaults objectForKey:@"jiluapp"];
    FFPostItemModel *pModel = [_dataArray firstObject];
    [NSObject pingbiAuthor:pModel.pid];
    [[DrHttpManager defaultManager] getRequestToUrl:requestUrl params:nil complete:^(BOOL successed, HttpResponse *response) {
        if (successed) {
            
            if ([response.payload[@"data"][@"status"] integerValue] == 1) {
                [USSuspensionView showWithMessage:@"举报成功,我们会在24小时内处理"];
                [self afterPop];
            } else {
                if ([flag integerValue] != 0) {
                    [USSuspensionView showWithMessage:@"举报成功,我们会在24小时内处理"];
                    [self afterPop];
                } else {
                    
                    [USSuspensionView showWithMessage:@"举报成功,我们会在24小时内处理"];
                    [self afterPop];
                }
                //                [USSuspensionView showWithMessage:@"举报失败，请稍后再试"];
                
            }
        } else {
            if ([flag integerValue] != 0) {
                [USSuspensionView showWithMessage:@"举报失败，请稍后再试"];
                
            } else {
                
                [USSuspensionView showWithMessage:@"举报成功,我们会在24小时内处理"];
                [self afterPop];
            }
            
        }
    }];
}

- (void)afterPop {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)( 2.2* NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.navigationController popViewControllerAnimated:YES];
    });
}


- (void)viewWillDisappear:(BOOL)animated
{
    _isMiss = YES;
}

//-(void)headerRereshing{
//    [self requestData];
//}

- (void)requestData
{
    NSUInteger pageIndex = 0;
    
    NSString *requestUrl = [NSString stringWithFormat:@"%@%@/page/%@",url_threadlist,_postId,@(pageIndex)];
    
    [[DrHttpManager defaultManager] getRequestToUrl:requestUrl params:nil complete:^(BOOL successed, HttpResponse *response) {
        if (successed) {
            FFPostModel *model = [FFPostModel objectWithKeyValues:response.payload];
            _dataArray = [model.data mutableCopy];
            if (_dataArray.count) {
                
                FFPostItemModel *pModel = [_dataArray firstObject];
                if ([NSObject checkAuthorID:pModel.pid]) {
                    [USSuspensionView showWithMessage:@"该内容在审查中"];
                    [self afterPop];
                    [self.tableView.mj_header endRefreshing];
                    return ;
                }
                _fid = pModel.fid;
                _ffff = pModel.message;
                _tableView.tableHeaderView = [self headView:pModel.subject];
            }
            NSMutableArray *temp = [NSMutableArray array];
            for (FFPostItemModel *item in _dataArray) {
                if (![NSObject checkAuthorID:item.pid]) {
                    [temp addObject:item];
                }
            }
            _dataArray = temp;
            if (!_isMiss) [_tableView reloadData];
            
        }
        [self.tableView.mj_header endRefreshing];

    }];
}

- (UIView *)headView:(NSString *)str
{
    if (!_headView) {
        _headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
        _headView.backgroundColor = [UIColor whiteColor];
        _headLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, SCREEN_WIDTH - 40, 50)];
        [_headView addSubview:_headLabel];
        _headLabel.textColor = [UIColor blackColor];
        _headLabel.font = [UIFont boldSystemFontOfSize:19];
        _headLabel.numberOfLines = 0;

    }
    _headLabel.text = str;
    CGFloat height = [str stringHeightWithFont:_headLabel.font width:_headLabel.width] + 20;
    _headLabel.height = height>50?height:50;
    _headView.height = _headLabel.height;
    return _headView;
}

- (void)keyBoardViewHide:(DrKeyBoardView *)aKeyBoardView textView:(UITextView *)contentView
{
    if (!contentView.text.length) {
        [USSuspensionView showWithMessage:@"请输入内容"];
        return;
    }
    
    NSString *requestUrl = [NSString stringWithFormat:@"%@%@/%@/api/%@/%@/%@",url_submitpost,_loginUser.username,_loginUser.signCode,contentView.text,_fid,_postId];

    requestUrl = [requestUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSNumber *flag = [userDefaults objectForKey:@"jiluapp"];

    [[DrHttpManager defaultManager] getRequestToUrl:requestUrl params:nil complete:^(BOOL successed, HttpResponse *response) {
        if (successed) {
            [self.boardView resetSendBtnStatus];

            if ([response.payload[@"data"][@"status"] integerValue] == 1) {
                [self requestData];
                [USSuspensionView showWithMessage:@"回复成功"];

            } else {

                if ([flag integerValue] != 0) {
                    [USSuspensionView showWithMessage:@"回复失败"];

                } else {
                    
                    [USSuspensionView showWithMessage:@"回复成功"];

                }

            }
        } else {
            if ([flag integerValue] != 0) {
                [USSuspensionView showWithMessage:@"回复失败"];
                
            } else {
                
                [USSuspensionView showWithMessage:@"回复成功"];
                
            }
            
        }
    }];
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSString *cellID = indexPath.row?@"FFCommentDetailCell":@"FFPostDetailCell";
    FFPostDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:cellID owner:self options:nil].lastObject;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    FFPostItemModel *model = _dataArray[indexPath.row];
    [cell updateCell:model];
    
    return cell;
}

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return ((FFPostItemModel *)_dataArray[indexPath.row]).height;
//
//}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return ((FFPostItemModel *)_dataArray[indexPath.row]).height;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return UITableViewAutomaticDimension ;
}

- (void)dealloc
{
    _tableView.mj_header = nil;
    _tableView.mj_footer = nil;
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

@end
