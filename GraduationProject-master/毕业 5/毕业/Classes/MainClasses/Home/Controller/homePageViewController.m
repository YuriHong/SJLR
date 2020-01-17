//
//  homePageViewController.m
//  校园帮(用户)
//
//  Created by 吴添培 on 2017/7/31.
//  Copyright © 2017年 吴添培. All rights reserved.
//

#import "homePageViewController.h"
#import "trainViewController.h"
#import "StudyAbroadController.h"
#import "VacationHomeController.h"


@interface homePageViewController ()
@property(nonatomic,strong) trainViewController *train;
@property(nonatomic,strong) StudyAbroadController *study;
@property(nonatomic,strong) VacationHomeController *vacation;

@property(nonatomic,strong) UIButton *selectedButton;

@end

@implementation homePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self setNavigationbar];
    
}

-(void)setNavigationbar{
    UIView *titleView = [[UIView alloc] init];
    titleView.frame = CGRectMake(0, 0, 300, 30);
    //titleView.backgroundColor = [UIColor redColor];
    NSArray *array = @[@"培训",@"旅游",@"留学"];
    for (int i = 0; i < array.count; i++) {
        UIButton *button = [[UIButton alloc] init];
        [button setTitle:array[i] forState:UIControlStateNormal];
        if (i == 0) {
            [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
            _selectedButton = button;
            _selectedButton.enabled = NO;
            _train = [[trainViewController alloc]init];
            [self.view addSubview:_train.view];
            [self addChildViewController:_train];
        }
        button.width = 60;
        button.height = 30;
        button.centerX = titleView.centerX + titleView.width / array.count * (i - 1);
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [titleView addSubview:button];
    }
    
    self.navigationItem.titleView = titleView;
}

-(void)removeViews{
    [_train.view removeFromSuperview];
    [_study.view removeFromSuperview];
    [_vacation.view removeFromSuperview];

}

-(void)selected:(UIButton *)button{
    [_selectedButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _selectedButton.enabled = YES;
    _selectedButton = button;
    [_selectedButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    _selectedButton.enabled = NO;
    
}

-(void)buttonClick:(UIButton *)button{
    [self removeViews];
    if ([button.titleLabel.text isEqual:@"培训"]) {
        [self selected:button];
        _train = [[trainViewController alloc]init];
        [self.view addSubview:_train.view];
        [self addChildViewController:_train];
    }
    if ([button.titleLabel.text isEqual:@"留学"]) {
        [self selected:button];
        _study = [[StudyAbroadController alloc]init];
        [self.view addSubview:_study.view];
        [self addChildViewController:_study];
    }
    if ([button.titleLabel.text isEqual:@"旅游"]) {
        [self selected:button];
        _vacation = [[VacationHomeController alloc]init];
        [self.view addSubview:_vacation.view];
        [self addChildViewController:_vacation];
    }
    
}

@end
