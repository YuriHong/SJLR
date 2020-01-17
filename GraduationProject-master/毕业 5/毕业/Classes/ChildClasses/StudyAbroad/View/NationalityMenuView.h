//
//  NationalityMenuView.h
//  毕业
//
//  Created by 吴添培的黑苹果 on 2017/10/13.
//  Copyright © 2017年 吴添培. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol NationalityMenuViewDelegate <NSObject>

-(void)setPushViewControllerWithTitle:(NSString *)title;

@end

@interface NationalityMenuView : UIView

@property (nonatomic,weak) id<NationalityMenuViewDelegate> delegate;

@end
