//
//  nationalCoursePageView.h
//  毕业
//
//  Created by 吴添培的黑苹果 on 2017/10/15.
//  Copyright © 2017年 吴添培. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol NationalCoursePageViewDelegate <NSObject>

-(void)pushMajorDetailViewControllerWithID:(NSString *)ID;

@end

@interface NationalCoursePageView : UIView

@property (nonatomic, strong) NSArray *array;

@property (nonatomic, weak) id<NationalCoursePageViewDelegate> delegate;

@end
