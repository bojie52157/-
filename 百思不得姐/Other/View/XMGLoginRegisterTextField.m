//
//  XMGLoginRegisterTextField.m
//  百思不得姐
//
//  Created by 孙 on 2019/8/30.
//  Copyright © 2019 小情调. All rights reserved.
//

#import "XMGLoginRegisterTextField.h"

@implementation XMGLoginRegisterTextField

- (void)awakeFromNib{
    [super awakeFromNib];
    //设置光标颜色
    self.tintColor = [UIColor whiteColor];
    //设置默认的占位文字颜色
    self.placeholderColor = [UIColor grayColor];
    
    [self addTarget:self action:@selector(editingDidBegin) forControlEvents:UIControlEventEditingDidBegin];
    [self addTarget:self action:@selector(editingDidEnd) forControlEvents:UIControlEventEditingDidEnd];
    
}

///开始编辑
- (void)editingDidBegin{
    self.placeholderColor = [UIColor whiteColor];
}

//结束编辑
- (void)editingDidEnd{

    self.placeholderColor = [UIColor grayColor];
    
}



/*
- (void)drawPlaceholderInRect:(CGRect)rect{
 
    //文字属性
//    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
//    attrs[NSForegroundColorAttributeName] = [UIColor whiteColor];
//    attrs[NSFontAttributeName] = self.font;
//
//    //画出占位文字
//    CGPoint placeholderPoint = CGPointMake(0, (rect.size.height - self.font.lineHeight) * 0.5);
//    [self.placeholder drawAtPoint:placeholderPoint withAttributes:attrs];
 
}
 */
@end
