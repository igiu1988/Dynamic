//
//  NSFileManager+MostUsePath.m
//  scalImage
//
//  Created by wangyang on 13-8-27.
//  Copyright (c) 2013年 wangyang. All rights reserved.
//

#import "NSFileManager+MostUsePath.h"

@implementation NSFileManager (MostUsePath)

+ (NSString *)documentPath {
    NSArray *searchPaths =NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    return [searchPaths objectAtIndex: 0];
}

+ (NSString *)directoryPath:(NSString *)dirName {
    
    NSString *thumbnailsPath = [[NSFileManager documentPath] stringByAppendingPathComponent:dirName];
    
    NSFileManager *fm = [NSFileManager defaultManager];
    if ( [fm fileExistsAtPath:thumbnailsPath] == false ) {
        [fm createDirectoryAtPath:thumbnailsPath
      withIntermediateDirectories:YES
                       attributes:nil
                            error:NULL];
    }
    return thumbnailsPath;
}
@end
