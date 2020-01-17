//
//  VacationListViewCell.h
//  毕业
//
//  Created by 龙波 on 2017/10/14.
//  Copyright © 2017年 吴添培. All rights reserved.
//

#import <UIKit/UIKit.h>

@class VacationListModel;

@interface VacationListViewCell : UITableViewCell

@property(nonatomic,strong) UIView *myView;
//旅游名字
@property(nonatomic,strong) UILabel *vacationName;

//旅游图片
@property(nonatomic,strong) UIImageView *vacationImage;

//旅游评分
@property(nonatomic,strong) UILabel *vacationScore;


//旅游价格
@property(nonatomic,strong) UILabel *vacationPrice;
//已售多少
@property(nonatomic,strong) UILabel *vacationQuantity;



+(instancetype)cellWithTableView:(UITableView *)tableview;
- (void)reloadDataWithModel:(VacationListModel *)model;



@end
