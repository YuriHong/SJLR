//
//  curriculumCell.m
//  校园帮(用户)
//
//  Created by 吴添培 on 2017/8/9.
//  Copyright © 2017年 吴添培. All rights reserved.
//

#import "CourseCell.h"
#import "DetailCourseModel.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "NSString+Extension.h"

@interface CourseCell ()
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *subtitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;


@end

@implementation CourseCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self  == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
    }
  
    return self;
}

-(void)setDetail:(DetailCourseModel *)detail{
    _detail = detail;
    NSString *urlString = [NSString concatenationImageString:detail.mainImage];
    [self.imgView sd_setImageWithURL: [NSURL URLWithString:urlString] placeholderImage:[UIImage imageNamed:@"qianlan"]];
    self.titleLabel.text = detail.name;
    self.subtitleLabel.text = detail.subtitle;
    self.priceLabel.text = [NSString stringWithFormat:@"%@",@(detail.price)];
}



@end
