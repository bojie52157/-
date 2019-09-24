//
//  XMGComment.h
//  百思不得姐
//
//  Created by 孙 on 2019/9/21.
//  Copyright © 2019 小情调. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@class XMGUser;
@interface XMGComment : NSObject

/**
 内容
 */
@property (nonatomic, copy) NSString *content;
/**
 用户（发表评论的人）
 */
@property (nonatomic, strong) XMGUser *user;
@end

NS_ASSUME_NONNULL_END
