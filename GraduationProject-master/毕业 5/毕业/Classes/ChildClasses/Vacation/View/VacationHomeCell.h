//
//  VacationHomeCell.h
//  毕业
//
//  Created by 龙波 on 2017/10/13.
//  Copyright © 2017年 吴添培. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol VacationHomeCellDelegate <NSObject>
@optional

-(void)homeMenuCellClick:(long)sender;


@end

@interface VacationHomeCell : UITableViewCell

@property(weak,nonatomic)id<VacationHomeCellDelegate>delegate;


+(instancetype)cellWithTableView:(UITableView *)tableview menuArray:(NSArray *)menuArray;
@end
