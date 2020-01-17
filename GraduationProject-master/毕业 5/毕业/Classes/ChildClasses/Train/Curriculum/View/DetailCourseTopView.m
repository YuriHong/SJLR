//
//  DetailCurriculumTopView.m
//  毕业
//
//  Created by 吴添培的黑苹果 on 2017/10/9.
//  Copyright © 2017年 吴添培. All rights reserved.
//

#import "DetailCourseTopView.h"
#import "DetailCourseModel.h"
#import "NSString+Extension.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface DetailCourseTopView ()
@property (weak, nonatomic) IBOutlet UILabel *topViewSubLabel;
@property (weak, nonatomic) IBOutlet UILabel *topViewTitleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *SubImageView;

@end

@implementation DetailCourseTopView

-(void)setCourseModel:(DetailCourseModel *)courseModel{
    _courseModel = courseModel;
    self.topViewTitleLabel.text = courseModel.name;
    self.topViewSubLabel.text = courseModel.subtitle;
    NSString *urlString = [NSString concatenationImageString:courseModel.subImages];
    [self.SubImageView sd_setImageWithURL: [NSURL URLWithString:urlString] placeholderImage:[UIImage imageNamed:@"qianlan"]];
}

+ (instancetype)getDetailCourseTopView{
    return [[NSBundle mainBundle] loadNibNamed:@"DetailCourseTopView" owner:nil options:nil][0];
}

@end
