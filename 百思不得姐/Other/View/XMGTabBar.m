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
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundImage = [UIImage imageNamed:@"tabBar_icon"];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    /*****按钮尺寸****/
    CGFloat buttonW = self.xmg_width / 5;
    CGFloat buttonH = self.xmg_height;
    
    /**设置所有UITabBarButton的frame***/
    CGFloat tabBarButtonY = 0;
    //按钮索引
    int tabBarButtonIndex = 0;
    
    for (UIView *subview in self.subviews) {
        //过滤掉非UITabBarButton
        if (subview.class != NSClassFromString(@"UITabBarButton")) continue;
        //设置frame
        CGFloat tabBarButtonX = tabBarButtonIndex * buttonW;
        if (tabBarButtonIndex >= 2) {//右边的2个UITabBarButton
            tabBarButtonX += buttonW;
        }
        subview.frame = CGRectMake(tabBarButtonX, tabBarButtonY, buttonW, buttonH);
        //增加索引
        tabBarButtonIndex++;
        
        
    }
    
    /**设置发布按钮的frame**/
    self.publishButton.xmg_width = buttonW;
    self.publishButton.xmg_height = buttonH;
    self.publishButton.xmg_centerX = self.xmg_width * 0.5;
    self.publishButton.xmg_centerY = self.xmg_height * 0.5;
}

#pragma mark -监听点击事件
-(void)publishClick{
    
}
@end
