//
//  XMGTableBarController.m
//  百思不得姐
//
//  Created by 孙 on 2019/8/24.
//  Copyright © 2019 小情调. All rights reserved.
//

#import "XMGTableBarController.h"
#import "XMGTabBar.h"


@interface XMGTableBarController ()

@end

@implementation XMGTableBarController


- (void)viewDidLoad {
    [super viewDidLoad];

    //文字属性
    UITabBarItem *item = [UITabBarItem appearance];
    //普通状态下文字
    NSMutableDictionary *normalAttri = [NSMutableDictionary dictionary];
    normalAttri[NSFontAttributeName] = [UIFont systemFontOfSize:14];
    normalAttri[NSForegroundColorAttributeName] = [UIColor grayColor];
    [item setTitleTextAttributes:normalAttri forState:UIControlStateNormal];
    //选中状态下的文字
    NSMutableDictionary *selectedAttri = [NSMutableDictionary dictionary];
    selectedAttri[NSForegroundColorAttributeName] = [UIColor darkGrayColor];
    [item setTitleTextAttributes:selectedAttri forState:UIControlStateSelected];
    
    //创建子控制器
    [self setupOneChildViewController:[[UITableViewController alloc]init] title:@"精华" image:@"tabBar_essence_icon" selectedImage:@"tabBar_essence_click_icon"];
    [self setupOneChildViewController:[[UIViewController alloc]init] title:@"新帖" image:@"tabBar_new_icon" selectedImage:@"tabBar_new_click_icon"];
    
    [self setupOneChildViewController:[[UITableViewController alloc]init] title:@"关注" image:@"tabBar_friendTrends_icon" selectedImage:@"tabBar_friendTrends_click_icon"];
    [self setupOneChildViewController:[[UIViewController alloc]init] title:@"我" image:@"tabBar_me_icon" selectedImage:@"tabBar_me_click_icon"];
    
    /***更换tabBar***/
    [self setValue:[[XMGTabBar alloc]init] forKey:@"tabBar"];
}

/**
 初始化一个子控制器

 @param vc 子控制器
 @param title 标题
 @param image 图标
 @param selectedImage 选中的图标
 */
-(void)setupOneChildViewController:(UIViewController *)vc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage{
    vc.view.backgroundColor = XMGRandomColor;
    vc.tabBarItem.title = title;
    if (image.length) {
        vc.tabBarItem.image = [UIImage imageNamed:image];
        vc.tabBarItem.selectedImage = [UIImage imageNamed:selectedImage];
    }
    [self addChildViewController:vc];
    
}
@end
