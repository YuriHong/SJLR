//
//  majorDetailController.m
//  毕业
//
//  Created by 吴添培的黑苹果 on 2017/10/16.
//  Copyright © 2017年 吴添培. All rights reserved.
//

#import "majorDetailController.h"
#import "majorDetailTopView.h"
#import <Popover.OC/PopoverView.h>
#import "DetailCourseModel.h"
#import "CourseData.h"
#import "SynopsisPageView.h"
#import "loginViewController.h"

@interface majorDetailController ()
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) majorDetailTopView *topView;
@property (nonatomic, strong) SynopsisPageView *synopsis;
@property (nonatomic, strong) DetailCourseModel *detailModel;

@end

@implementation majorDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNavigationBar];
    [self scrollView];
    [self topView];
    [self synopsis];
    [self detailModel];
  
}

-(DetailCourseModel *)detailModel{
    if (_detailModel == nil) {
        NSString *urlString = [NetworkTool willConcatenationString:@"/product/detail.do"];
        NSDictionary *params = @{@"productId": _ID};
        [[NetworkTool sharedInstance] requestWithURLString:urlString params:params method:POST callBack:^(id data, bool isSuccess) {
            CourseData *model = [CourseData mj_objectWithKeyValues:data];
            if (isSuccess == YES) {
                if (model.status == 0) {
                    _detailModel = [DetailCourseModel mj_objectWithKeyValues:model.data];
                }
            }
            _topView.model = _detailModel;
            _synopsis.detailStr = _detailModel.detail;
            
        }];
        
        
    }
    return _detailModel;
}

-(void)setupNavigationBar{
    self.navigationItem.title = @"专业详情";
    UIButton *button = [[UIButton alloc]init];
    [button setTitle:@"菜单" forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont fontWithName:@"HYQuanTangShiJ" size:16];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor orangeColor] forState:UIControlStateHighlighted];
    [button addTarget:self action:@selector(rightClick:) forControlEvents:UIControlEventTouchUpInside];
    [button sizeToFit];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
}

-(void)rightClick:(id)sender{
    PopoverAction *action1 = [PopoverAction actionWithTitle:@"加入购物车" handler:^(PopoverAction *action) {
        NSString *urlString = [NetworkTool willConcatenationString:@"/cart/add.do"];
        NSDictionary *params = @{@"productId": _ID,
                                 @"count": @"1"};
        [[NetworkTool sharedInstance] requestWithURLString:urlString params:params method:POST callBack:^(id data, bool isSuccess) {
            if (isSuccess) {
                CourseData *model = [CourseData mj_objectWithKeyValues:data];
                if (model.status == 0) {
                    [UIAlertController creatAlertControllerTitle:@"加入购物车成功" withMessage:nil target:self];
                }else{
                    [UIAlertController creatDoneAndCancerAlertControllerTitle:@"用户未登录,请登录" withMessage:@"" target:self callBack:^(UIAlertAction * _Nonnull action) {
                        if ([action.title isEqual:@"确定"]) {
                            loginViewController *login = [[loginViewController alloc] init];
                            [self presentViewController:login animated:YES completion:nil];
                        }
                    }];
                }
            }
            else{
                [UIAlertController creatAlertControllerTitle:@"请链接网络" withMessage:nil target:self];
            }
        }];

    }];
    PopoverAction *action2 = [PopoverAction actionWithTitle:@"回到首页" handler:^(PopoverAction *action) {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }];
    
    PopoverView *popoverView = [PopoverView popoverView];
    popoverView.showShade = YES;
    [popoverView showToView:sender withActions:@[action1,action2]];
}


-(majorDetailTopView *)topView{
    if (_topView == nil) {
        _topView = [majorDetailTopView getmajorDetailTopView];
        [_scrollView addSubview:_topView];
    }
    return _topView;
}

-(SynopsisPageView *)synopsis{
    if (_synopsis == nil) {
        _synopsis = [[SynopsisPageView alloc] initWithFrame:CGRectMake(0, _topView.bottomY, SCREENWIDTH, SCREENHEIGHT - _topView.bottomY - 64)];
        [_scrollView addSubview:_synopsis];
        
    }
    return _synopsis;
}

-(UIScrollView *)scrollView{
    if (_scrollView == nil) {
        _scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
        _scrollView.backgroundColor = RGBColor(237,237,237);
        _scrollView.showsVerticalScrollIndicator = NO;
        [self.view addSubview:_scrollView];
    }
    return _scrollView;
}



@end
