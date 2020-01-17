//
//  LBUerNetModel.m
//  毕业设计
//
//  Created by 龙波 on 2017/9/21.
//  Copyright © 2017年 ----龙波. All rights reserved.
//

#import "LBUerNetModel.h"

@implementation LBUerNetModel


+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"uerID": @"id"};
}


- (void)logout
{
    NSString *filePath = [NSString stringWithFormat:@"%@/%@", [BiFileUtil getSerializationFileRootPath],    self.id];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:filePath]) {
        [fileManager removeItemAtPath:filePath error:nil];  // 先删除
    }

}

- (void)saveToFile{
    
}




+(LBUerNetModel *)getLoginUserModel{
    
    return [LBUerNetModel loadLocalWithId:[[PersonInfo sharePersonInfo] getLoginUserId]];
    
}

+ (LBUerNetModel *)loadLocalWithId:(NSNumber *)userId
{
    NSString *filePath = [NSString stringWithFormat:@"%@/%@", [BiFileUtil getSerializationFileRootPath], userId];
    NSLog(@"%@",filePath);
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:filePath]) { // 文件存在
        NSData *data = [NSData dataWithContentsOfFile:filePath]; // 读取文件
        if (nil != data) {
            LBUerNetModel *model = [NSKeyedUnarchiver unarchiveObjectWithData:data]; // 反序列化
            // 判断token是否过期
            //            NSDate *expireDate = [NSDate dateWithTimeIntervalSince1970:[model.expires doubleValue]];
            //            if ([[NSDate date] compare:expireDate] != NSOrderedAscending) {
            //                return nil;
            //            }
            return model;
        }
    }
    return nil;
}





@end
