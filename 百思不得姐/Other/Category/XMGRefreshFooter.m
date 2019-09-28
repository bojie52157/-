//
//  XMGRefreshFooter.m
//  百思不得姐
//
//  Created by 孙 on 2019/9/19.
//  Copyright © 2019 小情调. All rights reserved.
//

#import "XMGRefreshFooter.h"

@implementation XMGRefreshFooter

- (void)prepare{
    [super prepare];
    self.stateLabel.textColor = [UIColor orangeColor];
    //刷新控件出现一半就会进入刷新状态
//    self.triggerAutomaticallyRefreshPercent = 0.5;
//    [self addSubview:[UIButton buttonWithType:UIButtonTypeContactAdd]];
    [self setTitle:@"没有消息了" forState:MJRefreshStateNoMoreData];
}

@end
