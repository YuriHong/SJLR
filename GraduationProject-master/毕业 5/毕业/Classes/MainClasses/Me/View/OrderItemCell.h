//
//  OrderItemCell.h
//  test-个人
//
//  Created by 龙波 on 2017/10/28.
//  Copyright © 2017年 ----龙波. All rights reserved.
//

#import <UIKit/UIKit.h>

@class OderItemListModel;
@interface OrderItemCell : UITableViewCell



+(instancetype)cellWithTableView:(UITableView *)tableview;

- (void)reloadDataWithModel:(OderItemListModel*)model;

@end
