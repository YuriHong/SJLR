//
//  BiFileUtil.h
//  RubberNet
//
//  Created by nemochen on 16/5/2.
//  Copyright © 2016年 nemochen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BiFileUtil : NSObject

+ (NSString*)getFileCacheRootPath;

+ (NSString*)getSerializationFileRootPath;

+ (NSString*)getRandomImageFile;

+ (NSString*)getVoiceFilePathWithoutSuffix;

+ (NSString*)getRongUserInfoSaveFilePath;

@end
