//
//  NSFileManager+MostUsePath.h
//  scalImage
//
//  Created by wangyang on 13-8-27.
//  Copyright (c) 2013年 wangyang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSFileManager (MostUsePath)
+ (NSString *)documentPath;
/**
 *	如果该目录存在，直接返回目录 path，不存在会创建并返回 path
 */
+ (NSString *)directoryPath:(NSString *)dirName;
@end
