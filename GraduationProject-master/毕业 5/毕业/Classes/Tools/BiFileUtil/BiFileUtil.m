//
//  BiFileUtil.m
//  RubberNet
//
//  Created by nemochen on 16/5/2.
//  Copyright © 2016年 nemochen. All rights reserved.
//

#import "BiFileUtil.h"

@implementation BiFileUtil

+ (NSString*)getFileCacheRootPath {
    NSString* path = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/temp"];
    return path;
}

+ (NSString*)getSerializationFileRootPath {
    NSString * path = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingString:@"/serial"];
    BOOL isDir;
    if (![[NSFileManager defaultManager] fileExistsAtPath:path isDirectory:&isDir]) {
        [[NSFileManager defaultManager] createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
    }
    return path;
}

+ (NSString*)getVoiceRootPath {
    NSString * path = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingString:@"/voice/"];
    BOOL isDir;
    if (![[NSFileManager defaultManager] fileExistsAtPath:path isDirectory:&isDir]) {
        [[NSFileManager defaultManager] createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    return path;
}

+ (NSString*)getRandomImageFile {
    int cur_time_interval = (int)[[NSDate date] timeIntervalSince1970];
    int rand = arc4random() % 100; // 获取 0-99之间的随机数
    return [NSString stringWithFormat:@"%d%d.png", cur_time_interval, rand];
}
+ (NSString*)getVoiceFilePathWithoutSuffix {
    int cur_time_interval = (int)[[NSDate date] timeIntervalSince1970];
    int rand = arc4random() % 100; // 获取 0-99之间的随机数
    return [NSString stringWithFormat:@"%@%d%d", [BiFileUtil getVoiceRootPath], cur_time_interval, rand];
}

+ (NSString*)getRongUserInfoSaveFilePath {
    NSString * path = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingString:@"/serial"];
    BOOL isDir;
    if (![[NSFileManager defaultManager] fileExistsAtPath:path isDirectory:&isDir]) {
        [[NSFileManager defaultManager] createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    return [NSString stringWithFormat:@"%@/rongUserInfo.dic", path];
}

@end
