//
//  MassProductListCell.m
//  毕业设计
//
//  Created by 龙波 on 2017/9/18.
//  Copyright © 2017年 ----龙波. All rights reserved.
//

#import "MassProductListCell.h"
#import "MassMainModel.h"
#import <SDWebImage/UIImageView+WebCache.h>
#define kmassproductCell @"massproductCellID"

@implementation MassProductListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (instancetype)cellWithTableView:(UITableView *)tableview
{
    MassProductListCell *cell = [tableview dequeueReusableCellWithIdentifier:kmassproductCell];
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
    CGContextStrokeRect(context, CGRectMake(132, rect.size.height, rect.size.width-132, (1/[UIScreen mainScreen].scale))); //SINGLE_LINE_HEIGHT 为线的高度
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.myView = [[UIView alloc]init];
        [self.myView setBackgroundColor:[UIColor redColor]];
    
        self.productName = [[UILabel alloc]initWithFrame:CGRectMake(132, 10,  170, 50)];
        self.productName.textAlignment = NSTextAlignmentLeft;
        self.productName.textColor = [UIColor blackColor];
        self.productName.font = [UIFont fontWithName:@"Helvetica-Bold" size:15.0];
    
        self.ProductSubtitle = [[UILabel alloc]initWithFrame:CGRectMake(132, 55, 100, 45)];
        self.ProductSubtitle.textAlignment = NSTextAlignmentLeft;
        self.ProductSubtitle.textColor = [UIColor redColor];
        [self.ProductSubtitle setFont:[UIFont systemFontOfSize:12]];
        
        self.productPrice = [[UILabel alloc]initWithFrame:CGRectMake(132 , 90, 170, 45)];
        self.productPrice.textAlignment = NSTextAlignmentLeft;
        self.productPrice.textColor = [UIColor redColor];
        self.productPrice.font = [UIFont systemFontOfSize:15];
        
        self.productImage = [[UIImageView alloc]initWithFrame:CGRectMake(16, 9, 109, 109)];
        self.productImage.backgroundColor = RandColor;
        self.productImage.contentMode = UIViewContentModeScaleAspectFill;
        self.productImage.clipsToBounds = YES;

        self.contentView.backgroundColor = [UIColor clearColor];
        
        [self.contentView addSubview:_myView];
        [self.myView addSubview:_productName];
        [self.myView addSubview:_ProductSubtitle];
        [self.myView addSubview:_productPrice];
        [self.myView addSubview:_productImage];

    
    
    
    }
    return self;
}

- (void)reloadDataWithModel:(MassMainModel *)model
{
    NSString *imagUrl = [NSString stringWithFormat:@"http://47.93.33.181/longboImage/%@",model.mainImage];
    [self.productImage sd_setImageWithURL:[NSURL URLWithString:imagUrl] placeholderImage:[UIImage imageNamed:@"qianlan"]];
    self.ProductSubtitle.text = model.subtitle;
    self.productName.text = model.name;
    self.productPrice.text = [NSString stringWithFormat:@"¥ %@",model.price];
}


@end
