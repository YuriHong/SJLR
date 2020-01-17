//
//  ConsigneeTableCell.h
//  test-个人
//
//  Created by 龙波 on 2017/10/27.
//  Copyright © 2017年 ----龙波. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ShoppingListModel;
@interface ConsigneeTableCell : UITableViewCell



+(instancetype)cellWithTableView:(UITableView *)tableview;
- (void)reloadDataWithModel:(ShoppingListModel*)model;
@end
