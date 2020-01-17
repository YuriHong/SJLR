//
//  BtnCell.m
//  test——关于tableview
//
//  Created by 龙波 on 2017/9/2.
//  Copyright © 2017年 ----ggg. All rights reserved.
//

#import "BtnCell.h"
#define kbtnCell   @"btnCellID"

@implementation BtnCell

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
    BtnCell *cell = [tableview dequeueReusableCellWithIdentifier: kbtnCell];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UIView *btnView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 80)];
        [self addSubview:btnView];
        
    
        
        UIButton *btn2 = [[UIButton alloc]initWithFrame:CGRectMake (0, 0,  SCREENWIDTH*1/2, 80)];
        [btn2 setImage:[UIImage imageNamed:@"btn_allMass"] forState:UIControlStateNormal];
        [btn2 addTarget:self action:@selector(btn1Click:) forControlEvents:UIControlEventTouchUpInside];
        [btn2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn2 setTitle:@"所有社团" forState:UIControlStateNormal];
        btn2.tag = 2333;
        [btnView addSubview:btn2];
        
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(SCREENWIDTH/2, 0, 1, 80)];
        line.backgroundColor = [UIColor lightGrayColor];
        [btnView addSubview:line];
        
        UIButton *btn3 = [[UIButton alloc]initWithFrame:CGRectMake (SCREENWIDTH*1/2, 0,  SCREENWIDTH*1/2, 80)];
        [btn3 setImage:[UIImage imageNamed:@"icon_mass_activityBtn"] forState:UIControlStateNormal];
        [btn3 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn3 setTitle:@"社团活动" forState:UIControlStateNormal];
        [btn3 addTarget:self action:@selector(btn1Click:) forControlEvents:UIControlEventTouchUpInside];
        btn3.tag = 23333;
        [btnView addSubview:btn3];


        
        
        
        
    }
    return self;
}

-(void)btn1Click:(UIButton *)button
{
    if ([self.delegate respondsToSelector:@selector(didSelectAtIndexBtnCell:)]) {
        [self.delegate didSelectAtIndexBtnCell:button.tag];
    }

}






@end
