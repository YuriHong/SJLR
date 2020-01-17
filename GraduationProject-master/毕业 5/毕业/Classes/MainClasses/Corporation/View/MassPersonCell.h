//
//  MassPersonCell.h
//  毕业设计
//
//  Created by 龙波 on 2017/9/7.
//  Copyright © 2017年 吴添培. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MassPersonCell : UITableViewCell

@property(nonatomic,strong) UILabel *numberLabel;

@property(nonatomic,assign) NSInteger count;

@property(nonatomic,strong) UIImageView *headView;

+ (instancetype)cellWithTableView:(UITableView *)tableview;

@end
