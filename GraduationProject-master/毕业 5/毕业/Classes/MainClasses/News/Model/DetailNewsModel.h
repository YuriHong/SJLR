//
//  DetailNewsModel.h
//  毕业
//
//  Created by 吴添培的黑苹果 on 2017/10/23.
//  Copyright © 2017年 吴添培. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DetailNewsModel : NSObject

@property(nonatomic,strong)NSString *title;
@property(nonatomic,strong)NSString *timer;
@property(nonatomic,strong)NSString *json;
@property(nonatomic,strong)NSString *author;
@property(nonatomic,strong)NSString *Browsing;

+ (NSMutableArray *)getDetailNewsModelArray;

@end
