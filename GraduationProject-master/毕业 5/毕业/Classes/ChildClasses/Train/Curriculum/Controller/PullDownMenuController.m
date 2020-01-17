//
//  DDMenuController.m
//  校园帮(用户)
//
//  Created by 吴添培 on 2017/8/9.
//  Copyright © 2017年 吴添培. All rights reserved.
//

#import "PullDownMenuController.h"
#import "SortViewController.h"
#import "twoMenuController.h"
#import "menuButton.h"
#import "menuModel.h"

@interface PullDownMenuController ()<PullDownMenuDataSource,PullDownMenuDelegate>
@property (nonatomic, copy) NSArray *titles;

@end

@implementation PullDownMenuController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setUpdropMenu];
}

-(void)setUpdropMenu{
    // 创建下拉菜单
    PullDownMenu *menu = [[PullDownMenu alloc] init];
    menu.delegate = self;
    menu.frame = CGRectMake(0, 0, SCREENWIDTH, 44);
    [self.view addSubview:menu];
    
    // 设置下拉菜单代理
    menu.dataSource = self;
    
    // 初始化标题
    _titles = @[@"培训",@"排序"];
    
    // 添加子控制器
    [self setupAllChildViewController];
}

-(void)PullDownMenuWithStr:(NSString *)str{
    if ([_delegate respondsToSelector:@selector(PullDownMenuControllerWithString:)]) {
        [_delegate PullDownMenuControllerWithString:str];
    }
}

#pragma mark - 添加子控制器
- (void)setupAllChildViewController
{
    twoMenuController *menu = [[twoMenuController alloc] init];
    menu.twoMenu = [menuModel getMenuMessageWithPlistResource:@"AllCourse"];
    SortViewController *sort = [[SortViewController alloc] init];
    sort.titleArray = @[@"价格升序",@"价格降序"];
    [self addChildViewController:menu];
    [self addChildViewController:sort];
}

#pragma mark - YZPullDownMenuDataSource
// 返回下拉菜单多少列
- (NSInteger)numberOfColsInMenu:(PullDownMenu *)pullDownMenu
{
    return _titles.count;
}

// 返回下拉菜单每列按钮
- (UIButton *)pullDownMenu:(PullDownMenu *)pullDownMenu buttonForColAtIndex:(NSInteger)index
{
    menuButton *button = [menuButton buttonWithType:UIButtonTypeCustom];
    //[button setBackgroundImage:[UIImage imageNamed:@"login"] forState:UIControlStateNormal];
    [button setTitle:_titles[index] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont fontWithName:@"HYQuanTangShiJ" size:16];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor colorWithRed:25 /255.0 green:143/255.0 blue:238/255.0 alpha:1] forState:UIControlStateSelected];
    [button setImage:[UIImage imageNamed:@"标签-向下箭头"] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"标签-向上箭头"] forState:UIControlStateSelected];
    
    return button;
}

// 返回下拉菜单每列对应的控制器
- (UIViewController *)pullDownMenu:(PullDownMenu *)pullDownMenu viewControllerForColAtIndex:(NSInteger)index
{
    return self.childViewControllers[index];
}

// 返回下拉菜单每列对应的高度
- (CGFloat)pullDownMenu:(PullDownMenu *)pullDownMenu heightForColAtIndex:(NSInteger)index
{
    // 第1列 高度
    if (index == 0) {
        return 400;
    }else{
        return 120;
    }
}


@end
