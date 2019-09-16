//
//  NSString+XMGExtension.m
//  百思不得姐
//
//  Created by 孙 on 2019/9/16.
//  Copyright © 2019 小情调. All rights reserved.
//

#import "NSString+XMGExtension.h"

@implementation NSString (XMGExtension)

- (unsigned long long)fileSize{
    //总大小
    unsigned long long size = 0;
    //文件管理者
    NSFileManager *manager = [NSFileManager defaultManager];
    //是否为文件夹
    BOOL isDirectory = NO;
    //路径是否存在
    BOOL exists = [manager fileExistsAtPath:self isDirectory:&isDirectory];
    if (!exists) return size;
    if (isDirectory) {
        //获得文件夹的大小 == 获得文件夹中所有文件的总大小
        //Enumerator：遍历器 \ 迭代器
        NSDirectoryEnumerator *enumerator = [manager enumeratorAtPath:self];
        for (NSString *subpath in enumerator) {
            //全路径
            NSString *fullSubpath = [self stringByAppendingPathComponent:subpath];
            //累加文件大小
            size += [manager attributesOfItemAtPath:fullSubpath error:nil].fileSize;
        }
    }else{
        //文件
        size = [manager attributesOfItemAtPath:self error:nil].fileSize;
    }
  
    return size;
}

@end
