//
//  OrderItemCell.m
//  test-个人
//
//  Created by 龙波 on 2017/10/28.
//  Copyright © 2017年 ----龙波. All rights reserved.
//

#import "OrderItemCell.h"
#import "UIView+SYWLExtension.h"
#import "OderItemListModel.h"
#import "UIView+ BorderLine.h"
#import <SDWebImage/UIImageView+WebCache.h>
#define korderitemcell @"orderitemCellID"

@interface OrderItemCell ()
@property(nonatomic,strong) UIView *myView;

@property(nonatomic,strong) UILabel *titileLabel;
@property(nonatomic,strong) UILabel *priceLabel;

@property(nonatomic,strong) UILabel *numberLabel;
@property(nonatomic,strong) UILabel *nowPriceLabel;
@property(nonatomic,strong) UIImageView *mainImage;

@end

@implementation OrderItemCell

+(instancetype)cellWithTableView:(UITableView *)tableview
{
    OrderItemCell *cell =[tableview dequeueReusableCellWithIdentifier: korderitemcell ];
//    cell.mainImage.image = [UIImage imageNamed:@"头3"];
    //cell.nowPriceLabel.text = @"10000";
  //  cell.priceLabel.text = @"20000";
  //  cell.numberLabel.text = @"2";
    //cell.titileLabel.text = @"测试名字长短的地方似懂非懂撒风大数据分类卡圣诞节福利卡的发";
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return  cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setUpUI];
    }
    return self;
}

-(void)setUpUI
{
    _myView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, self.height)];
    
    [self.contentView borderForColor:RGBAColor(247, 247, 247, 1) borderWidth:3 borderType:UIBorderSideTypeBottom];
    
    self.titileLabel = [[UILabel alloc]initWithFrame:CGRectMake(40, 0, SCREENWIDTH/2, 40)];
    self.titileLabel .textColor = [UIColor blackColor];
    self.titileLabel .textAlignment = NSTextAlignmentLeft;
    //        self.titileLabel .backgroundColor = RandColor;
    
    _mainImage = [[UIImageView alloc]initWithFrame:CGRectMake(10, 45, 100, 100)];
    //        _mainImage.backgroundColor = RandColor;
    
    
    
    
    _priceLabel = [[UILabel alloc ]initWithFrame:CGRectMake(125, 110, 79, 40)];
    //        _priceLabel.backgroundColor = RandColor;
    _priceLabel.textColor = [UIColor blackColor];
    _priceLabel.textAlignment = NSTextAlignmentCenter;
    
    _nowPriceLabel = [[UILabel alloc]initWithFrame:CGRectMake(SCREENWIDTH - 130, 60, 80, 25)];
    _nowPriceLabel.textColor =  RGBColor(228, 94, 0);
    _nowPriceLabel.textAlignment = NSTextAlignmentCenter;
    
    //        _nowPriceLabel.backgroundColor = RandColor;
    
    
    
    
    
    //数量显示
    UILabel* numberLabel = [[UILabel alloc]init];
    numberLabel.frame = CGRectMake(SCREENWIDTH - 130, 120, 80, 25);
    numberLabel.textAlignment = NSTextAlignmentCenter;
    numberLabel.text = @"1";
    numberLabel.font = [UIFont systemFontOfSize:16];
    //        numberLabel.backgroundColor = RandColor;
    [_myView addSubview:numberLabel];
    self.numberLabel = numberLabel;
    
    
    
    
    [_myView addSubview:_titileLabel];
    [_myView addSubview:_priceLabel];
    [_myView addSubview:_numberLabel];
    [_myView addSubview:_nowPriceLabel];
    [_myView addSubview:_mainImage];
    [self.contentView addSubview:_myView];
    
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [UIColor clearColor].CGColor);
    CGContextFillRect(context, rect);
    //下分割线
    CGContextSetStrokeColorWithColor(context, [UIColor grayColor].CGColor);
    CGContextStrokeRect(context, CGRectMake(0, rect.size.height, rect.size.width, (100/[UIScreen mainScreen].scale)*3)); //SINGLE_LINE_HEIGHT 为线的高度
}

- (void)reloadDataWithModel:(OderItemListModel *)model
{
    NSString *imagUrl = [NSString stringWithFormat:@"http://47.93.33.181/longboImage/%@",model.productImage];
    [self.mainImage sd_setImageWithURL:[NSURL URLWithString:imagUrl] placeholderImage:[UIImage imageNamed:@"qianlan"]];
    self.titileLabel.text = model.productName;
    self.numberLabel.text = [NSString stringWithFormat:@"X%@",model.quantity];
    self.priceLabel.text = [NSString stringWithFormat:@"¥ %@",model.currentUnitPrice];
    self.nowPriceLabel.text = [NSString stringWithFormat:@"¥ %@",model.totalPrice];
}

@end
