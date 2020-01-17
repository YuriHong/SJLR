//
//  NetworkTool.m
//  毕业设计
//
//  Created by 吴添培的黑苹果 on 2017/9/24.
//  Copyright © 2017年 吴添培. All rights reserved.
//

#import "NetworkTool.h"

static NetworkTool *_instance = nil;

@implementation NetworkTool

//利用GCD方式创建单例，，避免在多线程中创建多个instance
//@synchronized(self) { }, 互斥锁效果一样 ，但是会影响性能
+(NetworkTool *)sharedInstance{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[NetworkTool alloc] init];
    });
    return _instance;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [super allocWithZone:zone];
    });
    return _instance;
}

- (id)copyWithZone:(NSZone *)zone
{
    return _instance;
}

- (id)mutableCopyWithZone:(NSZone *)zone {
    return _instance;
}

+(NSString *)willConcatenationString:(NSString *)string{
    NSString *urlString = [NSString stringWithFormat:@"http://47.93.33.181:8080%@",string];
    return urlString;
}

-(void)requestWithURLString:(NSString *)URLString
                     params:(NSDictionary *)params
                     method:(requestMethod)method
                   callBack:(void(^)(id data, bool isSuccess))callBack{
    
    if (method == GET) {
        //调用AFN框架的方法
        [self GET:URLString parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            //如果请求成功，则回调responseObject
            callBack(responseObject, YES);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            //如果请求失败，回调错误信息
            callBack(error, NO);
        }];
    }
    
    if (method == POST) {
        [self POST:URLString parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            callBack(responseObject, YES);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            callBack(error, NO);
        }];
    }
    
}



@end
