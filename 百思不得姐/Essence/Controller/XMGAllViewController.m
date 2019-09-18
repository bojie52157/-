//
//  XMGAllViewController.m
//  百思不得姐
//
//  Created by 孙 on 2019/9/18.
//  Copyright © 2019 小情调. All rights reserved.
//

#import "XMGAllViewController.h"
#import "XMGTopic.h"
#import <MJExtension.h>
#import <AFNetworking.h>
#import <UIImageView+WebCache.h>
#import "XMGRefreshHeader.h"
@interface XMGAllViewController ()
/**
 所有的帖子数据
 */
@property (nonatomic, strong)NSArray<XMGTopic *> *topics;
/**
 下拉刷新的提示文字
 */
@property (nonatomic, weak) UILabel *label;
@end

@implementation XMGAllViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.contentInset = UIEdgeInsetsMake(64 + 35, 0, 49, 0);
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
    
    [self loadNewTopics];
    [self setupRefresh];
}

- (void)setupRefresh{
    self.tableView.mj_header =  [XMGRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewTopics)];;
}

#pragma mark - 数据加载
- (void)loadNewTopics{
    
    //参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"data";
    //请求
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //字典数组--》模型数组
        self.topics = [XMGTopic mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
//        XMGLog(@"%@",responseObject[@"list"]);
        //刷新表格
        [self.tableView reloadData];
        //让刷新控件结束刷新
        [self.tableView.mj_header endRefreshing];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //让刷新控件结束刷新
        [self.tableView.mj_header endRefreshing];
        XMGLog(@"请求失败 %@",error);
    }];
    
    
}

#pragma mark - tableView数据源
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.topics.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //1.确定重用标示
    static NSString *ID = @"cell";
    //2.从缓存池中取
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    //3.如果没有手动创建
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
        cell.backgroundColor = XMGRandomColor;
    }
    
    //4.显示数据
    XMGTopic *topic = self.topics[indexPath.row];
    cell.textLabel.text = topic.name;
    cell.detailTextLabel.text = topic.text;
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:topic.profile_image] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    
    return cell;
}

#pragma mark -

@end
