//
//  XXVideoVC.m
//  SmileBella
//
//  Created by Bella on 16/12/23.
//  Copyright © 2016年 Bella. All rights reserved.
//

#import "XXVideoVC.h"
#import <AFNetworking.h>
#import <MJExtension.h>
#import "UIView+Frame.h"
#import <SVProgressHUD.h>
#import "XXVideoCell.h"
#import "XXVideoModel.h"
#import <MJRefresh.h>
#import "XXGIfRfresh.h"
#import <UIImageView+WebCache.h>
#import "XXGIfFooter.h"
#import <UITableView+FDTemplateLayoutCell.h>
//#import "XXPlayVC.h"
#import "XXAVPlay.h"
#import "XXZFplayVC.h"


@interface XXVideoVC ()
/** 最后刷新时间*/
@property (nonatomic, copy) NSString *maxtime;
/** 所有的帖子数据 */
@property (nonatomic, strong) NSMutableArray<XXVideoModel *> *dataArry;

@property (nonatomic, strong)AFHTTPSessionManager *manager;

@end


@implementation XXVideoVC

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
    [self.tableView registerClass:[XXVideoCell class]  forCellReuseIdentifier:NSStringFromClass([XXVideoCell class])];
    
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
    
    // 拼接参数
//    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
//    dict[@"maxtime"] = self.maxtime;
//    dict[@"type"] = @41;
//    
//    __weak typeof (self)weakSelf = self;
//    
//    [XXAllVideoModel getEssenceModelWith:dict complection:^(XXAllVideoModel *AllVideomodel) {
//        weakSelf.maxtime = AllVideomodel.info.maxtime;//最后刷新时间
//        weakSelf.dataArry = AllVideomodel.videoArry.mutableCopy;
//        [weakSelf.tableView.mj_header endRefreshing];
//        
//    } failure:^(NSError *error) {
//        // 结束刷新
//        [weakSelf.tableView.mj_header endRefreshing];
//    }];
    
    
    // 1.取消之前的请求
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    
    // 2.拼接参数
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = @"list";
    parameters[@"c"] = @"data";
    parameters[@"type"] = @41;
    
    // 3.发送请求
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id _Nullable responseObject) {
        // 存储maxtime
        self.maxtime = responseObject[@"info"][@"maxtime"];
        
        // 字典数组 -> 模型数据
        self.dataArry = [XXVideoModel mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        NSLog(@"resp------%@",[self.dataArry lastObject]);
        
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
    parameters[@"type"] = @41;
    parameters[@"maxtime"] = self.maxtime;
    
    // 3.发送请求
    [self.manager GET:NetworkURL parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id _Nullable responseObject) {
        // 存储maxtime
        self.maxtime = responseObject[@"info"][@"maxtime"];
        
        // 字典数组 -> 模型数据
        NSArray *moreTopicsArr = [XXVideoModel mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        // 累加到旧数组的后面
        [self.dataArry addObjectsFromArray:moreTopicsArr];
        
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

    
    
//    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
//    dict[@"maxtime"] = self.maxtime;
//    dict[@"type"] = @41;
//    __weak typeof(self) weakSelf = self;
//    
//    [XXAllVideoModel getEssenceModelWith:dict complection:^(XXAllVideoModel *AllVideoModel) {
//        weakSelf.maxtime = AllVideoModel.info.maxtime;
//        [weakSelf.dataArry addObjectsFromArray:AllVideoModel.videoArry];
//       
//        
//        [weakSelf.tableView reloadData];
//        
//        [weakSelf.tableView.mj_footer endRefreshing];
//        
//    } failure:^(NSError *error) {
//        [weakSelf.tableView.mj_footer endRefreshing];
//    }];
//    
    
    


}

#pragma mark - 数据源
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return self.dataArry.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Class currentClass = [XXVideoCell class];
    XXVideoCell * cell = nil;
    XXVideoModel *model = self.dataArry[indexPath.row];
    cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(currentClass)];
    cell.model = model;
    
    __weak typeof(self)weakSelf = self;
    //跳转到播放视频控制器
    cell.playblock = ^{
      XXZFplayVC   *play = [[XXZFplayVC alloc]init];
//        XXAVPlay *play = [[XXAVPlay alloc]init];
        play.urlStr = model.videouri;
        NSLog(@"~~~~~~%@",model.videouri);
        
        [weakSelf.navigationController pushViewController:play animated:YES];
        
    };
    
    
   
    return cell;

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    XXVideoModel *model = self.dataArry[indexPath.row];
//    return [tableView fd_heightForCellWithIdentifier:NSStringFromClass([XXVideoCell class]) cacheByIndexPath:indexPath configuration:^(XXVideoCell *cell) {
//        cell.model = model;
//    }];
//    return 450;
    return self.dataArry[indexPath.row].cellHeight;
    
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





/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
