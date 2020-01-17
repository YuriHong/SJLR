//
//  trainViewController.m
//  校园帮
//
//  Created by 吴添培 on 2017/7/5.
//  Copyright © 2017年 吴添培. All rights reserved.
//

#import "trainViewController.h"
#import "NSMutableArray+Extension.h"
#import "Carousel.h"
#import "InstCenterMenu.h"
#import "IndustryHotspotView.h"
#import "DetailNewsModel.h"
#import "DetailNewsViewController.h"
#import "WTPListView.h"

#import "CourseController.h"
#import "onlineCurricllumController.h"
#import "NewsViewController.h"
#import "InstitutionController.h"

#import "DetailCourseController.h"
#import "DetailInstController.h"

#import "CourseData.h"
#import "DetailCourseModel.h"
#import "InstDetailModel.h"

@interface trainViewController ()<InstCenterMenuDelegate,IndustryHotspotViewDelegate,WTPListViewDelegate>
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) Carousel *carousel;
@property (nonatomic, strong) InstCenterMenu *centerMenu;
@property (nonatomic, strong) WTPListView *curriculum;
@property (nonatomic, strong) IndustryHotspotView *hotpotView;
@property (nonatomic, copy) NSArray *array;
@property (nonatomic, strong) NSMutableArray *curriculumArray;

@end

@implementation trainViewController

-(UIScrollView *)scrollView{
    if (_scrollView == nil) {
        _scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
        _scrollView.height = _scrollView.height - 108;
        _scrollView.backgroundColor = RGBColor(231, 231, 231);
        _scrollView.showsVerticalScrollIndicator = NO;
        [self.view addSubview:_scrollView];
    }
    return _scrollView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self scrollView];
    [self carousel];
    [self centerMenu];
    [self hotpotView];
    [self curriculum];
     [self curriculumArray];
    
    //真正的scrollView可滑动的视图尺寸（y方向的滑动）
    CGFloat height = _curriculum.bottomY + 20;
    _scrollView.contentSize = CGSizeMake(0, height);
}

//MARK: -1.设置广告轮播器
-(Carousel *)carousel{
    if (_carousel == nil) {
        self.automaticallyAdjustsScrollViewInsets = NO;
        _carousel = [[Carousel alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 175)];
        _carousel.timeInterval = 3;
        //图片
        NSMutableArray *array = [NSMutableArray arrayWithPlistFileResource:@"carousel"];
        _carousel.imageArray = array;
        [_scrollView addSubview:_carousel];
    }
    return _carousel;
}

//MARK: -2.设置菜单
-(InstCenterMenu *)centerMenu{
    if (_centerMenu == nil) {
        _centerMenu = [[InstCenterMenu alloc]init];
        CGFloat y = _carousel.bottomY + 20;
        _centerMenu.frame = CGRectMake(0, y, SCREENWIDTH, 120);
        _centerMenu.delegate = self;
        [_scrollView addSubview:_centerMenu];
    }
    return _centerMenu;
}

//push代理方法------菜单
-(void)setPushViewControllerWithButtonTitle:(NSString *)buttonTitle{
    if ([buttonTitle isEqual:@"课程列表"]) {
        [self pushViewController:[[CourseController alloc]init]];
    }
    else if ([buttonTitle isEqual:@"培训机构"]) {
        [self pushViewController:[[InstitutionController alloc]init]];
    }
    else if ([buttonTitle isEqual:@"免费课程"]){
        [self pushViewController:[[onlineCurricllumController alloc]init]];
    }
}

-(void)pushViewController:(UIViewController *)vc{
    [self.navigationController pushViewController:vc animated:YES];
}

//3.MARK: - 设置行业热点
-(IndustryHotspotView *)hotpotView{
    if (_hotpotView == nil) {
        _array = [DetailNewsModel getDetailNewsModelArray];
        _hotpotView = [IndustryHotspotView getIndustryHotspotView];
        CGFloat y = _centerMenu.bottomY + 20;
        CGFloat h = _hotpotView.height;
        _hotpotView.frame = CGRectMake(0, y, SCREENWIDTH, h);
        _hotpotView.delegate = self;
        _hotpotView.list = _array;
        [_scrollView addSubview:_hotpotView];
    }
    return _hotpotView;
}

//行业处理方法------------代理（右）
-(void)clickLineRightWithtitle:(NSString *)titleName{
    for (DetailNewsModel *model in _array) {
        if ([model.title isEqual:titleName]) {
            DetailNewsViewController *detail = [[DetailNewsViewController alloc] init];
            detail.model = model;
            [self.navigationController pushViewController:detail animated:YES];
        }
    }
}

//4.MARK: - 设置推荐课程
-(WTPListView *)curriculum{
    if (_curriculum == nil) {
        _curriculum = [WTPListView getWTPListView];
        _curriculum.delegate = self;
        _curriculum.labelText = @"热门课程";
        [_curriculum setNibWithNibName:@"CourseCell" identify:@"Cell"];
        CGFloat y = _hotpotView.bottomY + 20;
        CGFloat h = _curriculum.height;
        _curriculum.frame = CGRectMake(0, y, SCREENWIDTH, h);
        [_scrollView addSubview:_curriculum];
    }
    return _curriculum;
}

-(NSMutableArray *)curriculumArray{
    if (_curriculumArray == nil) {
        _curriculumArray = [NSMutableArray array];
        NSString *urlString = [NetworkTool willConcatenationString:@"/product/list.do"];
        NSDictionary *params = @{@"categoryId": @"100001",
                                 @"pageSize": @"5"
                                 };
        [[NetworkTool sharedInstance] requestWithURLString:urlString params:params method:POST callBack:^(id data, bool isSuccess) {
            CourseData *model = [CourseData mj_objectWithKeyValues:data];
            if (isSuccess == YES) {
                NSArray *list = model.data[@"list"];
                if (model.status == 0) {
                    for (NSDictionary *dict in list) {
                        DetailCourseModel *detailModel = [DetailCourseModel mj_objectWithKeyValues:dict];
                        [_curriculumArray addObject:detailModel];
                        
                    }
                    _curriculum.array = _curriculumArray;
                }
            }
        }];
    }
    return _curriculumArray;
}

-(void)pushListViewControllerWithTitle:(NSString *)title{
    [self pushViewController:[[CourseController alloc] init]];
}

-(void)pushListDetailViewControllerWithtitle:(NSString *)title andID:(NSString *)ID{
    DetailCourseController *detail = [[DetailCourseController alloc] init];
    NSArray *array = [InstDetailModel getInstDetailModelArray];
    for (int i = 0; i < array.count; i++) {
        InstDetailModel *instModel = array[i];
        for (NSString *str in instModel.courseID) {
            if ([str isEqual:ID]) {
                detail.ID = ID;
                detail.instModel = instModel;
            }
        }
    }
    [self pushViewController:detail];
}

@end
