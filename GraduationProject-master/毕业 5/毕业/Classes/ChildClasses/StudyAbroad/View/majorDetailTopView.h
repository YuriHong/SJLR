//
//  majorDetailTopView.h
//  毕业
//
//  Created by 吴添培的黑苹果 on 2017/10/16.
//  Copyright © 2017年 吴添培. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DetailCourseModel;
@interface majorDetailTopView : UIView
@property (nonatomic, strong) DetailCourseModel *model;

+(instancetype)getmajorDetailTopView;

@end
