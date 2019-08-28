//
//  XMGMeViewController.m
//  百思不得姐
//
//  Created by 孙 on 2019/8/26.
//  Copyright © 2019 小情调. All rights reserved.
//

#import "XMGMeViewController.h"
#import "XMGSettingViewController.h"
@interface XMGMeViewController ()

@end

@implementation XMGMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"我的";
    //设置
    UIBarButtonItem *settingItem = [UIBarButtonItem itemWithImage:@"mine-setting-icon" highImage:@"mine-setting-icon-click" target:self action:@selector(settingClick)];
    
    //月亮
    UIBarButtonItem *moonItem = [UIBarButtonItem itemWithImage:@"mine-moon-icon" highImage:@"mine-moon-icon-click" target:self action:@selector(moonClick)];
    
    self.navigationItem.rightBarButtonItems = @[moonItem,settingItem];
}

- (void)settingClick{
    XMGSettingViewController *setting = [[XMGSettingViewController alloc]init];
    [self.navigationController pushViewController:setting animated:YES];
}

- (void)moonClick{
    
}

@end
