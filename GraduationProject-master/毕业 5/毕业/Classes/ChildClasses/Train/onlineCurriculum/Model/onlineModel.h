//
//  onlineModel.h
//  毕业
//
//  Created by 吴添培的黑苹果 on 2017/10/8.
//  Copyright © 2017年 吴添培. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface onlineModel : NSObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *imageName;

+ (NSMutableArray *)getModelWithArray;

@end
