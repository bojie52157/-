//
//  UIImage+XMGExternsion.h
//  百思不得姐
//
//  Created by 孙 on 2019/9/25.
//  Copyright © 2019 小情调. All rights reserved.
//

#import <UIKit/UIKit.h>


#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (XMGExternsion)

/// 返回圆形图片
- (instancetype)circleImage;

+ (instancetype)circleImage:(NSString *)name;

@end

NS_ASSUME_NONNULL_END
