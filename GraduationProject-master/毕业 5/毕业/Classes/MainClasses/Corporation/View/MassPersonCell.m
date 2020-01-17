//
//  MassPersonCell.m
//  毕业设计
//
//  Created by 龙波 on 2017/9/7.
//  Copyright © 2017年 吴添培. All rights reserved.
//

#import "MassPersonCell.h"
#define kmasspersonCell @"masspersonCelID"
@implementation MassPersonCell



- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (instancetype)cellWithTableView:(UITableView *)tableview
{
    MassPersonCell *cell = [tableview dequeueReusableCellWithIdentifier: kmasspersonCell];
    
    cell.numberLabel.text = @"共有100个人";
    
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        UIView *bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 100)];
//        bottomView.backgroundColor = [UIColor blackColor];
        [self addSubview:bottomView];
        
        self.numberLabel = [[UILabel alloc]initWithFrame:CGRectMake(SCREENWIDTH*0.5-40, 30, 80, 30)];
        
        self.numberLabel.textAlignment = NSTextAlignmentCenter;
        self.numberLabel.backgroundColor = [UIColor whiteColor];
        self.numberLabel.font = [UIFont systemFontOfSize:12.0];
        [bottomView addSubview:self.numberLabel];
        
        CGFloat Width = 50;
        CGFloat height = 50;
        for (int i=0; i<self.count; i++) {
            
             self.headView = [[UIImageView alloc]initWithFrame:CGRectMake(i*Width+10, 60, Width, height)];
            self.headView.backgroundColor = [UIColor blueColor];
            [bottomView addSubview:self.headView];
            
        }
    }
    return self;
}
@end
