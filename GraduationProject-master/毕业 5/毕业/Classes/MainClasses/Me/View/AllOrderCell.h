//
//  AllOrderCell.h
//  test-个人
//
//  Created by 龙波 on 2017/10/31.
//  Copyright © 2017年 ----龙波. All rights reserved.
//

#import <UIKit/UIKit.h>

@class OrderItemVoListModel;
@interface AllOrderCell : UITableViewCell

+(instancetype)cellWithTableView:(UITableView *)tableview;


- (void)reloadDataWithModel:(OrderItemVoListModel *)model;

@end
