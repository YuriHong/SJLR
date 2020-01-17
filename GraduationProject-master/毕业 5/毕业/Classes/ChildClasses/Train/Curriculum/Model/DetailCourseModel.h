//
//  DetailCourseModel.h
//  毕业
//
//  Created by 吴添培的黑苹果 on 2017/10/27.
//  Copyright © 2017年 吴添培. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DetailCourseModel : NSObject

@property(nonatomic,assign)int id;
@property(nonatomic,copy)NSString *name;//标题
@property(nonatomic,copy)NSString *subtitle;//副标题
@property(nonatomic,copy)NSString *mainImage;//图片
@property(nonatomic,copy)NSString *subImages;//副图片
@property(nonatomic,copy)NSString *detail;//详情
@property(nonatomic,assign)double price;//价格
@property(nonatomic,assign)int stock;//库存数量

@end
