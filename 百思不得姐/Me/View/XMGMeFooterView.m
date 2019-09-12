//
//  XMGMeFooterView.m
//  百思不得姐
//
//  Created by 孙 on 2019/9/11.
//  Copyright © 2019 小情调. All rights reserved.
//

#import "XMGMeFooterView.h"
#import "XMGMeSquare.h"
#import <MJExtension.h>
#import <AFNetworking.h>
#import <UIButton+WebCache.h>
@implementation XMGMeFooterView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        //参数
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        params[@"a"] = @"square";
        params[@"c"] = @"topic";
        //请求
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        [manager GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
            XMGLog(@"这是啥 %@",downloadProgress);
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            XMGLog(@"请求成功 %@  %@",[responseObject class], responseObject);
            //字典数组-->模型数组
            NSArray *squares = [XMGMeSquare mj_objectArrayWithKeyValuesArray:responseObject[@"square_list"]];
            //根据模型数据创建对应的控件
            [self createSquares:squares];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            XMGLog(@"请求失败 %@",error);
        }];
    }
    return self;
}

/**
 根据模型数据创建对应的控件
 */
- (void)createSquares:(NSArray *)squares{
    //方块个数
    NSUInteger count = squares.count;
    //方块的尺寸
    int maxColsCount = 4;//一行最大列数
    CGFloat buttonW = self.xmg_width / maxColsCount;
    CGFloat buttonH = buttonW;
    //创建所有的方块
    for (NSUInteger i = 0; i < count - 1; i++) {
        //i位置对应的模型数据
        XMGMeSquare *square = squares[i];
        
        //创建按钮
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        //设置frame
        button.xmg_x = (i % maxColsCount) * buttonW;
        button.xmg_y = (i / maxColsCount) * buttonH;
        button.xmg_width = buttonW;
        button.xmg_height = buttonH;
        //设置数据
        button.backgroundColor = XMGRandomColor;
        [button setTitle:square.name forState:UIControlStateNormal];
        [button sd_setImageWithURL:[NSURL URLWithString:square.icon] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"setup-head-default"]];
    }
    XMGLog(@"%@", self.subviews.lastObject);
    //设置footView高度 == 最后一个按钮的bottom（最大Y值）
    self.xmg_height = self.subviews.lastObject.xmg_bottom;
    UITableView *tableView = (UITableView *)self.superview;
    tableView.contentSize = CGSizeMake(0, self.xmg_bottom);
}

- (void)buttonClick:(UIButton *)button{
    
}
@end
