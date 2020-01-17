//
//  curriculumView.h
//  毕业
//
//  Created by 吴添培的黑苹果 on 2017/9/29.
//  Copyright © 2017年 吴添培. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol WTPListViewDelegate <NSObject>

- (void)pushListViewControllerWithTitle:(NSString *)title;
- (void)pushListDetailViewControllerWithtitle:(NSString *) title andID:(NSString *)ID;

@end

@interface WTPListView : UIView

@property(nonatomic, strong)NSArray *array;

@property (nonatomic, copy) NSString *labelText;

@property(nonatomic, weak)id<WTPListViewDelegate> delegate;

-(void)setNibWithNibName:(NSString *)nibName identify:(NSString *)identify;

+(instancetype)getWTPListView;

@end
