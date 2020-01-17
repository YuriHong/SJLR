//
//  MassTableViewCell.h
//  毕业设计
//
//  Created by 龙波 on 2017/8/17.
//  Copyright © 2017年 吴添培. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MassMainModel;
@interface MassTableViewCell : UITableViewCell

@property(nonatomic,strong) UIView *myView;
//社团名字
@property(nonatomic,strong) UILabel *MassnameLabel;
//社团活动的标题
@property(nonatomic,strong) UILabel *titileLabel;
//社团活动时间
@property(nonatomic,strong) UILabel *timeLabel;
//社团活动地点
@property(nonatomic,strong) UILabel *placeLabel;
//活动标题图片
@property(nonatomic,strong) UIImageView *titileImage;


+(instancetype)cellWithTabelView:(UITableView *)tableview;
- (void)reloadDataWithModel:(MassMainModel *)model;

@end
