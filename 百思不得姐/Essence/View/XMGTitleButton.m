//
//  XMGTitleButton.m
//  百思不得姐
//
//  Created by 孙 on 2019/9/17.
//  Copyright © 2019 小情调. All rights reserved.
//

#import "XMGTitleButton.h"

@implementation XMGTitleButton

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        //设置按钮颜色
        [self setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [self setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
    }
    return self;
}

@end
