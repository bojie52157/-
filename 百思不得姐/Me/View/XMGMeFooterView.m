//
//  XMGMeFooterView.m
//  百思不得姐
//
//  Created by 孙 on 2019/9/11.
//  Copyright © 2019 小情调. All rights reserved.
//

#import "XMGMeFooterView.h"
#import "XMGMeSquare.h"
#import "XMGMeSquareButton.h"
#import "XMGWebViewController.h"
#import <MJExtension.h>
#import <AFNetworking.h>
#import <UIButton+WebCache.h>
#import <SafariServices/SafariServices.h>


@interface XMGMeFooterView()

@end

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
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
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
        //创建按钮
        XMGMeSquareButton *button = [XMGMeSquareButton buttonWithType:UIButtonTypeCustom];
        //一个按钮对应一个模型
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        //设置frame
        button.xmg_x = (i % maxColsCount) * buttonW;
        button.xmg_y = (i / maxColsCount) * buttonH;
        button.xmg_width = buttonW;
        button.xmg_height = buttonH;
        //设置数据
        button.square = squares[i];

    }
    //计算总行数
//    NSUInteger rowsCount = (count + maxColsCount - 1) / maxColsCount;
//    self.xmg_height = rowsCount * buttonH;
    
    
    //设置footView高度 == 最后一个按钮的bottom（最大Y值）
    self.xmg_height = self.subviews.lastObject.xmg_bottom;
  
    //设置tableVIew的contentsize
    UITableView *tableView = (UITableView *)self.superview;
    tableView.tableFooterView = self;
    //重新刷新数据，重新计算contentSize
    [tableView reloadData];
}

- (void)buttonClick:(XMGMeSquareButton *)button{

    NSString *url = button.square.url;
    
    if ([url hasPrefix:@"http"]) {
        //http协议
        //使用SFSafariViewController显示网页
//        SFSafariViewController *webView = [[SFSafariViewController alloc]initWithURL:[NSURL URLWithString:url]];
//        UITabBarController *tabBarVC = (UITabBarController *)self.window.rootViewController;
//        [tabBarVC presentViewController:webView animated:YES completion:nil];
        
    
        //获得“我”模块对应的导航控制器
        UITabBarController *tabBarVC = (UITabBarController *)self.window.rootViewController;
        UINavigationController *nav = tabBarVC.selectedViewController;
        
        //显示XMGWebViewController
        XMGWebViewController *webView = [[XMGWebViewController alloc]init];
        webView.url = url;
        webView.navigationItem.title = button.currentTitle;
        [nav pushViewController:webView animated:YES];
    }else if([url hasPrefix:@"mod"]){
        //mod协议
        if ([url hasSuffix:@"BDJ_To_Check"]) {
            XMGLog(@"跳转到审貼界面");
        }else if ([url hasSuffix:@"BDJ_To_RecentHot"]){
            XMGLog(@"跳转到每日排行界面");
        }else{
            XMGLog(@"跳转到其他界面");
        }
    }else{
        XMGLog(@"不是HTTP协议，也不是mod");
    }

}
@end
