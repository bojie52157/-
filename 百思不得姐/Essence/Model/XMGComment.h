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

/** id */
@property (nonatomic, copy) NSString *ID;
/** 内容 */
@property (nonatomic, copy) NSString *content;
/** 用户(发表评论的人) */
@property (nonatomic, strong) XMGUser *user;

/** 被点赞数 */
@property (nonatomic, assign) NSInteger like_count;

/** 音频文件的时长 */
@property (nonatomic, assign) NSInteger voicetime;

/** 音频文件的路径 */
@property (nonatomic, copy) NSString *voiceuri;
@end

NS_ASSUME_NONNULL_END
