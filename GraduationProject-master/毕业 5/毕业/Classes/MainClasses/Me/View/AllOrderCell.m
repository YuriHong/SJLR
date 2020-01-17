//
//  AllOrderCell.m
//  test-个人
//
//  Created by 龙波 on 2017/10/31.
//  Copyright © 2017年 ----龙波. All rights reserved.
//

#import "AllOrderCell.h"
#import "UIView+SYWLExtension.h"
#import "UIView+ BorderLine.h"
#import "OrderItemVoListModel.h"
#import <SDWebImage/UIImageView+WebCache.h>
#define kallordercell @"allorderCellID"

@interface AllOrderCell ()
@property(nonatomic,strong) UIView *myView;

@property(nonatomic,strong) UILabel *titileLabel;
@property(nonatomic,strong) UILabel *priceLabel;
@property(nonatomic,strong) UILabel *statusLable;

@property(nonatomic,strong) UILabel *numberLabel;
@property(nonatomic,strong) UILabel *nowPriceLabel;
@property(nonatomic,strong) UIImageView *mainImage;

@end

@implementation AllOrderCell

+(instancetype)cellWithTableView:(UITableView *)tableview
{
    AllOrderCell *cell =[tableview dequeueReusableCellWithIdentifier: kallordercell ];
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
    
//    [self.contentView borderForColor:RGBAColor(247, 247, 247, 1) borderWidth:10 borderType:UIBorderSideTypeBottom];
    
    self.titileLabel = [[UILabel alloc]initWithFrame:CGRectMake(40, 0, SCREENWIDTH/2, 40)];
    self.titileLabel .textColor = [UIColor blackColor];
    self.titileLabel .textAlignment = NSTextAlignmentLeft;
    //        self.titileLabel .backgroundColor = RandColor;
    
    self.statusLable =[[UILabel alloc]initWithFrame:CGRectMake(SCREENWIDTH-100, 0, 100, 40)];
    self.statusLable.textColor =RGBColor(228, 94, 0);
    self.statusLable.textAlignment = NSTextAlignmentCenter;
//    self.statusLable.backgroundColor = RandColor;
    
    
    _mainImage = [[UIImageView alloc]initWithFrame:CGRectMake(10, 45, 100, 100)];
    //        _mainImage.backgroundColor = RandColor;
    
    _priceLabel = [[UILabel alloc ]initWithFrame:CGRectMake(125, 70, 79, 40)];
    //        _priceLabel.backgroundColor = RandColor;
    _priceLabel.textColor = [UIColor blackColor];
    _priceLabel.textAlignment = NSTextAlignmentLeft;
    
    _nowPriceLabel = [[UILabel alloc]initWithFrame:CGRectMake(SCREENWIDTH - 130, 60, 80, 25)];
    _nowPriceLabel.textColor =  RGBColor(228, 94, 0);
    _nowPriceLabel.textAlignment = NSTextAlignmentLeft;
    
    //        _nowPriceLabel.backgroundColor = RandColor;
    
    //数量显示
    UILabel* numberLabel = [[UILabel alloc]init];
    numberLabel.frame = CGRectMake(125, 110, 50, 25);
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
//    [_myView addSubview:_statusLable];
    [self.contentView addSubview:_myView];
    
}

- (void)reloadDataWithModel:(OrderItemVoListModel *)model
{
    NSString *imagUrl = [NSString stringWithFormat:@"http://47.93.33.181/longboImage/%@",model.productImage];
    [self.mainImage sd_setImageWithURL:[NSURL URLWithString:imagUrl] placeholderImage:[UIImage imageNamed:@"qianlan"]];
    self.titileLabel.text = model.productName;
    self.numberLabel.text = [NSString stringWithFormat:@"X%@",model.quantity];
    self.priceLabel.text =[NSString stringWithFormat:@"¥%@", model.currentUnitPrice];
    self.nowPriceLabel.text =[NSString stringWithFormat:@"¥%@", model.totalPrice];
    
}
@end
