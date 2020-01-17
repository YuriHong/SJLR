//
//  NoticCell.m
//  毕业设计
//
//  Created by 龙波 on 2017/9/4.
//  Copyright © 2017年 吴添培. All rights reserved.
//

#import "NoticCell.h"
#define knoticCell @"noticeCellID"
@implementation NoticCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
+(instancetype)cellWithTabelView:(UITableView *)tableview
{
    NoticCell *cell = [tableview dequeueReusableCellWithIdentifier:knoticCell];
    cell.noticeLabel.text=@"为了伟大的中华人民共和国的复兴之路，为了实现中国梦，必须讲四个自信坚持到底，那就是“道路自信，理论自信，制度自信，文化自信”";
    
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.noticeLabel = [[UITextView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width-25, 110)];
        self.noticeLabel.textAlignment = NSTextAlignmentLeft;
        self.noticeLabel.font = [UIFont systemFontOfSize:16];
        self.noticeLabel.editable = NO;
        [self.contentView addSubview:self.noticeLabel];
        
        
        
    }
    return self;
}

@end
