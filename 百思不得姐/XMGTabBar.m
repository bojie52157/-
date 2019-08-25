//
//  XMGTabBar.m
//  百思不得姐
//
//  Created by 孙 on 2019/8/25.
//  Copyright © 2019 小情调. All rights reserved.
//

#import "XMGTabBar.h"

@interface XMGTabBar()

/****中间的发布按钮***/
@property(nonatomic, weak) UIButton *publishButton;
@end

@implementation XMGTabBar

#pragma mark -懒加载
-(UIButton *)publishButton{
    if (!_publishButton) {
        UIButton *publishButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [publishButton setImage:[UIImage imageNamed:@"tabBar_publish_icon"] forState:UIControlStateNormal];
        [publishButton setImage:[UIImage imageNamed:@"tabBar_publish_click_icon"] forState:UIControlStateHighlighted];
        [publishButton addTarget:self action:@selector(publishClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:publishButton];
        _publishButton = publishButton;
    }
    return _publishButton;
}

#pragma mark - 初始化
- (void)layoutSubviews{
    [super layoutSubviews];
    
    /**设置所有UITabBarButton的frame***/
    //按钮尺寸
    CGFloat buttonW = self.frame.size.width / 5;
    CGFloat buttonH = self.frame.size.height;
    CGFloat buttonY = 0;
    //按钮索引
    int buttonIndex = 0;
    
    for (UIView *subview in self.subviews) {
        //过滤掉非UITabBarButton
        if (subview.class != NSClassFromString(@"UITabBarButton")) continue;
        //设置frame
        CGFloat buttonX = buttonIndex * buttonW;
        if (buttonIndex >= 2) {//右边的2个UITabBarButton
            buttonX += buttonW;
        }
        subview.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
        //增加索引
        buttonIndex++;
    }
    
    /**设置发布按钮的frame**/
    self.publishButton.frame = CGRectMake(0, 0, buttonW, buttonH);
    self.publishButton.center = CGPointMake(self.frame.size.width * 0.5, self.frame.size.height * 0.5);
}

#pragma mark -监听点击事件
-(void)publishClick{
    
}
@end
