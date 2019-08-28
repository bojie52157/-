//
//  UIBarButtonItem+XMGExtension.h
//  百思不得姐
//
//  Created by 孙 on 2019/8/28.
//  Copyright © 2019 小情调. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIBarButtonItem (XMGExtension)
+ (instancetype)itemWithImage:(NSString *)image highImage:(NSString *)highImage target:(id)target action:(SEL)action;

@end

NS_ASSUME_NONNULL_END
