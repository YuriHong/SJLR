//
//  ConsigneeTableCell.m
//  test-个人
//
//  Created by 龙波 on 2017/10/27.
//  Copyright © 2017年 ----龙波. All rights reserved.
//

#import "ConsigneeTableCell.h"
#import "UIView+SYWLExtension.h"
#import "ShoppingListModel.h"
#import "UIView+ BorderLine.h"
#define kconsigneetablecell @"consigneetableCellID"

@interface ConsigneeTableCell ()<UITextViewDelegate>

@property(nonatomic,strong) UILabel *nameLable;
@property(nonatomic,strong) UILabel *phoneLable;
@property(nonatomic,strong) UITextView *placeLabel;


@end

@implementation ConsigneeTableCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

+(instancetype)cellWithTableView:(UITableView *)tableview
{
    ConsigneeTableCell *cell = [tableview dequeueReusableCellWithIdentifier: kconsigneetablecell];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setUpUi];
    }
    return self;
    
}

- (void)setUpUi{
    
    UIView *myView = [[UIView alloc]init];
    [self.contentView addSubview:myView];
    
    [self.contentView borderForColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"borderForColor_line"]] borderWidth:10 borderType:UIConsigneeBorderSideTypeRight];
    
    
    UILabel *consigneeLabel = [[UILabel alloc]initWithFrame:CGRectMake(30, 10, 60, 40)];
//    consigneeLabel.backgroundColor = RandColor;
    consigneeLabel.text = @"收货人: ";
    [myView addSubview:consigneeLabel];
    
    UILabel *nameLable = [[UILabel alloc]initWithFrame:CGRectMake(consigneeLabel.x+consigneeLabel.width+5, consigneeLabel.y, 80, consigneeLabel.height)];
//    nameLable.backgroundColor = RandColor;
    _nameLable = nameLable;
    [myView addSubview:nameLable];
    
    UILabel *phoneLable = [[UILabel alloc]initWithFrame:CGRectMake(nameLable.x +nameLable.width+ 50, nameLable.y, SCREENWIDTH - 265, nameLable.height)];
//    phoneLable.backgroundColor = RandColor;
    _phoneLable = phoneLable;
    [myView addSubview:phoneLable];
    
    UITextView *placeLabel = [[UITextView alloc]initWithFrame:CGRectMake(consigneeLabel.x-5, consigneeLabel.y+consigneeLabel.height, SCREENWIDTH - 80, 70)];
//    placeLabel.backgroundColor = RandColor;
    _placeLabel = placeLabel;
    placeLabel.font = [UIFont systemFontOfSize:18];
    placeLabel.delegate = self;
    [myView addSubview:placeLabel];
    
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


-(void)reloadDataWithModel:(ShoppingListModel *)model
{
    self.nameLable.text = model.receiverName;
    self.phoneLable.text = model.receiverPhone;
    self.placeLabel.text = [NSString stringWithFormat:@"收货地址： %@%@%@%@%@",model.receiverProvince,model.receiverCity,model.receiverDistrict,model.receiverAddress,model.receiverZip];
}
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    return NO;
}


@end
