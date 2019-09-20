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
#import "XMGHTTPSessionManager.h"
#import <UIImageView+WebCache.h>
#import "XMGRefreshHeader.h"
#import "XMGRefreshFooter.h"
#import "XMGTopicCell.h"
@interface XMGAllViewController ()
/**所有的帖子数据*/
@property (nonatomic, strong)NSMutableArray<XMGTopic *> *topics;
/**下拉刷新的提示文字*/
@property (nonatomic, weak) UILabel *label;
/**maxtime ： 用来加载下一页数据*/
@property (nonatomic, copy) NSString *maxtime;
/**manager*/
@property (nonatomic, strong) XMGHTTPSessionManager *manager;
@end

@implementation XMGAllViewController

static NSString *const XMGTopicCellID = @"topic";
#pragma mark - 懒加载
- (XMGHTTPSessionManager *)manager{
    if (!_manager) {
        _manager = [XMGHTTPSessionManager manager];
    }
    return _manager;
}

#pragma mark - 初始化
- (void)viewDidLoad {
    [super viewDidLoad];
 
    [self setupTable];
    [self loadNewTopics];
    [self setupRefresh];
}

- (void)setupTable{
    self.tableView.backgroundColor = XMGCommonBgColor;
    self.tableView.contentInset = UIEdgeInsetsMake(40 , 0, 49, 0);
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
    self.tableView.rowHeight = 200;
    //注册nib
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([XMGTopicCell class]) bundle:nil] forCellReuseIdentifier:XMGTopicCellID];
}

- (void)setupRefresh{
    self.tableView.mj_header = [XMGRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewTopics)];
    self.tableView.mj_footer = [XMGRefreshFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreTopics)];
}

#pragma mark - 数据加载
- (void)loadNewTopics{
    //取消所有请求
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    //参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"data";
    //请求
    [self.manager GET:XMGCommonURL parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //存储maxtime（方便用来加载下一页数据）
        self.maxtime = responseObject[@"info"][@"maxtime"];
        //字典数组--》模型数组
        self.topics = [XMGTopic mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
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

#pragma mark -加载更多
- (void)loadMoreTopics{
    //取消所有请求
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    //参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"data";
    params[@"maxtime"] = self.maxtime;
    //请求
    [self.manager GET:XMGCommonURL parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //字典数组--》模型数组
        NSArray<XMGTopic *> *moreTopics = [XMGTopic mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        [self.topics addObjectsFromArray:moreTopics];
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
    XMGTopicCell *cell = [tableView dequeueReusableCellWithIdentifier:XMGTopicCellID];
    cell.topic = self.topics[indexPath.row];
    return cell;
}

#pragma mark -

@end
