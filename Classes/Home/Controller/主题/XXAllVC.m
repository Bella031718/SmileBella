//
//  XXAllVC.m
//  SmileBella
//
//  Created by Bella on 16/12/23.
//  Copyright © 2016年 Bella. All rights reserved.
//

#import "XXAllVC.h"

#import <AFNetworking.h>
#import <MJExtension.h>
#import "UIView+Frame.h"
#import <SVProgressHUD.h>
#import "XXAllCell.h"
#import "XXAllModel.h"
#import <MJRefresh.h>
#import "XXGIfRfresh.h"
#import <UIImageView+WebCache.h>
#import "XXGIfFooter.h"

@interface XXAllVC ()

/** 当前最后一条帖子数据的描述信息，专门用来加载下一页数据 */
@property (nonatomic, copy) NSString *maxtime;
/** 所有的帖子数据 */
@property (nonatomic, strong) NSMutableArray<XXAllModel *> *topicsArry;

/** 请求管理者 */
@property (nonatomic, strong) AFHTTPSessionManager *manager;

@end

@implementation XXAllVC

/** 在这里实现type方法，仅仅是为了消除警告 */
- (XXAllModelType)type {return 0;}


- (AFHTTPSessionManager *)manager
{
    if (!_manager) {
        _manager = [AFHTTPSessionManager manager];
    }
    return _manager;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.contentInset = UIEdgeInsetsMake(64 + 35, 0, 49, 0);
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    //初始化注册cell 加载cell展示数据
    [self.tableView registerClass:[XXAllCell class]  forCellReuseIdentifier:NSStringFromClass([XXAllCell class])];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tabBarButtonDidRepeatClick) name:@"TabBarAgain" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(titleButtonDidRepeatClick) name:@"TabBarClick" object:nil];
    
    [self setupRefresh];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

//刷新控件
- (void)setupRefresh
{
    self.tableView.mj_header = [XXGIfRfresh headerWithRefreshingTarget:self refreshingAction:@selector(loadNewTopics)];
    
    [self.tableView.mj_header beginRefreshing];
    
    
    // footer
    self.tableView.mj_footer = [XXGIfFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreTopics)];
    
    
}//

#pragma mark - 监听
/**
 *  监听tabBarButton重复点击
 */
- (void)tabBarButtonDidRepeatClick
{
    // 重复点击的不是精华按钮
    if (self.view.window == nil) return;
    
    // 显示在正中间的不是AllViewController
    if (self.tableView.scrollsToTop == NO) return;
    
    // 进入下拉刷新
    [self.tableView.mj_header beginRefreshing];
}

/**
 *  监听titleButton重复点击
 */
- (void)titleButtonDidRepeatClick
{
    [self tabBarButtonDidRepeatClick];
}

#pragma mark - 数据处理
/**
 *  发送请求给服务器，下拉刷新数据
 */
- (void)loadNewTopics
{
    // 1.取消之前的请求
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    
    // 2.拼接参数
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = @"list";
    parameters[@"c"] = @"data";
    parameters[@"type"] = @29;
    
    // 3.发送请求
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id _Nullable responseObject) {
        // 存储maxtime
        self.maxtime = responseObject[@"info"][@"maxtime"];
        
        // 字典数组 -> 模型数据
        self.topicsArry = [XXAllModel mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        NSLog(@"resp------%@",[self.topicsArry lastObject]);
        
        // 刷新表格
        [self.tableView reloadData];
        
        // 结束刷新
        [self.tableView.mj_header endRefreshing];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (error.code != NSURLErrorCancelled) { // 并非是取消任务导致的error，其他网络问题导致的error
            [SVProgressHUD showErrorWithStatus:@"网络繁忙，请稍后再试！"];
            
        }
        
        // 结束刷新
        [self.tableView.mj_header endRefreshing];
    }];
}

/**
 *  发送请求给服务器，上拉加载更多数据
 */
- (void)loadMoreTopics
{
    // 1.取消之前的请求
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    
    // 2.拼接参数
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = @"list";
    parameters[@"c"] = @"data";
    parameters[@"type"] = @29;
    parameters[@"maxtime"] = self.maxtime;
    
    // 3.发送请求
    [self.manager GET:NetworkURL parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id _Nullable responseObject) {
        // 存储maxtime
        self.maxtime = responseObject[@"info"][@"maxtime"];
        
        // 字典数组 -> 模型数据
        NSArray *moreTopicsArr = [XXAllModel mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        // 累加到旧数组的后面
        [self.topicsArry addObjectsFromArray:moreTopicsArr];
        
        // 刷新表格
        [self.tableView reloadData];
        
        // 结束刷新
        [self.tableView.mj_footer endRefreshing];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (error.code != NSURLErrorCancelled) { // 并非是取消任务导致的error，其他网络问题导致的error
            [SVProgressHUD showErrorWithStatus:@"网络繁忙，请稍后再试！"];
        }
        
        // 结束刷新
        [self.tableView.mj_footer endRefreshing];
    }];
}

#pragma mark - 数据源
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // 根据数据量显示或者隐藏footer
    self.tableView.mj_footer.hidden = (self.topicsArry.count == 0);
    return self.topicsArry.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Class currentClass = [XXAllCell class];
    XXAllCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(currentClass)];
    //获取模型 展示数据  
    XXAllModel *model = self.topicsArry[indexPath.row];
    cell.model = model;
    NSLog(@"------------------%@",cell.model);
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return self.topicsArry[indexPath.row].cellHeight;
    
//        return 250;
    
}


#pragma mark - 代理方法
/**
 *  用户松开scrollView时调用
 */


- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    // 清除内存缓存
    [[SDImageCache sharedImageCache] clearMemory];
}



@end
