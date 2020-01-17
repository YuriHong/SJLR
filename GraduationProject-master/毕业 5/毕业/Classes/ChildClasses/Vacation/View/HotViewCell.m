//
//  HotViewCell.m
//  毕业
//
//  Created by 龙波 on 2017/10/13.
//  Copyright © 2017年 吴添培. All rights reserved.
//

#import "HotViewCell.h"
#import "HotCollectionView.h"
#import "VacationListModel.h"

#define kHotViewCell @"hotviewCellID"


@interface HotViewCell ()



@end
@implementation HotViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}



+(instancetype)cellWithTableView:(UITableView *)tableview
{
    HotViewCell *cell = [tableview dequeueReusableCellWithIdentifier: kHotViewCell];
    return cell;
}




@end
