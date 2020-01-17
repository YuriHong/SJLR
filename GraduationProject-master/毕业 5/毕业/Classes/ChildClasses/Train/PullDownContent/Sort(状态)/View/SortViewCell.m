//
//  SortViewCell.m
//  搜索下拉
//
//  Created by 吴添培 on 2017/8/7.
//  Copyright © 2017年 吴添培. All rights reserved.
//

#import "SortViewCell.h"

@interface SortViewCell ()
@property (nonatomic, strong) UIImageView *cheakView;

@end

@implementation SortViewCell

- (UIImageView *)cheakView
{
    if (_cheakView == nil) {
        _cheakView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"选中对号"]];
        self.accessoryView = _cheakView;
    }
    return _cheakView;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    self.cheakView.hidden = !selected;
}

@end
