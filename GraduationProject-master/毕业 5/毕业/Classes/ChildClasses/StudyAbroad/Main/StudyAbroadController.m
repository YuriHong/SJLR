//
//  StudyAbroadController.m
//  毕业
//
//  Created by 吴添培的黑苹果 on 2017/10/3.
//  Copyright © 2017年 吴添培. All rights reserved.
//

#import "StudyAbroadController.h"
#import "Carousel.h"
#import "NSMutableArray+Extension.h"
#import "NationalityMenuView.h"
#import "WTPListView.h"
#import "SchoolListController.h"
#import "SchoolDetailController.h"
#import "majorDetailController.h"
#import "majorListController.h"
#import "CourseData.h"
#import "DetailCourseModel.h"
#import "SchoolsModel.h"

@interface StudyAbroadController ()<CarouselDelegate,NationalityMenuViewDelegate,WTPListViewDelegate>
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) Carousel *carousel;
@property (nonatomic, strong) NationalityMenuView * nationalityMenu;
@property (nonatomic, strong) WTPListView *Scrools;
@property (nonatomic, strong) WTPListView *major;

@property (nonatomic, strong) NSMutableArray *majorArray;
@property (nonatomic, strong) NSMutableArray *schoolsModelArray;

@end

@implementation StudyAbroadController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"留学";

    [self scrollView];
    [self carousel];
    [self NationalityMenuView];
    [self Scrools];
    [self major];
    [self majorArray];
    [self schoolsModelArray];
    
    CGFloat y = _major.bottomY + 20;
    _scrollView.contentSize = CGSizeMake(0, y);
    
  
}

//MARK: -1.设置广告轮播器
-(Carousel *)carousel{
    if (_carousel == nil) {
        self.automaticallyAdjustsScrollViewInsets = NO;
        
        _carousel = [[Carousel alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 180)];
        _carousel.delegate = self;
        _carousel.timeInterval = 3;
        //图片
        NSMutableArray *array = [NSMutableArray arrayWithPlistFileResource:@"Abroad"];
        _carousel.imageArray = array;
        [_scrollView addSubview:_carousel];
    }
    return _carousel;
}

//MARK: -2.设置菜单
-(NationalityMenuView *)NationalityMenuView{
    if (_nationalityMenu == nil) {
        _nationalityMenu = [[NationalityMenuView alloc]init];
        CGFloat y = _carousel.bottomY + 20;
        _nationalityMenu.frame = CGRectMake(0, y, SCREENWIDTH, 120);
        _nationalityMenu.delegate = self;
        [_scrollView addSubview:_nationalityMenu];
    }
    return _nationalityMenu;
}

-(void)setPushViewControllerWithTitle:(NSString *)title{
    if ([title isEqual:@"学校"]) {
        SchoolListController *scroolList = [[SchoolListController alloc] init];
        [self.navigationController pushViewController:scroolList animated:YES];
    }
    else if ([title isEqual:@"专业"]){
        majorListController *majorList = [[majorListController alloc] init];
        [self.navigationController pushViewController:majorList animated:YES];
    }
}

//MARK: -2.热门学校
-(WTPListView *)Scrools{
    if (_Scrools == nil) {
        _Scrools = [WTPListView getWTPListView];
        _Scrools.delegate = self;
        _Scrools.labelText = @"热门高校";
        [_Scrools setNibWithNibName:@"SchoolsCell" identify:@"ScroolsCellID"];
        CGFloat y = _nationalityMenu.bottomY + 20;
        CGFloat h = _Scrools.height;
        _Scrools.frame = CGRectMake(0, y, SCREENWIDTH, h);
        [_scrollView addSubview:_Scrools];
    }
    return _Scrools;
}

-(NSMutableArray *)schoolsModelArray{
    if (_schoolsModelArray == nil) {
        _schoolsModelArray = [SchoolsModel getSchoolsModelArray];
        for (int i = 0; i < 4; i++) {
            [_schoolsModelArray addObject:_schoolsModelArray[0]];
        }
        _Scrools.array = _schoolsModelArray;
    }
    return _schoolsModelArray;
}

//MARK: -3.推荐专业
-(WTPListView *)major{
    if (_major == nil) {
        _major = [WTPListView getWTPListView];
        _major.delegate = self;
        _major.labelText = @"推荐专业";
        [_major setNibWithNibName:@"majorCell" identify:@"majorCellID"];
        CGFloat y = _Scrools.bottomY + 20;
        CGFloat h = _major.height;
        _major.frame = CGRectMake(0, y, SCREENWIDTH, h);
        [_scrollView addSubview:_major];
        
    }
    return _major;
}

-(NSMutableArray *)majorArray{
    if (_majorArray == nil) {
        _majorArray = [NSMutableArray array];
        NSString *urlString = [NetworkTool willConcatenationString:@"/product/list.do"];
        NSDictionary *params = @{@"categoryId": @"100002"};
        [[NetworkTool sharedInstance] requestWithURLString:urlString params:params method:POST callBack:^(id data, bool isSuccess) {
            CourseData *model = [CourseData mj_objectWithKeyValues:data];
            if (isSuccess == YES) {
                NSArray *list = model.data[@"list"];
                if (model.status == 0) {
                    for (NSDictionary *dict in list) {
                        DetailCourseModel *detailModel = [DetailCourseModel mj_objectWithKeyValues:dict];
                        [_majorArray addObject:detailModel];
                    }
                    for (int i = 0; i < 4; i++) {
                        [_majorArray addObject:_majorArray[0]];
                    }
                    
                    _major.array = _majorArray;
                }
            }
        }];
    }
    return _majorArray;
}


-(void)pushListViewControllerWithTitle:(NSString *)title{
    if ([title isEqual:@"热门高校"]) {
        SchoolListController *scroolList = [[SchoolListController alloc] init];
        [self.navigationController pushViewController:scroolList animated:YES];
    }
    else if ([title isEqual:@"推荐专业"]){
        majorListController *majorList = [[majorListController alloc] init];
        [self.navigationController pushViewController:majorList animated:YES];
    }
    
}

-(void)pushListDetailViewControllerWithtitle:(NSString *)title andID:(NSString *)ID{
    if ([title isEqual:@"热门高校"]) {
        SchoolDetailController *detail = [[SchoolDetailController alloc] init];
        detail.model = _schoolsModelArray[0];
        [self.navigationController pushViewController:detail animated:YES];
    }
    else if ([title isEqual:@"推荐专业"]){
        majorDetailController *major = [[majorDetailController alloc] init];
        major.ID = ID;
        [self.navigationController pushViewController:major animated:YES];
    }
}

-(UIScrollView *)scrollView{
    if (_scrollView == nil) {
        _scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
        _scrollView.height = _scrollView.height - 108;
        _scrollView.backgroundColor = RGBColor(237,237,237);
        _scrollView.showsVerticalScrollIndicator = NO;
        [self.view addSubview:_scrollView];
    }
    return _scrollView;
}

@end
