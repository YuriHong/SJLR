//
//  MyOrderCell.m
//  test-个人
//
//  Created by 龙波 on 2017/10/22.
//  Copyright © 2017年 ----龙波. All rights reserved.
//

#import "MyOrderCell.h"
#define kMyOrderCell @"myorderCellID"

@interface MyOrderCell ()
@property (strong,nonatomic)UILabel *titleLabel;
@property (strong,nonatomic)UIButton *button;
@property(nonatomic,strong) UILabel *statusLabel;


@end

@implementation MyOrderCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
+(instancetype)cellwithTableView:(UITableView *)tableview
{
    MyOrderCell *cell = [tableview dequeueReusableCellWithIdentifier: kMyOrderCell];
    

    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupUI];
    }
    return self;
}


- (void)setupUI
{
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

- (void)setTitle:(NSString *)title {
    self.titleLabel.text = title;
    _title = title;
}

- (void)setStatusTitle:(NSString *)statusTitle
{
    self.statusLabel.text = statusTitle;
    _statusTitle = statusTitle;
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [UIColor clearColor].CGColor);
    CGContextFillRect(context, rect);
    //下分割线
    CGContextSetStrokeColorWithColor(context, [UIColor grayColor].CGColor);
    CGContextStrokeRect(context, CGRectMake(0, rect.size.height, rect.size.width, (1/[UIScreen mainScreen].scale))); //SINGLE_LINE_HEIGHT 为线的高度
}

@end
