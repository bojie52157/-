//
//  UIBarButtonItem+XMGExtension.m
//  百思不得姐
//
//  Created by 孙 on 2019/8/28.
//  Copyright © 2019 小情调. All rights reserved.
//

#import "UIBarButtonItem+XMGExtension.h"

@implementation UIBarButtonItem (XMGExtension)

+ (instancetype)itemWithImage:(NSString *)image highImage:(NSString *)highImage target:(id)target action:(SEL)action{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:highImage] forState:UIControlStateHighlighted];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [button sizeToFit];
    return  [[self alloc]initWithCustomView:button];
}
@end
