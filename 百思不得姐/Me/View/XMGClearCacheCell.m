//
//  XMGClearCacheCell.m
//  百思不得姐
//
//  Created by 孙 on 2019/9/16.
//  Copyright © 2019 小情调. All rights reserved.
//

#import "XMGClearCacheCell.h"
#import <SDImageCache.h>
@implementation XMGClearCacheCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        //设置cell右边的指示器（用来说明正在处理一些事情）
        UIActivityIndicatorView *loadingView = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        [loadingView startAnimating];
        self.accessoryView = loadingView;
        //设置cell默认的文字
        self.textLabel.text = @"清除缓存（正在计算缓存大小...）";
        //在子线程计算缓存大小
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            //获得缓存文件夹路径
            unsigned long long size = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).lastObject stringByAppendingPathComponent:@"Custom"].fileSize;
            size += [SDImageCache sharedImageCache].getSize;
            NSString *sizeText = nil;
            if (size >= 1000 * 1000 * 1000) {
                sizeText = [NSString stringWithFormat:@"%.2fGB",size / 1000.0 / 1000.0 / 1000.0];
            }else if (size >= 1000 * 1000){
                sizeText = [NSString stringWithFormat:@"%.2fMB",size / 1000.0 / 1000.0];
            }else if(size >= 1000){
                sizeText = [NSString stringWithFormat:@"%.2fKB",size / 1000.0];
            }else{
                sizeText = [NSString stringWithFormat:@"%lluB",size];
            }
            //生成文字
            NSString *text = [NSString stringWithFormat:@"清除缓存(%@)",sizeText];
            //回到主线程
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置文字
                self.textLabel.text = text;
                //清空右边的指示器
                self.accessoryView = nil;
                //显示右边的箭头
                self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            });
        });
    }
    return self;
}

@end
