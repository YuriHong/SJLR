//
//  VacationListViewCell.m
//  毕业
//
//  Created by 龙波 on 2017/10/14.
//  Copyright © 2017年 吴添培. All rights reserved.
//

#import "VacationListViewCell.h"
#import "VacationListModel.h"
#import <SDWebImage/UIImageView+WebCache.h>
#define kVacationListViewCell @"vacationlistviewCellID"
@implementation VacationListViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+(instancetype)cellWithTableView:(UITableView *)tableview
{
    VacationListViewCell *cell =[tableview dequeueReusableCellWithIdentifier: kVacationListViewCell];
    
        return cell;
    
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self  = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.myView = [[UIView alloc]init];
        [self.myView setBackgroundColor:[UIColor redColor]];
 
        self.vacationName = [[UILabel alloc]initWithFrame:CGRectMake(132, 0,  200, 45)];
        self.vacationName.textAlignment = NSTextAlignmentLeft;
        self.vacationName.textColor = [UIColor blackColor];
        self.vacationName.font = [UIFont fontWithName:@"Helvetica-Bold" size:20.0];
        
        self.vacationScore = [[UILabel alloc]initWithFrame:CGRectMake(132, 20, 100, 60)];
        self.vacationScore.textAlignment =NSTextAlignmentLeft;
        self.vacationScore.textColor = [UIColor grayColor];
        self.vacationScore.font = [UIFont systemFontOfSize:17];
        
        self.vacationQuantity = [[UILabel alloc]initWithFrame:CGRectMake(SCREENWIDTH - 100, 90, 180, 45)];
        self.vacationQuantity.textColor =[UIColor grayColor];
        self.vacationQuantity.textAlignment = NSTextAlignmentLeft;
        self.vacationQuantity.font = [UIFont systemFontOfSize:13];
        
        
        self.vacationPrice = [[UILabel alloc]initWithFrame:CGRectMake(132 , 85, 170, 35)];
        self.vacationPrice.textAlignment = NSTextAlignmentLeft;
//        self.vacationPrice.backgroundColor = [UIColor blackColor];
        self.vacationPrice.textColor = [UIColor redColor];
        self.vacationPrice.font = [UIFont systemFontOfSize:18];
        
        self.vacationImage = [[UIImageView alloc]initWithFrame:CGRectMake(16, 9, 109, 109)];
        self.vacationImage.contentMode = UIViewContentModeScaleToFill;
//        self.vacationImage.clipsToBounds = YES;
        self.vacationImage.backgroundColor = [UIColor redColor];
        self.contentView.backgroundColor = [UIColor clearColor];
        
        [self.contentView addSubview:_myView];
        [_myView addSubview:_vacationName];
        [_myView addSubview:_vacationPrice];
        [_myView addSubview:_vacationImage];
        [_myView addSubview:_vacationScore];
        [_myView addSubview:_vacationQuantity];
        
    }
    return self;
    
}

- (void)reloadDataWithModel:(VacationListModel *)model
{
    NSString *urlStr = [NSString stringWithFormat:@"http://47.93.33.181/longboImage/%@",model.mainImage];
    [self.vacationImage sd_setImageWithURL:[NSURL URLWithString:urlStr] placeholderImage:[UIImage imageNamed:@"qianlan"]];
    self.vacationName.text = model.name;
    self.vacationPrice.text = [NSString stringWithFormat:@"¥%@",model.price];
    self.vacationScore.text = model.subtitle;
    NSLog(@"%@",model.subImages);
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [UIColor clearColor].CGColor);
    CGContextFillRect(context, rect);
    //下分割线
    CGContextSetStrokeColorWithColor(context, [UIColor grayColor].CGColor);
    CGContextStrokeRect(context, CGRectMake(20, rect.size.height, rect.size.width, (1/[UIScreen mainScreen].scale))); //SINGLE_LINE_HEIGHT 为线的高度
}


@end
