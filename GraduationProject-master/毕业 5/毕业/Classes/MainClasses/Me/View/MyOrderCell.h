//
//  MyOrderCell.h
//  test-个人
//
//  Created by 龙波 on 2017/10/22.
//  Copyright © 2017年 ----龙波. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyOrderCell : UITableViewCell

@property (copy,nonatomic)NSString *title;
@property(nonatomic,copy) NSString *statusTitle;

+(instancetype)cellwithTableView:(UITableView *)tableview;


@end

