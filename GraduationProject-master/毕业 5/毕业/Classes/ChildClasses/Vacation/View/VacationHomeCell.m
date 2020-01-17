//
//  VacationHomeCell.m
//  毕业
//
//  Created by 龙波 on 2017/10/13.
//  Copyright © 2017年 吴添培. All rights reserved.
//

#import "VacationHomeCell.h"
#import "VaMenuBtnView.h"
//#define kVacationHomeCell @"VacationHomeCellID"


@interface VacationHomeCell ()<VacationHomeCellDelegate>

@property(nonatomic,strong) UIView *firstBgView;


@end

@implementation VacationHomeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

+(instancetype)cellWithTableView:(UITableView *)tableview menuArray:(NSArray *)menuArray
{    static NSString *kVacationHomeCell = @"VacationHomeCellID";

    VacationHomeCell *cell = [tableview dequeueReusableCellWithIdentifier: kVacationHomeCell];
    if (cell == nil) {
        cell = [[VacationHomeCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kVacationHomeCell menuArray:menuArray];
    }
    return cell;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier menuArray:(NSArray *)menuArray
{
    self =[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _firstBgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 160)];
//        _firstBgView.backgroundColor = [UIColor redColor];
        [self addSubview:_firstBgView];
        
        for (int i = 0; i < 8; i++) {
            if (i < 4) {
                CGRect frame = CGRectMake(i*SCREENWIDTH/4, 0, SCREENWIDTH/4, 80);
                NSString *title = [menuArray[i] objectForKey:@"title"];
                NSString *imageStr = [menuArray[i] objectForKey:@"image"];
                VaMenuBtnView *btnView = [[VaMenuBtnView alloc] initWithFrame:frame title:title imageStr:imageStr];
                btnView.tag = 10+i;
                [_firstBgView addSubview:btnView];
                UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(OnTapBtnView:)];
                [btnView addGestureRecognizer:tap];
                
            }else if(i<8){
                CGRect frame = CGRectMake((i-4)*SCREENWIDTH/4, 80, SCREENWIDTH/4, 80);
                NSString *title = [menuArray[i] objectForKey:@"title"];
                NSString *imageStr = [menuArray[i] objectForKey:@"image"];
                VaMenuBtnView *btnView = [[VaMenuBtnView alloc] initWithFrame:frame title:title imageStr:imageStr];
                btnView.tag = 10+i;
                [_firstBgView addSubview:btnView];
                UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(OnTapBtnView:)];
                [btnView addGestureRecognizer:tap];

    }
            
}
    }
    return self;
}
-(void)OnTapBtnView:(UITapGestureRecognizer*)sender{
    NSLog(@"%ld",sender.view.tag);
    if ([self.delegate respondsToSelector:@selector(homeMenuCellClick:)]) {
        [self.delegate homeMenuCellClick:(NSInteger)sender.view.tag];
    }
}



@end
