//
//  XMGClearCacheCell.m
//  百思不得姐
//
//  Created by 孙 on 2019/9/16.
//  Copyright © 2019 小情调. All rights reserved.
//

#import "XMGClearCacheCell.h"
#import <SDImageCache.h>
#import <SVProgressHUD.h>

#define XMGCustomCacheFile [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).lastObject stringByAppendingPathComponent:@"Custom"]

@implementation XMGClearCacheCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        //设置cell右边的指示器（用来说明正在处理一些事情）
        UIActivityIndicatorView *loadingView = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        [loadingView startAnimating];
        self.accessoryView = loadingView;
        //设置cell默认的文字
        self.textLabel.text = @"清除缓存（正在计算缓存大小...）";
        //禁止点击
        self.userInteractionEnabled = NO;
        //弱化self
        __weak typeof(self) weakSelf = self;
        //在子线程计算缓存大小
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            //获得缓存文件夹路径
            unsigned long long size = XMGCustomCacheFile.fileSize;
            size += [SDImageCache sharedImageCache].getSize;
            //如果cell已经销毁了，就直接返回
            if (weakSelf == nil) return ;
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
                weakSelf.textLabel.text = text;
                //清空右边的指示器
                weakSelf.accessoryView = nil;
                //显示右边的箭头
                weakSelf.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                //恢复点击
                weakSelf.userInteractionEnabled = YES;
            });
            
            //添加手势监听器
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:weakSelf action:@selector(clearCache)];
            dispatch_async(dispatch_get_main_queue(), ^{
                 [weakSelf addGestureRecognizer:tap];
            });
        });
    }
    return self;
}

/**
 清除缓存
 */
- (void)clearCache{
    //弹出提示
    [SVProgressHUD showWithStatus:@"正在清除缓存..."];
    //删除SDWebImage的缓存
    [[SDImageCache sharedImageCache] clearDiskOnCompletion:^{
       //删除自定义的缓存
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            NSFileManager *mgr = [NSFileManager defaultManager];
            [mgr removeItemAtPath:XMGCustomCacheFile error:nil];
            [mgr createDirectoryAtPath:XMGCustomCacheFile withIntermediateDirectories:YES attributes:nil error:nil];
            //所有的缓存都清除完毕
            dispatch_async(dispatch_get_main_queue(), ^{
               //隐藏指示器
                [SVProgressHUD dismiss];
                //设置文字
                self.textLabel.text = @"清除缓存(0B)";
            });
        });
    }];
}
@end
