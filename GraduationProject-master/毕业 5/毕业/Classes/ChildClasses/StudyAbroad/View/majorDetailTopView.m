//
//  majorDetailTopView.m
//  毕业
//
//  Created by 吴添培的黑苹果 on 2017/10/16.
//  Copyright © 2017年 吴添培. All rights reserved.
//

#import "majorDetailTopView.h"
#import "UIView+ BorderLine.h"
#import "DetailCourseModel.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "NSString+Extension.h"

@interface majorDetailTopView ()
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *price;
@property (weak, nonatomic) IBOutlet UILabel *subTitle;

@end

@implementation majorDetailTopView

-(void)setModel:(DetailCourseModel *)model{
    _model = model;
    NSString *urlString = [NSString concatenationImageString:model.mainImage];
    [self.imgView sd_setImageWithURL: [NSURL URLWithString:urlString] placeholderImage:[UIImage imageNamed:@"qianlan"]];
    self.title.text = model.name;
    self.price.text = [NSString stringWithFormat:@"%@",@(model.price)];
    self.subTitle.text = model.subtitle;
}

+(instancetype)getmajorDetailTopView{
    return [[NSBundle mainBundle] loadNibNamed:@"majorDetailTopView" owner:nil options:nil][0];
    
}

-(void)awakeFromNib{
    [super awakeFromNib];
}

@end
