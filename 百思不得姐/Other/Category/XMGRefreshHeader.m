//
//  XMGRefreshHeader.m
//  百思不得姐
//
//  Created by 孙 on 2019/9/18.
//  Copyright © 2019 小情调. All rights reserved.
//

#import "XMGRefreshHeader.h"

@implementation XMGRefreshHeader

- (void)prepare{
    [super prepare];
    self.automaticallyChangeAlpha = YES;
    self.lastUpdatedTimeLabel.textColor = [UIColor orangeColor];
    self.stateLabel.textColor = [UIColor orangeColor];
    [self setTitle:@"下拉" forState:MJRefreshStateIdle];
    [self setTitle:@"松开" forState:MJRefreshStatePulling];
    [self setTitle:@"正在加载数据..." forState:MJRefreshStateRefreshing];
}

@end
