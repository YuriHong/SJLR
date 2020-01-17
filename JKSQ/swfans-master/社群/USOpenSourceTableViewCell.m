//
//  USOpenSourceTableViewCell.m
//  JKSQ
//
//  Created by YU on 2019/8/15.
//  Copyright © 2019 fengzifeng. All rights reserved.
//

#import "USOpenSourceTableViewCell.h"

@implementation USOpenSourceTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
