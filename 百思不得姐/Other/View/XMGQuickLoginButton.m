//
//  XMGQuickLoginButton.m
//  百思不得姐
//
//  Created by 孙 on 2019/8/29.
//  Copyright © 2019 小情调. All rights reserved.
//

#import "XMGQuickLoginButton.h"

@implementation XMGQuickLoginButton

- (void)awakeFromNib{
    [super awakeFromNib];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    CGFloat midX = self.frame.size.width / 2;
    CGFloat midY = self.frame.size.height / 2;
    self.titleLabel.center = CGPointMake(midX, midY + 35);
    self.imageView.center = CGPointMake(midX, midY - 10);
    
}

@end
