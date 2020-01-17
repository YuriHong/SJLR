//
//  MassPersonController.m
//  毕业设计
//
//  Created by 龙波 on 2017/9/19.
//  Copyright © 2017年 ----龙波. All rights reserved.
//

#import "MassPersonController.h"
#import "DetailVacationController.h"
#import "detailVacationTopView.h"
#import "detailVacationCenterView.h"
#import "detailVacationBottomView.h"
#import "CourseData.h"
#import "DetailCourseModel.h"
#import "loginViewController.h"
#import "AllImageController.h"
#import <SDWebImage/UIButton+WebCache.h>

@interface MassPersonController ()
@property(nonatomic, strong) UIScrollView *scrollView;
@property(nonatomic, strong) detailVacationTopView *topView;
@property(nonatomic, strong) detailVacationCenterView *centerView;
@property(nonatomic, strong) detailVacationBottomView *bottomView;
@property(nonatomic, strong) DetailCourseModel *detailModel;

@end

@implementation MassPersonController

-(void)loadView{
    [super loadView];
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT - 64)];
    _scrollView.backgroundColor = [UIColor whiteColor];
    self.view = _scrollView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self detailModel];
    NSLog(@"%@",_detailModel.subImages);
}


-(DetailCourseModel *)detailModel{
    if (_detailModel == nil) {
        NSString *urlString = [NetworkTool willConcatenationString:@"/product/detail.do"];
        NSDictionary *params = @{@"productId": _productID};
        [[NetworkTool sharedInstance] requestWithURLString:urlString params:params method:POST callBack:^(id data, bool isSuccess) {
            CourseData *model = [CourseData mj_objectWithKeyValues:data];
            if (isSuccess == YES) {
                if (model.status == 0) {
                    _detailModel = [DetailCourseModel mj_objectWithKeyValues:model.data];
                }
            }
            
            
            
            
            
            [self topView];
            [self centerView];
            [self bottomView];
            
            CGFloat y = _bottomView.bottomY + 50;
            _scrollView.contentSize = CGSizeMake(0, y);
        }];
    }
    return _detailModel;
}

//MARK: - top
-(detailVacationTopView *)topView{
    if (_topView == nil) {
        _topView = [detailVacationTopView getDetailVacationTopView];
        [_topView.button addTarget:self action:@selector(topButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        NSString *urlStr = [NSString stringWithFormat:@"http://47.93.33.181/longboImage/%@",_detailModel.mainImage];
        [_topView.button sd_setImageWithURL:[NSURL URLWithString:urlStr] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"qianlan"]];
        _topView.subTitleLabel.text = _detailModel.subtitle;
        [_scrollView addSubview:_topView];
    }
    return _topView;
}

-(void)topButtonClick:(id)sender{
    
    if ([_detailModel.subImages isEqualToString:@"0"]) {
        [UIAlertController creatAlertControllerTitle:@"提示" withMessage:@"无更多的图片" target:self];
    }else{
        AllImageController *ac = [[AllImageController alloc]init];
        ac.imageUrlArray = _detailModel.subImages;
        [self.navigationController pushViewController:ac animated:YES];
    }
    
}

//MARK: - center
-(detailVacationCenterView *)centerView{
    if (_centerView == nil) {
        _centerView = [detailVacationCenterView getDetailVacationCenterView];
       // [_centerView.button addTarget:self action:@selector(centerButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        _centerView.button.hidden = YES;
        _centerView.y = _topView.bottomY + 20;
        _centerView.titleLabel.text = _detailModel.name;
        _centerView.priceLabel.text = [NSString stringWithFormat:@"价格： ¥%@",@(_detailModel.price)];
        _centerView.stockLabel.text = [NSString stringWithFormat:@"联系电话：  %@",@(_detailModel.stock)];
        [_scrollView addSubview:_centerView];
    }
    return _centerView;
}


//MARK: - bottom
-(detailVacationBottomView *)bottomView{
    if (_bottomView == nil) {
        _bottomView = [detailVacationBottomView getDetailVacationBottomView];
        _bottomView.detailString = _detailModel.detail;
        _bottomView.y = _centerView.bottomY + 20;
        _bottomView.height = _bottomView.detail.textLabel.bottomY;
        [_scrollView addSubview:_bottomView];
    }
    return _bottomView;
}

@end
