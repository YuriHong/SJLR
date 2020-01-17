//
//  USOpenSourceModel.h
//  JKSQ
//
//  Created by YU on 2019/8/15.
//  Copyright © 2019 fengzifeng. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface USOpenSourceModel : NSObject

/// "title": "使用的第三方开源软件",
@property (strong, nonatomic) NSString *title;
/// "url": "www.baidu.com",
@property (strong, nonatomic) NSString *url;
/// "flag": "false"
@property (strong, nonatomic) NSString *flag;

@end

NS_ASSUME_NONNULL_END
