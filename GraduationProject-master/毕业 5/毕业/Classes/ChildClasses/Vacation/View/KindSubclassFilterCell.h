//
//  KindSubclassFilterCell.h
//  毕业
//
//  Created by 龙波 on 2017/10/17.
//  Copyright © 2017年 吴添培. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MerchantCataGroupModel;
@interface KindSubclassFilterCell : UITableViewCell

+(instancetype)cellWithTableView:(UITableView *)tableView indexPath:(NSIndexPath*)indexPath model:(MerchantCataGroupModel *)model;

@end
