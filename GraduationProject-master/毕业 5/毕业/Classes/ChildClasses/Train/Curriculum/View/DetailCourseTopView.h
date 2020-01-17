//
//  DetailCurriculumTopView.h
//  毕业
//
//  Created by 吴添培的黑苹果 on 2017/10/9.
//  Copyright © 2017年 吴添培. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DetailCourseModel;

@interface DetailCourseTopView : UIView
@property (nonatomic, strong) DetailCourseModel *courseModel;

+ (instancetype)getDetailCourseTopView;

@end
