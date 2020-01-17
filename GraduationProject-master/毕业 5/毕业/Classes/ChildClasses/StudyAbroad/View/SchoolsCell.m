//
//  ScroolsCell.m
//  毕业
//
//  Created by 吴添培的黑苹果 on 2017/10/14.
//  Copyright © 2017年 吴添培. All rights reserved.
//

#import "SchoolsCell.h"
#import "SchoolsModel.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "NSString+Extension.h"

@interface SchoolsCell ()
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *rang;
@property (weak, nonatomic) IBOutlet UILabel *price;

@end

@implementation SchoolsCell

-(void)setModel:(SchoolsModel *)model{
    _model = model;
    NSString *urlString = [NSString concatenationImageString:model.imageName];
    [self.imgView sd_setImageWithURL: [NSURL URLWithString:urlString] placeholderImage:[UIImage imageNamed:@"qianlan"]];
    self.title.text = model.name;
    self.rang.text = model.WorldRanking;
    self.price.text = model.price;
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
