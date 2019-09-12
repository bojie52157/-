//
//  UIView+UIView_XMGExtension.m
//  百思不得姐
//
//  Created by 孙 on 2019/8/26.
//  Copyright © 2019 小情调. All rights reserved.
//

#import "UIView+UIView_XMGExtension.h"

@implementation UIView (UIView_XMGExtension)
//get方法
-(CGSize)xmg_size{
    return self.frame.size;
}

-(CGFloat)xmg_width{
    return self.frame.size.width;
}
-(CGFloat)xmg_height{
    return self.frame.size.height;
}

-(CGFloat)xmg_x{
    return self.frame.origin.x;
}
-(CGFloat)xmg_y{
    return self.frame.origin.y;
}

-(CGFloat)xmg_centerX{
    return self.center.x;
}
-(CGFloat)xmg_centerY{
    return self.center.y;
}
- (CGFloat)xmg_right
{
    //    return self.xmg_x + self.xmg_width;
    return CGRectGetMaxX(self.frame);
}

- (CGFloat)xmg_bottom
{
    //    return self.xmg_y + self.xmg_height;
    return CGRectGetMaxY(self.frame);
}


//set方法
-(void)setXmg_size:(CGSize)xmg_size{
    CGRect frame = self.frame;
    frame.size = xmg_size;
    self.frame = frame;
}

-(void)setXmg_width:(CGFloat)xmg_width{
    CGRect frame = self.frame;
    frame.size.width = xmg_width;
    self.frame = frame;
}
-(void)setXmg_height:(CGFloat)xmg_height{
    CGRect frame = self.frame;
    frame.size.height = xmg_height;
    self.frame = frame;
}

-(void)setXmg_x:(CGFloat)xmg_x{
    CGRect frame = self.frame;
    frame.origin.x = xmg_x;
    self.frame = frame;
}
-(void)setXmg_y:(CGFloat)xmg_y{
    CGRect frame = self.frame;
    frame.origin.y = xmg_y;
    self.frame = frame;
}

-(void)setXmg_centerX:(CGFloat)xmg_centerX{
    CGPoint center = self.center;
    center.x = xmg_centerX;
    self.center = center;
}
-(void)setXmg_centerY:(CGFloat)xmg_centerY{
    CGPoint center = self.center;
    center.y = xmg_centerY;
    self.center = center;
}
- (void)setXmg_right:(CGFloat)xmg_right
{
    self.xmg_x = xmg_right - self.xmg_width;
}

- (void)setXmg_bottom:(CGFloat)xmg_bottom
{
    self.xmg_y = xmg_bottom - self.xmg_height;
}
@end
