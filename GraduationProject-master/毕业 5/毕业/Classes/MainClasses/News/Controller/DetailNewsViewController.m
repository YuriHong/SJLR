//
//  DetailNewsViewController.m
//  毕业
//
//  Created by 吴添培的黑苹果 on 2017/10/22.
//  Copyright © 2017年 吴添培. All rights reserved.
//

#import "DetailNewsViewController.h"
#import "DetailNewsTopView.h"
#import "DetailNewsCenterView.h"

@interface DetailNewsViewController ()
@property(nonatomic,strong)UIScrollView *scrollView;
@property(nonatomic,strong)DetailNewsTopView *topView;
@property(nonatomic,strong)DetailNewsCenterView *centerView;

@end

@implementation DetailNewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"新闻详情";
    
    [self scrollView];
    [self topView];
    [self center];
    
    CGFloat y = _centerView.bottomY + 20;
    
    _scrollView.contentSize = CGSizeMake(0, y);
}

-(DetailNewsTopView *)topView{
    if (_topView == nil) {
        _topView = [DetailNewsTopView getDetailNewsTopView];
        _topView.titleLabel.text = _model.title;
        _topView.authorLabel.text = _model.author;
        _topView.timerLabel.text = _model.timer;
        [_scrollView addSubview:_topView];
    }
    return _topView;
}

-(DetailNewsCenterView *)center{
    if (_centerView == nil) {
        _centerView = [[DetailNewsCenterView alloc] init];
        _centerView.jsonStr = _model.json;
        CGFloat height = _centerView.attributedLabel.height;
        _centerView.frame = CGRectMake(0, _topView.bottomY, SCREENWIDTH, height);
        
        [_scrollView addSubview:_centerView];
    }
    return _centerView;
}


-(UIScrollView *)scrollView{
    if (_scrollView == nil) {
        _scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
        _scrollView.height = _scrollView.height - 64;
        _scrollView.backgroundColor = RGBColor(231, 231, 231);
        _scrollView.showsVerticalScrollIndicator = NO;
        [self.view addSubview:_scrollView];
    }
    return _scrollView;
}



@end
