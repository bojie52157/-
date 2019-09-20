//
//  NSDate+XMGExtension.h
//  百思不得姐
//
//  Created by 孙 on 2019/9/20.
//  Copyright © 2019 小情调. All rights reserved.
//



NS_ASSUME_NONNULL_BEGIN

@interface NSDate (XMGExtension)

/**
 *  是否为今年
 */
- (BOOL)isThisYear;

/**
 *  是否为今天
 */
- (BOOL)isToday;

/**
 *  是否为昨天
 */
- (BOOL)isYesterday;

/**
 *  是否为明天
 */
- (BOOL)isTomorrow;
@end

NS_ASSUME_NONNULL_END
