//
//  StudyDetailController.m
//  毕业
//
//  Created by 吴添培的黑苹果 on 2017/10/15.
//  Copyright © 2017年 吴添培. All rights reserved.
//

#import "SchoolDetailController.h"
#import "SchoolDetailTopView.h"
#import "ChangeView.h"
#import "SynopsisPageView.h"
#import "NationalCoursePageView.h"
#import <Popover.OC/PopoverView.h>
#import "majorDetailController.h"

@interface SchoolDetailController ()<NationalCoursePageViewDelegate>
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) SchoolDetailTopView *topView;
@property (nonatomic, strong) ChangeView *changeView;

@end

@implementation SchoolDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNavigationBar];
    [self scrollView];
    [self topView];
    [self changeView];
    
    CGFloat h = _changeView.bottomY + 20;
    _scrollView.contentSize = CGSizeMake(0, h);
    
}

-(void)setupNavigationBar{
    self.navigationItem.title = @"学校详情";
    UIButton *button = [[UIButton alloc]init];
    [button setTitle:@"首页" forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont fontWithName:@"HYQuanTangShiJ" size:16];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor orangeColor] forState:UIControlStateHighlighted];
    [button addTarget:self action:@selector(rightClick:) forControlEvents:UIControlEventTouchUpInside];
    [button sizeToFit];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
}

-(void)rightClick:(id)sender{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

-(SchoolDetailTopView *)topView{
    if (_topView == nil) {
        _topView = [SchoolDetailTopView getSchoolDetailTopView];
        _topView.model = _model;
        [_scrollView addSubview:_topView];
    }
    return _topView;
}


-(ChangeView *)changeView{
    if (_changeView == nil) {
        _changeView = [ChangeView getChangeView];
        CGFloat y = _topView.bottomY;
        _changeView.frame = CGRectMake(0, y, SCREENWIDTH, 544);
        SynopsisPageView *national = [[SynopsisPageView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 500)];
        national.detailStr = _model.detail;
        NationalCoursePageView *nationalMajor = [[NationalCoursePageView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 500)];
        nationalMajor.delegate = self;
        nationalMajor.array = _model.majorID;
        NSArray *array =@[@{@"title": @"校园概述", @"view": national},
                          @{@"title": @"专业列表", @"view": nationalMajor}];
        
        _changeView.array = array;
        [_scrollView addSubview:_changeView];
    }
    return _changeView;
}

-(void)pushMajorDetailViewControllerWithID:(NSString *)ID{
    majorDetailController *major = [[majorDetailController alloc] init];
    major.ID = ID;
    [self.navigationController pushViewController:major animated:YES];
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
