//
//  SchoolsModel.h
//  毕业
//
//  Created by 吴添培的黑苹果 on 2017/10/30.
//  Copyright © 2017年 吴添培. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SchoolsModel : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *imageName;
@property (nonatomic, copy) NSString *WorldRanking;
@property (nonatomic, copy) NSString *price;
@property (nonatomic, copy) NSString *detail;
@property (nonatomic, copy) NSString *place;
@property (nonatomic, copy) NSArray *majorID;


+(NSMutableArray *)getSchoolsModelArray;

@end
