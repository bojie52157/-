//
//  XMGSettingViewController.m
//  百思不得姐
//
//  Created by 孙 on 2019/8/28.
//  Copyright © 2019 小情调. All rights reserved.
//

#import "XMGSettingViewController.h"
#import "XMGClearCacheCell.h"
#import <SDImageCache.h>
@interface XMGSettingViewController ()

@end

@implementation XMGSettingViewController

static NSString * const XMGClearCacheCellID = @"XMGClearCacheCell";

- (instancetype)init{
    return [self initWithStyle:UITableViewStyleGrouped];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.title = @"设置";
    
    //注册cell
    [self.tableView registerClass:[XMGClearCacheCell class] forCellReuseIdentifier:XMGClearCacheCellID];
}


#pragma mark - 数据源代理方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //取出cell
    XMGClearCacheCell *cell = [tableView dequeueReusableCellWithIdentifier:XMGClearCacheCellID];
    //返回cell
    return cell;
}
@end
