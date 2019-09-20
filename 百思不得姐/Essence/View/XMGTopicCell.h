//
//  XMGTopicCell.h
//  百思不得姐
//
//  Created by 孙 on 2019/9/19.
//  Copyright © 2019 小情调. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class XMGTopic;
@interface XMGTopicCell : UITableViewCell
/**
 帖子模型数据
 */
@property (nonatomic, strong) XMGTopic *topic;
@end

NS_ASSUME_NONNULL_END
