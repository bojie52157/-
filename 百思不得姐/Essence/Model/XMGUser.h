//
//  XMGUser.h
//  百思不得姐
//
//  Created by 孙 on 2019/9/21.
//  Copyright © 2019 小情调. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface XMGUser : NSObject
/** 用户名 */
@property (nonatomic, copy) NSString *username;
/** 头像 */
@property (nonatomic, copy) NSString *profile_image;
/** 性别 m(male) f(female) */
@property (nonatomic, copy) NSString *sex;

@end

NS_ASSUME_NONNULL_END
