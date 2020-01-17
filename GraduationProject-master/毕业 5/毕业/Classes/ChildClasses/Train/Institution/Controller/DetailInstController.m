//
//  InstcurriculumController.m
//  毕业
//
//  Created by 吴添培的黑苹果 on 2017/10/5.
//  Copyright © 2017年 吴添培. All rights reserved.
//

#import "DetailInstController.h"
#import "InstTopView.h"
#import "InstCenterView.h"
#import "ChangeView.h"
#import "InstCoursePageView.h"
#import "SynopsisPageView.h"
#import "DetailCourseController.h"
#import "UIImage+Image.h"
#import <Popover.OC/PopoverView.h>
#import "InstDetailModel.h"

@interface DetailInstController ()<InstCoursePageViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) InstTopView *topView;
@property (nonatomic, strong) InstCenterView *centerView;
@property (nonatomic, strong) ChangeView *changeView;

@end

@implementation DetailInstController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNavigationBar];
    [self scrollView];
    [self topView];
    [self centerView];
    [self changeView];
    
    CGFloat ScrollY = _changeView.bottomY + 20;
    _scrollView.contentSize = CGSizeMake(0, ScrollY);
    
}

-(void)setupNavigationBar{
    self.navigationItem.title = @"机构详情";
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
    PopoverAction *action1 = [PopoverAction actionWithTitle:@"回到首页" handler:^(PopoverAction *action) {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }];
    
    PopoverView *popoverView = [PopoverView popoverView];
    popoverView.showShade = YES;
    [popoverView showToView:sender withActions:@[action1]];
}

//MARK: -懒加载
-(UIScrollView *)scrollView{
    if (_scrollView == nil) {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.frame = CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT - 64);
        _scrollView.backgroundColor = RGBColor(231, 231, 231);
        [self.view addSubview:_scrollView];
    }
    return _scrollView;
}

-(InstTopView *)topView{
    if (_topView == nil) {
        _topView = [InstTopView getInstTopView];
        _topView.model = _model;
        [_scrollView addSubview:_topView];
    }
    return _topView;
}

-(InstCenterView *)centerView{
    if (_centerView == nil) {
        _centerView = [InstCenterView getInstCenterView];
        _centerView.frame = CGRectMake(0, _topView.height + 20, SCREENWIDTH, _centerView.height);
        _centerView.model = _model;
        [_scrollView addSubview:_centerView];
    }
    return _centerView;
}

-(ChangeView *)changeView{
    if (_changeView == nil) {
        _changeView = [ChangeView getChangeView];
        _changeView.frame = CGRectMake(0, _centerView.bottomY + 20, SCREENWIDTH, 544);
        InstCoursePageView *Course = [[InstCoursePageView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 500)];
        Course.courseArray = _model.courseID;
        Course.delegate = self;
        SynopsisPageView *inst = [[SynopsisPageView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 500)];
        inst.detailStr = _model.detail;
        NSArray *array =@[@{@"title": @"课程列表", @"view": Course},
                          @{@"title": @"机构简介", @"view": inst}];
        _changeView.array = array;
        [_scrollView addSubview:_changeView];
    }
    return _changeView;
}

-(void)pushCourseDetailViewControllerWithID:(NSString *)ID{
    DetailCourseController *detail = [[DetailCourseController alloc] init];
    detail.ID = ID;
    detail.instModel = _model;
    [self.navigationController pushViewController:detail animated:YES];
}


@end
