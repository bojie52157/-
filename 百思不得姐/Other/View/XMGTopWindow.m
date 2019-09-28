//
//  XMGTopWindow.m
//  百思不得姐
//
//  Created by 孙 on 2019/9/26.
//  Copyright © 2019 小情调. All rights reserved.
//

#import "XMGTopWindow.h"

@implementation XMGTopWindow

static UIWindow *window_;

+ (void)show{
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        window_ = [[UIWindow alloc]init];
        window_.frame = [UIApplication sharedApplication].statusBarFrame;
        window_.backgroundColor = [UIColor clearColor];
        window_.windowLevel = UIWindowLevelAlert;
        [window_ addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(topWindowClick)]];
    });
}

+ (void)topWindowClick{
    //主窗口
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    //查找主窗口中的所有scrollView
    [self findScrollViewsInView:window];
}

/// 查找view中的所有scrollView
+ (void)findScrollViewsInView:(UIView *)view{
    //利用递归查找所有的子控件
    for (UIView *subview in view.subviews) {
        [self findScrollViewsInView:subview];
    }
    //如果不是scrollView
    if (![view isKindOfClass:[UIScrollView class]]) return;
    //判断是否跟window有重叠
    if (![view intersectWithView:[UIApplication sharedApplication].keyWindow]) return;
    //如果是scrollView
    UIScrollView *scrollView = (UIScrollView *)view;
    //修改offset
    CGPoint offset = scrollView.contentOffset;
    offset.y = -scrollView.contentInset.top;
    [scrollView setContentOffset:offset animated:YES];
}
@end
