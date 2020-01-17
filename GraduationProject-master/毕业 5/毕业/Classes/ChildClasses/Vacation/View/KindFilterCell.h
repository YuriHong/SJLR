//
//  KindFilterCell.h
//  毕业
//
//  Created by 龙波 on 2017/10/17.
//  Copyright © 2017年 吴添培. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KindFilterCell : UITableViewCell
+(instancetype)cellWithTableView:(UITableView *)tableView bigGroupName:(NSString *)bigGroupName;
@property(nonatomic,strong) NSString *bigGroupName;

@property(nonatomic,strong) UILabel *nameLabel;



@end
