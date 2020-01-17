//
//  OrderTableViewCell.m
//  test-个人
//
//  Created by 龙波 on 2017/10/25.
//  Copyright © 2017年 ----龙波. All rights reserved.
//

#import "OrderTableViewCell.h"
#import "UIView+SYWLExtension.h"
#import "CartListModel.h"
#import "UIView+ BorderLine.h"
#import <SDWebImage/UIImageView+WebCache.h>
#define kordertableviewcell @"ordertableviewCellID"


@interface OrderTableViewCell ()
{

    CellSelectedBlock  cellSelectedBlock;
    NumberChangedBlock numberAddBlock;
    NumberChangedBlock numberCutBlock;

}


@end
@implementation OrderTableViewCell


+ (instancetype)cellWithTableView:(UITableView *)tableview
{
    OrderTableViewCell *cell = [tableview dequeueReusableCellWithIdentifier: kordertableviewcell];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _myView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, self.height)];
        
        //        [self.contentView borderForColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"borderForColor_line"]] borderWidth:10 borderType:UIBorderSideTypeBottom];
        
        [self.contentView borderForColor:RGBAColor(128, 128, 128, 0.3) borderWidth:3 borderType:UIBorderSideTypeBottom];
        
        self.titileLabel = [[UILabel alloc]initWithFrame:CGRectMake(40, 0, SCREENWIDTH/2, 40)];
        self.titileLabel .textColor = [UIColor blackColor];
        self.titileLabel .textAlignment = NSTextAlignmentLeft;
        //        self.titileLabel .backgroundColor = RandColor;
        
        _mainImage = [[UIImageView alloc]initWithFrame:CGRectMake(45, 45, 100, 100)];
        //        _mainImage.backgroundColor = RandColor;
        
        
        //选中按钮
        UIButton* selectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        selectBtn.center = CGPointMake(20, 150/2.0);
        selectBtn.bounds = CGRectMake(0, 0, 30, 30);
        [selectBtn setImage:[UIImage imageNamed:@"cart_unSelect_btn"] forState:UIControlStateNormal];
        [selectBtn setImage:[UIImage imageNamed:@"cart_selected_btn"] forState:UIControlStateSelected];
        [selectBtn addTarget:self action:@selector(selectBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        self.selectBtn = selectBtn;
        
        
        _priceLabel = [[UILabel alloc ]initWithFrame:CGRectMake(155, 110, 79, 40)];
        //        _priceLabel.backgroundColor = RandColor;
        _priceLabel.textColor = [UIColor blackColor];
        _priceLabel.textAlignment = NSTextAlignmentLeft;
        
        _nowPriceLabel = [[UILabel alloc]initWithFrame:CGRectMake(SCREENWIDTH - 100, 60, 80, 25)];
        _nowPriceLabel.textColor = RGBColor(228, 94, 0);
        _nowPriceLabel.textAlignment = NSTextAlignmentLeft;
        
        //数量显示
        UILabel* numberLabel = [[UILabel alloc]init];
        numberLabel.frame = CGRectMake(SCREENWIDTH - 100, 125, 50, 25);
        numberLabel.textAlignment = NSTextAlignmentCenter;
        numberLabel.text = @"1";
        numberLabel.font = [UIFont systemFontOfSize:15];
        //        numberLabel.backgroundColor = RandColor;
        [_myView addSubview:numberLabel];
        self.numberLabel = numberLabel;
        
        //数量加按钮
        UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        addBtn.frame = CGRectMake(numberLabel.x +50, numberLabel.y, 25, 25);
        [addBtn setImage:[UIImage imageNamed:@"cart_addBtn_nomal"] forState:UIControlStateNormal];
        [addBtn setImage:[UIImage imageNamed:@"cart_addBtn_highlight"] forState:UIControlStateHighlighted];
        [addBtn addTarget:self action:@selector(addBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:addBtn];
        
        //数量减按钮
        UIButton *cutBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        cutBtn.frame = CGRectMake(numberLabel.x - 20, numberLabel.y, 25, 25);
        [cutBtn setImage:[UIImage imageNamed:@"cart_cutBtn_nomal"] forState:UIControlStateNormal];
        [cutBtn setImage:[UIImage imageNamed:@"cart_cutBtn_highlight"] forState:UIControlStateHighlighted];
        [cutBtn addTarget:self action:@selector(cutBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:cutBtn];
        
        
        
        [_myView addSubview:_titileLabel];
        [_myView addSubview:_priceLabel];
        [_myView addSubview:_numberLabel];
        [_myView addSubview:_nowPriceLabel];
        [_myView addSubview:_mainImage];
        [self.contentView addSubview:_selectBtn];
        [self.contentView addSubview:_myView];
        
    }
    return self;
}




- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [UIColor clearColor].CGColor);
    CGContextFillRect(context, rect);
    //下分割线
    CGContextSetStrokeColorWithColor(context, [UIColor grayColor].CGColor);
    CGContextStrokeRect(context, CGRectMake(0, rect.size.height, rect.size.width, (100/[UIScreen mainScreen].scale))); //SINGLE_LINE_HEIGHT 为线的高度
}


//- (void)reloadDataWithModel:(CartListModel*)model {
//
//    self.mainImage.image = ;
////    self.nameLabel.text = model.goodsName;
////    self.priceLabel.text = model.price;
////    self.dateLabel.text = model.price;
////    self.numberLabel.text = [NSString stringWithFormat:@"%ld",(long)model.count];
////    //    self.sizeLabel.text = model.sizeStr;
////    self.selectBtn.selected = model.select;
//}
-(void)reloadDataWithModel:(CartListModel *)model
{
    NSString *imagUrl = [NSString stringWithFormat:@"http://47.93.33.181/longboImage/%@",model.productMainImage];
    
    [self.mainImage sd_setImageWithURL:[NSURL URLWithString:imagUrl] placeholderImage:[UIImage imageNamed:@"qianlan"]];
    self.titileLabel.text = model.productName;
    self.priceLabel.text = [NSString stringWithFormat:@"¥ %@",model.productPrice];
    self.nowPriceLabel.text = [NSString stringWithFormat:@"¥ %@",model.productTotalPrice];
    self.numberLabel.text = [NSString stringWithFormat:@"%@",model.quantity];
    self.selectBtn.selected = model.select;
    NSLog(@"价格：%@，数量：%@,",[NSString stringWithFormat:@"%ld",(long)model.productPrice],[NSString stringWithFormat:@"%ld",(long)model.quantity]);
}


- (void)cellSelectedWithBlock:(CellSelectedBlock)block {
    cellSelectedBlock = block;
}

-(void)numberAddWithBlock:(NumberChangedBlock)block
{
    numberAddBlock = block;
}

-(void)numberCutWithBlock:(NumberChangedBlock)block
{
    numberCutBlock = block;
}

#pragma mark - 重写setter方法

- (void)setgoodSelected:(BOOL)goodSelected {
    _goodSelected = goodSelected;
    self.selectBtn.selected = goodSelected;
}

- (void)selectBtnClick:(UIButton*)button {
    NSLog(@"我点了吗？");
    button.selected = !button.selected;
    
    if (cellSelectedBlock) {
        cellSelectedBlock(button.selected);

    }
}

-(void)addBtnClick:(UIButton *)buuton
{
    NSInteger count = [self.numberLabel.text integerValue];
    count++;
    
    if (numberAddBlock) {
        numberAddBlock(count);
    }
    
}

- (void)cutBtnClick:(UIButton*)button {
    NSInteger count = [self.numberLabel.text integerValue];
    count--;
    if(count <= 0){
        return ;
    }
    
    if (numberCutBlock) {
        numberCutBlock(count);
    }
}







@end
