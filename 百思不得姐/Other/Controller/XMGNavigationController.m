//
//  XMGNavigationController.m
//  百思不得姐
//
//  Created by 孙 on 2019/8/28.
//  Copyright © 2019 小情调. All rights reserved.
//

#import "XMGNavigationController.h"

@interface XMGNavigationController ()<UIGestureRecognizerDelegate>

@end

@implementation XMGNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.interactivePopGestureRecognizer.delegate = self;
    [self.navigationBar setBackgroundImage:[UIImage imageNamed:@"navigationbarBackgroundWhite"] forBarMetrics:UIBarMetricsDefault];
}

/**
 重写push方法：拦截所有push尽量的子控制器

 @param viewController 刚刚push尽量的子控制器
 */
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if (self.childViewControllers.count > 0) {//如果viewController不是最早的push进来的子控制器
        //左上角
        UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [backButton setImage:[UIImage imageNamed:@"navigationButtonReturn"] forState:UIControlStateNormal];
        [backButton setImage:[UIImage imageNamed:@"navigationButtonReturnClick"] forState:UIControlStateHighlighted];
        [backButton setTitle:@"返回" forState:UIControlStateNormal];
        [backButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [backButton setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
        [backButton sizeToFit];
        //这句代码放在sizeToFit后面
        backButton.contentEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0);
        [backButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:backButton];
        //隐藏底部的工具条
        viewController.hidesBottomBarWhenPushed = YES;
    }
    //所有设置完成后，再push控制器
    [super pushViewController:viewController animated:NO];
}

- (void)back{
    [self popViewControllerAnimated:YES];
}


#pragma mark -UIGestureRecognizerDelegate
/**
 手势识别器对象会调用这个代理方法来决定手势是否有效
 @return YES： 手势有效  NO：手势无效
 */
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
    if (self.childViewControllers.count == 1) {//导航控制器只有1个子控制器
        return NO;
    }
    return YES;
    
    //手势何时有效：当导航控制器的子控制器个数 > 1 就有效
}
@end
