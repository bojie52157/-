//
//  UIImageView+XMGExternsion.m
//  百思不得姐
//
//  Created by 孙 on 2019/9/25.
//  Copyright © 2019 小情调. All rights reserved.
//

#import "UIImageView+XMGExternsion.h"
#import <UIImageView+WebCache.h>
#import <UIKit/UIKit.h>
#import <ImageIO/ImageIO.h>

@implementation UIImageView (XMGExternsion)

- (void)setHeader:(NSString *)url{
    UIImage *placeholder = [UIImage circleImage:@"defaultUserIcon"];
    [self sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:placeholder completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        if (image == nil) return ;
        self.image = [image circleImage];
    }];
}

- (void)getGifImageWithUrl:(NSURL *)url retrunData:(void (^)(NSArray<UIImage *> * _Nonnull, NSArray<NSNumber *> * _Nonnull, CGFloat, NSArray<NSNumber *> * _Nonnull, NSArray<NSNumber *> * _Nonnull))dataBlock{
    //通过文件的url来将gif文件读取为图片数据引用
    CGImageSourceRef source = CGImageSourceCreateWithURL((CFURLRef)url, NULL);
    //获取gif文件中图片的个数
    size_t count = CGImageSourceGetCount(source);
    //定义一个变量记录gif播放一轮的时间
    float allTime=0;
    //存放所有图片
    NSMutableArray * imageArray = [[NSMutableArray alloc]init];
    //存放每一帧播放的时间
    NSMutableArray * timeArray = [[NSMutableArray alloc]init];
    //存放每张图片的宽度 （一般在一个gif文件中，所有图片尺寸都会一样）
    NSMutableArray * widthArray = [[NSMutableArray alloc]init];
    //存放每张图片的高度
    NSMutableArray * heightArray = [[NSMutableArray alloc]init];
    //遍历
    for (size_t i=0; i<count; i++) {
        CGImageRef image = CGImageSourceCreateImageAtIndex(source, i, NULL);
        [imageArray addObject:(__bridge UIImage *)(image)];
        CGImageRelease(image);
        //获取图片信息
        NSDictionary *dic = (__bridge NSDictionary*)CGImageSourceCopyPropertiesAtIndex(source, i, NULL);
        CGFloat width = [[dic objectForKey:(__bridge NSString *)kCGImagePropertyPixelWidth] floatValue];
        CGFloat height = [[dic objectForKey:(__bridge NSString *)kCGImagePropertyPixelHeight] floatValue];
        [widthArray addObject:[NSNumber numberWithFloat:width]];
        [heightArray addObject:[NSNumber numberWithFloat:height]];
        NSDictionary * timeDic = [dic objectForKey:(__bridge NSString *)kCGImagePropertyGIFDictionary];
        CGFloat time = [[timeDic objectForKey:(__bridge NSString *)kCGImagePropertyGIFDelayTime]floatValue];
        allTime+=time;
        [timeArray addObject:[NSNumber numberWithFloat:time]];
        CFRelease(CFBridgingRetain(dic));
    }
    CFRelease(source);
    dataBlock(imageArray,timeArray,allTime,widthArray,heightArray);
}

-(void)xmg_setImage:(NSURL *)imageUrl{
        __weak id __self = self;
    [self getGifImageWithUrl:imageUrl retrunData:^(NSArray<UIImage *> * _Nonnull imageArray, NSArray<NSNumber *> * _Nonnull timeArray, CGFloat totalTime, NSArray<NSNumber *> * _Nonnull widths, NSArray<NSNumber *> * _Nonnull heights) {
        //添加帧动画
       CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"contents"];
       NSMutableArray * times = [[NSMutableArray alloc]init];
       float currentTime = 0;
       //设置每一帧的时间占比
       for (int i=0; i<imageArray.count; i++) {
           [times addObject:[NSNumber numberWithFloat:currentTime/totalTime]];
           currentTime+=[timeArray[i] floatValue];
       }
       [animation setKeyTimes:times];
       [animation setValues:imageArray];
       [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear]];
       //设置循环
       animation.repeatCount= MAXFLOAT;
       //设置播放总时长
       animation.duration = totalTime;
       //Layer层添加
       [[(UIImageView *)__self layer]addAnimation:animation forKey:@"gifAnimation"];
    }];
}
@end
