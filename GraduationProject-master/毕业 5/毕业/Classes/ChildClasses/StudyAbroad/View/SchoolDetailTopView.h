//
//  SchoolDetailTopView.h
//  毕业
//
//  Created by 吴添培的黑苹果 on 2017/10/15.
//  Copyright © 2017年 吴添培. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SchoolsModel;
@interface SchoolDetailTopView : UIView
@property (nonatomic, strong) SchoolsModel *model;

+ (instancetype)getSchoolDetailTopView;

@end
