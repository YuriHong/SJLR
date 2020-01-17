//
//  LikeViewCell.m
//  毕业
//
//  Created by 龙波 on 2017/10/14.
//  Copyright © 2017年 吴添培. All rights reserved.
//

#import "LikeViewCell.h"
#define kLikeViewCell @"likeviewCellID"
@implementation LikeViewCell

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
    LikeViewCell *cell = [tableview dequeueReusableCellWithIdentifier: kLikeViewCell];
    
    cell.textLabel.text = @"🔥热门景点";
    
    
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
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
