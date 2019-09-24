//
//  XMGTopicViewController.h
//  百思不得姐
//
//  Created by 孙 on 2019/9/24.
//  Copyright © 2019 小情调. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XMGTopic.h"
NS_ASSUME_NONNULL_BEGIN

@interface XMGTopicViewController : UITableViewController

/// 帖子类型
//@property (nonatomic, strong) XMGTopicType type;
- (XMGTopicType)type;

@end

NS_ASSUME_NONNULL_END
