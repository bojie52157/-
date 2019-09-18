//
//  XMGSettingViewController.m
//  百思不得姐
//
//  Created by 孙 on 2019/8/28.
//  Copyright © 2019 小情调. All rights reserved.
//

#import "XMGSettingViewController.h"
#import "XMGClearCacheCell.h"
#import "XMGSettingCell.h"
#import <SDImageCache.h>
@interface XMGSettingViewController ()

@end

@implementation XMGSettingViewController

static NSString * const XMGClearCacheCellID = @"XMGClearCacheCell";
static NSString * const XMGSettingCellID = @"XMGSettingCell";

- (instancetype)init{
    return [self initWithStyle:UITableViewStyleGrouped];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.title = @"设置";
    //注册cell
    [self.tableView registerClass:[XMGClearCacheCell class] forCellReuseIdentifier:XMGClearCacheCellID];
    [self.tableView registerClass:[XMGSettingCell class] forCellReuseIdentifier:XMGSettingCellID];
}


#pragma mark - 数据源代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {//清除缓存
        return [tableView dequeueReusableCellWithIdentifier:XMGClearCacheCellID];
    }else{
        XMGSettingCell *cell = [tableView dequeueReusableCellWithIdentifier:XMGSettingCellID];
        if (indexPath.row == 1) {
            cell.textLabel.text = @"自定义celltest";
        }else {
            cell.textLabel.text = @"test中";
        }
        return cell;
}
}
@end
