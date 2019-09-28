//
//  XMGCommentViewController.m
//  4期-百思不得姐
//
//  Created by xiaomage on 15/10/23.
//  Copyright © 2015年 xiaomage. All rights reserved.
//

#import "XMGCommentViewController.h"
#import "XMGHTTPSessionManager.h"
#import "XMGRefreshHeader.h"
#import "XMGRefreshFooter.h"
#import "XMGTopic.h"
#import "XMGComment.h"
#import <MJExtension.h>
#import "XMGCommentSectionHeader.h"
#import "XMGCommentCell.h"
#import "XMGTopicCell.h"

@interface XMGCommentViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomMargin;
/** 任务管理者 */
@property (nonatomic, strong) XMGHTTPSessionManager *manager;
//
///** 最热评论数据 */
@property (nonatomic, strong) NSArray<XMGComment *> *hotestComments;
//
///** 最新评论数据 */
@property (nonatomic, strong) NSMutableArray<XMGComment *> *latestComments;
//
//
///** 最热评论 */
@property (nonatomic, strong) XMGComment *savedTopCmt;
@end

@implementation XMGCommentViewController

static NSString *const XMGCommentCellID = @"comment";
static NSString *const XMGSectionHeaderID = @"header";
#pragma mark - 懒加载
- (XMGHTTPSessionManager *)manager{
    if (!_manager) {
        _manager = [XMGHTTPSessionManager manager];
    }
    return _manager;
}

#pragma mark - 初始化
- (void)viewDidLoad{
    [super viewDidLoad];
    
    [self setupTable];
    [self loadNewTopics];
    [self setupRefresh];
    [self setupBase];
    [self setupHeader];
    
}

- (void)setupHeader{
    //处理模型数据
    self.savedTopCmt = self.topic.top_cmt;
    self.topic.top_cmt = nil;
    self.topic.cellHeight = 0;
    //创建header
    UIView *header = [[UIView alloc]init];
    //添加cell到header
    XMGTopicCell *cell = [XMGTopicCell viewFormXib];
    cell.topic = self.topic;
    cell.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, self.topic.cellHeight);
    [header addSubview:cell];
    //设置header高度
    header.xmg_height = cell.xmg_height + XMGMargin * 2;
    //设置header
    self.tableView.tableHeaderView = header;
}

- (void)setupBase{
    self.navigationItem.title = @"评论";
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    self.topic.top_cmt = self.savedTopCmt;
    self.topic.cellHeight = 0;
}
- (void)setupTable{
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([XMGCommentCell class]) bundle:nil] forCellReuseIdentifier:XMGCommentCellID];
    [self.tableView registerClass:[XMGCommentSectionHeader class] forHeaderFooterViewReuseIdentifier:XMGSectionHeaderID];
       
       self.tableView.backgroundColor = XMGCommonBgColor;
       self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
       
       // 每一组头部控件的高度
       self.tableView.sectionHeaderHeight = XMGCommentSectionHeaderFont.lineHeight + 2;
       
       // 设置cell的高度
       self.tableView.rowHeight = UITableViewAutomaticDimension;
       self.tableView.estimatedRowHeight = 44;
}

- (void)setupRefresh{
    self.tableView.mj_header = [XMGRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewTopics)];
    [self.tableView.mj_header endRefreshing];
    self.tableView.mj_footer = [XMGRefreshFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreTopics)];
    
}

#pragma mark -数据加载
- (void)loadNewTopics{
    //取消所有请求
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    //参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"dataList";
    params[@"c"] = @"comment";
    params[@"data_id"] = self.topic.ID;
    params[@"hot"] = @1;
    
    __weak typeof(self) weakSelf = self;
    //发送请求
    [self.manager GET:XMGCommonURL parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //没有任何评论数据
        if (![responseObject isKindOfClass:[NSDictionary class]]) {
            //结束刷新控件
            [weakSelf.tableView.mj_header endRefreshing];
            return ;
        }
        //字典数组-->模型数组
        weakSelf.latestComments = [XMGComment mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        weakSelf.hotestComments = [XMGComment mj_objectArrayWithKeyValuesArray:responseObject[@"hot"]];
        //刷新表格
        [weakSelf.tableView reloadData];
        //结束刷新控件
        [weakSelf.tableView.mj_header endRefreshing];
        
        int total = [responseObject[@"total"] intValue];
        if (weakSelf.latestComments.count == total) {//全部加载
            //隐藏
            weakSelf.tableView.mj_footer.hidden = YES;
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //结束刷新控件
        [weakSelf.tableView.mj_header endRefreshing];
    }];
}

- (void)loadMoreTopics{
     // 取消所有请求
       [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
       
       // 参数
       NSMutableDictionary *params = [NSMutableDictionary dictionary];
       params[@"a"] = @"dataList";
       params[@"c"] = @"comment";
       params[@"data_id"] = self.topic.ID;
       params[@"lastcid"] = self.latestComments.lastObject.ID;
       
       __weak typeof(self) weakSelf = self;
       
       // 发送请求
       [self.manager GET:XMGCommonURL parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
           if (![responseObject isKindOfClass:[NSDictionary class]]) {
               [weakSelf.tableView.mj_footer endRefreshing];
               return;
           }
           
           // 字典数组 -> 模型数组
           NSArray *moreComments = [XMGComment mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
           [weakSelf.latestComments addObjectsFromArray:moreComments];
           
           // 刷新表格
           [weakSelf.tableView reloadData];
           
           int total = [responseObject[@"total"] intValue];
           if (weakSelf.latestComments.count == total) { // 全部加载完毕
               // 提示用户:没有更多数据
               // [weakSelf.tableView.mj_footer endRefreshingWithNoMoreData];
               weakSelf.tableView.mj_footer.hidden = YES;
           } else { // 还没有加载完全
               // 结束刷新
               [weakSelf.tableView.mj_footer endRefreshing];
           }
       } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
           // 结束刷新
           [weakSelf.tableView.mj_footer endRefreshing];
       }];
}



#pragma mark - 监听
- (void)keyboardWillChangeFrame:(NSNotification *)notifi{
    //修改约束
    CGFloat keyboardY = [notifi.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue].origin.y;
    CGFloat screenH = [UIScreen mainScreen].bounds.size.height;
    self.bottomMargin.constant = screenH - keyboardY;
    
    //执行动画
    CGFloat duration = [notifi.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    [UIView animateWithDuration:duration animations:^{
        [self.view layoutIfNeeded];
    }];
}

#pragma mark - 数据源
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    //有最热评论 + 最热评论数据
    if (self.hotestComments.count) return 2;
    //没有最热评论，有最热评论数据
    if (self.latestComments.count) return 1;
    //都没有
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    //第0组， && 有最热评论数据
    if (section == 0 && self.hotestComments.count) {
        return self.hotestComments.count;
    }
    //其他情况
    return self.latestComments.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    XMGCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:XMGCommentCellID];
    if (indexPath.section == 0 && self.hotestComments.count) {
        cell.comment = self.hotestComments[indexPath.row];
    }else{
        cell.comment = self.latestComments[indexPath.row];
    }
    return cell;
}

#pragma mark - UITableViewDelegate
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    XMGCommentSectionHeader *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:XMGSectionHeaderID];
    //第0组， && 有最热评论数据
       if (section == 0 && self.hotestComments.count) {
           header.textLabel.text = @"最热评论";
       }else{ //其他情况
           header.textLabel.text = @"最新评论";
       }
    return header;
}

/// 当用户开始拖拽scrollView就会调用一次
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self.view endEditing:YES];
}
@end
