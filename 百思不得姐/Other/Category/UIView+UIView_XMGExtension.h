//
//  UIView+UIView_XMGExtension.h
//  百思不得姐
//
//  Created by 孙 on 2019/8/26.
//  Copyright © 2019 小情调. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (UIView_XMGExtension)

@property(nonatomic, assign) CGSize  xmg_size;
@property(nonatomic, assign) CGFloat xmg_width;
@property(nonatomic, assign) CGFloat xmg_height;
@property(nonatomic, assign) CGFloat xmg_x;
@property(nonatomic, assign) CGFloat xmg_y;
@property(nonatomic, assign) CGFloat xmg_centerX;
@property(nonatomic, assign) CGFloat xmg_centerY;
@property(nonatomic, assign) CGFloat xmg_right;
@property(nonatomic, assign) CGFloat xmg_bottom;

+ (instancetype)viewFormXib;


- (BOOL)intersectWithView:(UIView *)view;
@end

NS_ASSUME_NONNULL_END
