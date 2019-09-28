//
//  XMGCommentSectionHeader.m
//  百思不得姐
//
//  Created by 孙 on 2019/9/26.
//  Copyright © 2019 小情调. All rights reserved.
//

#import "XMGCommentSectionHeader.h"

@implementation XMGCommentSectionHeader

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        self.textLabel.textColor = [UIColor darkGrayColor];
        self.contentView.backgroundColor = XMGCommonBgColor;
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    //在layoutSubviews方法中覆盖对子控件的一些设置
    self.textLabel.font = XMGCommentSectionHeaderFont;
}
@end
