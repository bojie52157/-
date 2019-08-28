//
//  XMGEssenceViewController.m
//  百思不得姐
//
//  Created by 孙 on 2019/8/26.
//  Copyright © 2019 小情调. All rights reserved.
//

#import "XMGEssenceViewController.h"

@interface XMGEssenceViewController ()

@end

@implementation XMGEssenceViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    //标题
    self.navigationItem.titleView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"MainTitle"]];
    //左边
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"MainTagSubIcon" highImage:@"MainTagSubIconClick" target:self action:@selector(tagClick)];
}

- (void)tagClick{
    
}

@end
