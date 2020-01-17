//
//  InstDetailModel.h
//  毕业
//
//  Created by 吴添培的黑苹果 on 2017/10/28.
//  Copyright © 2017年 吴添培. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface InstDetailModel : NSObject

@property(nonatomic, copy) NSString *name;
@property(nonatomic, copy) NSString *imageName;
@property(nonatomic, copy) NSString *address;
@property(nonatomic, copy) NSString *phone;
@property(nonatomic, copy) NSString *detail;
@property(nonatomic, copy) NSArray *courseID;

+(NSMutableArray *)getInstDetailModelArray;

@end
