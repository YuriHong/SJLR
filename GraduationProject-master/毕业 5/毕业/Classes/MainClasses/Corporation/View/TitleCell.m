//
//  TitleCell.m
//  毕业设计
//
//  Created by 龙波 on 2017/9/4.
//  Copyright © 2017年 吴添培. All rights reserved.
//

#import "TitleCell.h"
#define ktitleCell @"titleCellID"

@implementation TitleCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+(instancetype)cellwithTableView:(UITableView *)tableview
{
    TitleCell *cell = [tableview dequeueReusableCellWithIdentifier: ktitleCell];

        cell.textLabel.text = @"校园公告";
        
    
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
}


@end
