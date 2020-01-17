//
//  KindFilterCell.m
//  毕业
//
//  Created by 龙波 on 2017/10/17.
//  Copyright © 2017年 吴添培. All rights reserved.
//

#import "KindFilterCell.h"


@interface KindFilterCell ()
{
    UIImageView *_imageView;
   // UILabel *nameLabel;
    UIButton *_numberBtn;
}

@end


@implementation KindFilterCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


+(instancetype)cellWithTableView:(UITableView *)tableView bigGroupName:(NSString *)bigGroupName{
    //  这个 静态字符串不要与类名相同
    static NSString *kKindFilterCell = @"KindFilterCellID";
    KindFilterCell *cell = [tableView dequeueReusableCellWithIdentifier:kKindFilterCell];
    if (cell == nil) {
        //注：这个地方要留一个心，看是调父类的还是构造方法的
        cell = [[KindFilterCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kKindFilterCell];
        cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
        cell.selectedBackgroundView.backgroundColor = RGBColor(239, 239, 239);
        
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.nameLabel.text = bigGroupName;
    return cell;
    
}
//withFrame:(CGRect)frame
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier  {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, 100, 30)];
        _nameLabel.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:_nameLabel];
        
        _numberBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _numberBtn.frame = CGRectMake(self.frame.size.width-85, 12, 80, 15);
        _numberBtn.titleLabel.font = [UIFont systemFontOfSize:11];
        _numberBtn.layer.cornerRadius = 7;
        _numberBtn.layer.masksToBounds = YES;
        [_numberBtn setBackgroundImage:[UIImage imageNamed:@"film"] forState:UIControlStateNormal];
        [_numberBtn setBackgroundImage:[UIImage imageNamed:@"film"] forState:UIControlStateHighlighted];
        [_numberBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_numberBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
        [self.contentView addSubview:_numberBtn];
        
        //下划线
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height-0.5, self.frame.size.width, 0.5)];
        lineView.backgroundColor = RGBColor(192, 192, 192);
        [self.contentView addSubview:lineView];
    }
    return self;
    
}



@end
