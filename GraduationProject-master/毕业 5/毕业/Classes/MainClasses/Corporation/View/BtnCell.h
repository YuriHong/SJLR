//
//  BtnCell.h
//  test——关于tableview
//
//  Created by 龙波 on 2017/9/2.
//  Copyright © 2017年 ----ggg. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BtnCellDelegate <NSObject>

-(void)didSelectAtIndexBtnCell:(NSInteger)toIndex;


@end



@interface BtnCell : UITableViewCell



@property(nonatomic,weak)id<BtnCellDelegate>delegate;

+(instancetype)cellWithTableView:(UITableView *)tableview;

@end
