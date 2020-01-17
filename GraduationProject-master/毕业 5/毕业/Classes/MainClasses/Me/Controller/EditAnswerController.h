//
//  EditAnswerController.h
//  毕业
//
//  Created by 龙波 on 2017/11/6.
//  Copyright © 2017年 吴添培. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EditAnswerController : UIViewController
@property(nonatomic,strong) void (^question)(NSString *questionstr);

@property(nonatomic,strong) NSString *iphoneStr;

-(void)setQuestion:(void (^)(NSString *))question;

@end
