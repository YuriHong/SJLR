//
//  DetailCurriculumController.m
//  毕业
//
//  Created by 吴添培的黑苹果 on 2017/10/9.
//  Copyright © 2017年 吴添培. All rights reserved.
//

#import "DetailCourseController.h"
#import "UIImage+Image.h"
#import "DetailCourseTopView.h"
#import "DetailCourseCenterView.h"
#import "ChangeView.h"
#import "DetailInstController.h"
#import "SynopsisPageView.h"
#import <Popover.OC/PopoverView.h>
#import "DetailCourseModel.h"
#import "CourseData.h"
#import "loginViewController.h"
#import "InstDetailModel.h"


@interface DetailCourseController ()<DetailCourseCenterViewDelegate>
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) DetailCourseTopView *topView;
@property (nonatomic, strong) DetailCourseCenterView *centerView;
@property (nonatomic, strong) ChangeView *changeView;
@property (nonatomic, strong) DetailCourseModel *detailModel;

@property (nonatomic, strong) SynopsisPageView *courseSynopsis;
@property (nonatomic, strong) SynopsisPageView *instSynopsis;

@end

@implementation DetailCourseController


- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNavigationBar];
    [self scrollView];
    [self topView];
    [self centerView];
    [self changeView];
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
                
                _topView.courseModel = _detailModel;
                _centerView.courseModel = _detailModel;
                _centerView.instModel = _instModel;
                _courseSynopsis.detailStr = _detailModel.detail;
                _instSynopsis.detailStr = _instModel.detail;
                
                CGFloat ScrollY = _changeView.bottomY + 20;
                _scrollView.contentSize = CGSizeMake(0, ScrollY);
            }];
    }
    return _detailModel;
}

-(void)setupNavigationBar{
    self.navigationItem.title = @"课程详情";
    UIButton *button = [[UIButton alloc]init];
    [button setTitle:@"菜单"  forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont fontWithName:@"HYQuanTangShiJ" size:18];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor orangeColor] forState:UIControlStateHighlighted];
    [button addTarget:self action:@selector(rightClick:) forControlEvents:UIControlEventTouchUpInside];
    [button sizeToFit];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:button];
    
}

-(void)rightClick:(id)sender{
    PopoverAction *action1 = [PopoverAction actionWithTitle:@"添加到购物车" handler:^(PopoverAction *action) {
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

-(DetailCourseTopView *)topView{
    if (_topView == nil) {
        _topView = [DetailCourseTopView getDetailCourseTopView];
        [_scrollView addSubview:_topView];
    }
    return _topView;
}

-(DetailCourseCenterView *)centerView{
    if (_centerView == nil) {
        _centerView = [DetailCourseCenterView getDetailCourseCenterView];
        CGFloat centerViewY = _topView.bottomY + 20;
        CGFloat centerViewW = _centerView.width;
        CGFloat centerViewH = _centerView.height;
        _centerView.frame = CGRectMake(0, centerViewY, centerViewW, centerViewH);
        _centerView.delegate = self;
        [_scrollView addSubview:_centerView];
    }
    return _centerView;
}

-(void)pushDetailInstViewController{
    DetailInstController *inst = [[DetailInstController alloc] init];
    inst.model = _instModel;
    [self.navigationController pushViewController:inst animated:YES];
}

-(ChangeView *)changeView{
    if (_changeView == nil) {
        _changeView = [ChangeView getChangeView];
        _changeView.frame = CGRectMake(0, _centerView.bottomY + 20, SCREENWIDTH, 544);
        _courseSynopsis = [[SynopsisPageView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 500)];
        _instSynopsis = [[SynopsisPageView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 500)];
        NSArray *array =@[@{@"title": @"课程详情", @"view": _courseSynopsis},
                          @{@"title": @"机构简介", @"view": _instSynopsis}];
        
        _changeView.array = array;
        [_scrollView addSubview:_changeView];
    }
    return _changeView;
}



-(UIScrollView *)scrollView{
    if (_scrollView == nil) {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.frame = CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT - 64);
        _scrollView.backgroundColor = RGBColor(231, 231, 231);
        [self.view addSubview:_scrollView];
    }
    return _scrollView;
}





@end
