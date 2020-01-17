//
//  MassDetailModel.h
//  毕业
//
//  Created by 龙波 on 2017/11/7.
//  Copyright © 2017年 吴添培. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MassDetailModel : NSObject

//社团活动名称
@property(nonatomic,strong) NSString *name;
//社团活动图片
@property(nonatomic,strong) NSString *mainImage;
//社团活动时间
@property(nonatomic,strong) NSString *price;
//社团活动地点
@property(nonatomic,strong) NSString *subtitle;
//社团名称
@property(nonatomic,strong) NSString *id;

@property(nonatomic,strong) NSString *detail;

@property(nonatomic,strong) NSString *stock;

@property(nonatomic,strong) NSString *createTime;

@property(nonatomic,strong) NSString *updateTime;




@end
