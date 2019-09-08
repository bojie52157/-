//
//  XMGFollowViewController.m
//  百思不得姐
//
//  Created by 孙 on 2019/8/26.
//  Copyright © 2019 小情调. All rights reserved.
//

#import "XMGFollowViewController.h"
#import "XMGRecommendFollowViewController.h"
#import "XMGLoginRegisterViewController.h"
@interface XMGFollowViewController ()

@end

@implementation XMGFollowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"我的关注";
    //左边
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"friendsRecommentIcon" highImage:@"friendsRecommentIcon-click" target:self action:@selector(followClick)];
}

- (IBAction)LoginRegister {
    XMGLoginRegisterViewController *loginRegister = [[XMGLoginRegisterViewController alloc]init];
    [self presentViewController:loginRegister animated:YES completion:nil];
}

- (void)followClick{
    XMGRecommendFollowViewController *recommend = [[XMGRecommendFollowViewController alloc]init];
    [self.navigationController pushViewController:recommend animated:YES];
}


@end
