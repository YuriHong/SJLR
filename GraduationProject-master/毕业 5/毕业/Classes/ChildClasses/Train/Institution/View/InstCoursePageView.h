//
//  ChildCurriculumView.h
//  毕业
//
//  Created by 吴添培的黑苹果 on 2017/10/11.
//  Copyright © 2017年 吴添培. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol InstCoursePageViewDelegate <NSObject>

- (void)pushCourseDetailViewControllerWithID:(NSString *)ID;

@end

@interface InstCoursePageView : UIView

@property(nonatomic, copy)NSArray *courseArray;

@property(nonatomic, weak)id<InstCoursePageViewDelegate> delegate;

@end
