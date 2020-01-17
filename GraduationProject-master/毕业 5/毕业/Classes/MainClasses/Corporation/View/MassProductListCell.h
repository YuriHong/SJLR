//
//  MassProductListCell.h
//  毕业设计
//
//  Created by 龙波 on 2017/9/18.
//  Copyright © 2017年 ----龙波. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MassMainModel;
@interface MassProductListCell : UITableViewCell

@property(nonatomic,strong) UIView *myView;
//产品名字
@property(nonatomic,strong) UILabel *productName;

//产品图片
@property(nonatomic,strong) UIImageView *productImage;

//社团活动的标题
@property(nonatomic,strong) UILabel *productPrice;
//社团活动时间
@property(nonatomic,strong) UILabel *ProductSubtitle;






+ (instancetype)cellWithTableView:(UITableView *)tableview;

- (void)reloadDataWithModel:(MassMainModel *)model;

@end
