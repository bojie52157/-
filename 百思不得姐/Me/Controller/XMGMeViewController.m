//
//  XMGMeViewController.m
//  百思不得姐
//
//  Created by 孙 on 2019/8/26.
//  Copyright © 2019 小情调. All rights reserved.
//

#import "XMGMeViewController.h"
#import "XMGSettingViewController.h"
#import "XMGMeCell.h"
#import "XMGMeFooterView.h"
@interface XMGMeViewController ()
@end

@implementation XMGMeViewController

- (instancetype)init{
    return [self initWithStyle:UITableViewStyleGrouped];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupTable];
    [self setupNav];
    
}

- (void)setupTable{
    self.tableView.sectionHeaderHeight = 0;
    self.tableView.sectionFooterHeight = XMGMargin;
    self.tableView.contentInset = UIEdgeInsetsMake(XMGMargin - 35, 0, 0, 0);
    
   //设置footer
    self.tableView.tableFooterView = [[XMGMeFooterView alloc]init];
}

- (void)setupNav{
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


#pragma mark - 数据源代理方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //1.确定重用标示
    static NSString *ID = @"cell";
    //2.从缓存池中取
    XMGMeCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    //3.如果为空就自己创建
    if (!cell) {
        cell = [[XMGMeCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    //4.设置数据
    if (indexPath.section == 0) {
        cell.textLabel.text = @"登录/注册";
        cell.imageView.image = [UIImage imageNamed:@"setup-head-default"];
    }else{
        cell.textLabel.text = @"离线下线";
        //只要有其他cell设置过imageView.image,其他不显示图片的cell都需要设置imageView.image = nil
        cell.imageView.image = nil;
    }
    
    return cell;
}
@end
