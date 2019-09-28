//
//  UIImageView+XMGExternsion.h
//  百思不得姐
//
//  Created by 孙 on 2019/9/25.
//  Copyright © 2019 小情调. All rights reserved.
//
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImageView (XMGExternsion)

- (void)setHeader:(NSString *)url;

- (void)xmg_setImage:(NSURL *)imageUrl;

- (void)getGifImageWithUrl:(NSURL *)url retrunData:(void(^)(NSArray<UIImage *> * imageArray, NSArray<NSNumber *> *timeArray,CGFloat totalTime, NSArray<NSNumber *>*widths, NSArray<NSNumber *>*heights))dataBlock;

@end

NS_ASSUME_NONNULL_END
