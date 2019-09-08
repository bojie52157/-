//
//  UITextField+XMGExtension.m
//  百思不得姐
//
//  Created by 孙 on 2019/9/8.
//  Copyright © 2019 小情调. All rights reserved.
//

#import "UITextField+XMGExtension.h"

static NSString * const XMGPlaceholderColorKey = @"placeholderLabel.textColor";

@implementation UITextField (XMGExtension)

- (void)setPlaceholderColor:(UIColor *)placeholderColor{
    //提前设置占位文字，目的：让它提前创建PlaceholderLabel
    NSString *oldPlaceholder = self.placeholder;
    self.placeholder = @"";
    self.placeholder = oldPlaceholder;
    //恢复到默认的占位文字颜色
    if (placeholderColor == nil) {
        placeholderColor = [UIColor colorWithRed:0 green:0 blue:0.0980392 alpha:0.22];
    }
    //设置占位文字颜色
    [self setValue:placeholderColor forKeyPath:XMGPlaceholderColorKey];
}

- (UIColor *)placeholderColor{
    return [self valueForKeyPath:XMGPlaceholderColorKey];
}

@end
