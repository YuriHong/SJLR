//
//  OrderFooterView.m
//  test-个人
//
//  Created by 龙波 on 2017/10/26.
//  Copyright © 2017年 ----龙波. All rights reserved.
//

#import "OrderFooterView.h"

@interface OrderFooterView ()
@property (strong,nonatomic)UILabel *titleLabel;
@property (strong,nonatomic)UIButton *button;
@property(nonatomic,strong) UILabel *statusLabel;

@end


@implementation OrderFooterView


- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self setupUI];
        self.contentView.backgroundColor = [UIColor whiteColor];
    }
    
    return self;
}



- (void)setupUI {
    
//    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
//    button.frame = CGRectMake(5, 15, 50, 30);
//
//    [button setImage:[UIImage imageNamed:@"cart_unSelect_btn"] forState:UIControlStateNormal];
//    [button setImage:[UIImage imageNamed:@"cart_selected_btn"] forState:UIControlStateSelected];
//    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
//    [self.contentView addSubview:button];
//    self.button = button;
    
    UILabel *label = [[UILabel alloc]init];
    label.frame = CGRectMake(10, 0, SCREENWIDTH - 100, 40);
//    label.backgroundColor = RandColor;
    label.font = [UIFont systemFontOfSize:14];
    label.text = @"编号111111111";
    self.titleLabel = label;
    [self.contentView addSubview:label];
    
    UILabel *status = [[UILabel alloc]init];
    status.frame = CGRectMake(SCREENWIDTH-120, 0, 100, 40);
    status.textAlignment = NSTextAlignmentCenter;
    status.textColor = RGBColor(228, 94, 0);
    self.statusLabel = status;
    [self.contentView addSubview:status];
}
//- (void)buttonClick:(UIButton*)button {
//    button.selected = !button.selected;
//    
//    if (self.dwqClickBlock) {
//        self.dwqClickBlock(button.selected);
//    }
//}
//
//- (void)setSelect:(BOOL)select {
//    
//    self.button.selected = select;
//    _select = select;
//}
//
- (void)setTitle:(NSString *)title {
    self.titleLabel.text = title;
    _title = title;
}

- (void)setStatusTitle:(NSString *)statusTitle
{
    self.statusLabel.text = statusTitle;
    _statusTitle = statusTitle;
}

@end
