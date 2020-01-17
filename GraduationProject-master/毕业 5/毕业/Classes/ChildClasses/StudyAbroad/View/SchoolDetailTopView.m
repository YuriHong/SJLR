//
//  SchoolDetailTopView.m
//  毕业
//
//  Created by 吴添培的黑苹果 on 2017/10/15.
//  Copyright © 2017年 吴添培. All rights reserved.
//

#import "SchoolDetailTopView.h"
#import "SchoolsModel.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "NSString+Extension.h"

@interface SchoolDetailTopView ()
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *rang;
@property (weak, nonatomic) IBOutlet UILabel *price;
@property (weak, nonatomic) IBOutlet UILabel *place;

@end

@implementation SchoolDetailTopView

-(void)setModel:(SchoolsModel *)model{
    _model = model;
    NSString *urlString = [NSString concatenationImageString:model.imageName];
    [self.imgView sd_setImageWithURL: [NSURL URLWithString:urlString] placeholderImage:[UIImage imageNamed:@"qianlan"]];
    self.title.text = model.name;
    self.rang.text = model.WorldRanking;
    self.price.text = model.price;
    self.place.text = model.place;
    
}

+ (instancetype)getSchoolDetailTopView{
    return [[NSBundle mainBundle] loadNibNamed:@"SchoolDetailTopView" owner:nil options:nil][0];
}

@end
