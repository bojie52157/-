//
//  XMGMeCell.m
//  百思不得姐
//
//  Created by 孙 on 2019/9/11.
//  Copyright © 2019 小情调. All rights reserved.
//

#import "XMGMeCell.h"

@implementation XMGMeCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.textLabel.textColor = [UIColor darkGrayColor];
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        self.backgroundView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"mainCellBackground"]];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.imageView.xmg_y = XMGSmallMargin;
}

@end
