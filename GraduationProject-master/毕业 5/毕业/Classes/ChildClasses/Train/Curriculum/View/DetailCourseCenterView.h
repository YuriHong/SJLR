//
//  DetailCurriculumCenterView.h
//  毕业
//
//  Created by 吴添培的黑苹果 on 2017/10/9.
//  Copyright © 2017年 吴添培. All rights reserved.
//

#import <UIKit/UIKit.h>

@class InstDetailModel;
@class DetailCourseModel;

@protocol DetailCourseCenterViewDelegate <NSObject>

-(void)pushDetailInstViewController;

@end

@interface DetailCourseCenterView : UIView

@property (nonatomic, weak) id<DetailCourseCenterViewDelegate> delegate;
@property (nonatomic, strong) InstDetailModel *instModel;
@property (nonatomic, strong) DetailCourseModel *courseModel;

+ (instancetype)getDetailCourseCenterView;

@end
