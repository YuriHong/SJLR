//
//  EditBtn.h
//  test-个人
//
//  Created by 龙波 on 2017/10/23.
//  Copyright © 2017年 ----龙波. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EditBtn : UIButton



@property(nonatomic,strong) UILabel *keyLable;

@property(nonatomic,strong) UIButton *valueLable;


- (void)setUpKey:(NSString *)key value:(NSString *)value;

- (void)setUpKey:(NSString *)key image:(UIImage *)image;
@end
