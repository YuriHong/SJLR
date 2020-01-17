//
//  majorCell.m
//  毕业
//
//  Created by 吴添培的黑苹果 on 2017/10/15.
//  Copyright © 2017年 吴添培. All rights reserved.
//

#import "majorCell.h"
#import "DetailCourseModel.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "NSString+Extension.h"

@interface majorCell ()
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *subTitle;
@property (weak, nonatomic) IBOutlet UILabel *price;

@end

@implementation majorCell

-(void)setModel:(DetailCourseModel *)model{
    _model = model;
    NSString *urlString = [NSString concatenationImageString:model.mainImage];
    [self.imgView sd_setImageWithURL: [NSURL URLWithString:urlString] placeholderImage:[UIImage imageNamed:@"qianlan"]];
    self.title.text = model.name;
    self.subTitle.text = model.subtitle;
    self.price.text = [NSString stringWithFormat:@"%@",@(model.price)];
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
