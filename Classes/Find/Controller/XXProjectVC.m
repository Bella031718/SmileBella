//
//  XXProjectVC.m
//  SmileBella
//
//  Created by Bella on 17/1/18.
//  Copyright © 2017年 Bella. All rights reserved.
//

#import "XXProjectVC.h"
#import "XXVideoListCell.h"
#import "XXVideoListModel.h"
#import <UIImageView+WebCache.h>
#import <SVProgressHUD.h>
#import <AFNetworking.h>
#import "XXGIfRfresh.h"
#import "XXGIfFooter.h"
#import "XXNextProjectVC.h"
#import "NSArray+XX.h" //检查数组是否越界


@interface XXProjectVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) NSString *NextPageStr;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *ListArr;

@end

@implementation XXProjectVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setUItableview];
    
    
    [self setupRefresh];
}

//刷新控件
- (void)setupRefresh
{
    self.tableView.mj_header = [XXGIfRfresh headerWithRefreshingTarget:self refreshingAction:@selector(getProjectDate)];
    
    [self.tableView.mj_header beginRefreshing];
    
    // footer
    self.tableView.mj_footer = [XXGIfFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadJsonDate)];
    
    
}//

#pragma mark -- 获取文件名
-(void)getProjectDate{
    
    self.ListArr = [[NSMutableArray alloc]init];
    
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [SVProgressHUD showWithStatus:@"数据加载中.."];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager new];
    [manager GET:TopUrl parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        self.NextPageStr = [NSString stringWithFormat:@"%@",responseObject[@"nextPageUrl"]];
        
        NSDictionary *itemListDict = [responseObject objectForKey:@"itemList"];
        
        for (NSDictionary *dict in itemListDict) {
            
            NSDictionary *dataDict = dict[@"data"];
            
            XXVideoListModel *model = [[XXVideoListModel alloc]init];
            model.ImageView = [NSString stringWithFormat:@"%@",dataDict[@"image"]];
            model.titleLabel = [NSString stringWithFormat:@"%@",dataDict[@"title"]];
            model.category = [NSString stringWithFormat:@"%@",dataDict[@"dataType"]];
            model.desc = [NSString stringWithFormat:@"%@",dataDict[@"description"]];
            model.actionUrl = [NSString stringWithFormat:@"%@",dataDict[@"actionUrl"]];
            model.idStr = [NSString stringWithFormat:@"%@",dataDict[@"id"]];
            [_ListArr addObject:model];
        }
        
        NSLog(@"respones == %@",responseObject);
        
        
        [self.tableView reloadData];
        [SVProgressHUD dismiss];
    
        [self.tableView.mj_header endRefreshing];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"erro == %@",error);
        [self.tableView.mj_header endRefreshing];
    }];
    
    
    
}

-(void)loadJsonDate{
    if ([self.NextPageStr isEqualToString:@"<null>"]) {
        [self.tableView.mj_footer endRefreshingWithNoMoreData];
    }else{
        [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
        [SVProgressHUD showWithStatus:@"数据加载中..."];
        
        AFHTTPSessionManager *manager = [AFHTTPSessionManager new];
        [manager GET:self.NextPageStr parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            self.NextPageStr = [NSString stringWithFormat:@"%@",responseObject[@"nextPageUrl"]];
            
            NSDictionary *itemListDict = [responseObject objectForKey:@"itemList"];
            
            for (NSDictionary *dict in itemListDict) {
                
                NSDictionary *dataDict = dict[@"data"];
                
                XXVideoListModel *model = [[XXVideoListModel alloc]init];
                model.ImageView = [NSString stringWithFormat:@"%@",dataDict[@"image"]];
                model.titleLabel = [NSString stringWithFormat:@"%@",dataDict[@"title"]];
                model.category = [NSString stringWithFormat:@"%@",dataDict[@"dataType"]];
                model.desc = [NSString stringWithFormat:@"%@",dataDict[@"description"]];
                model.actionUrl = [NSString stringWithFormat:@"%@",dataDict[@"actionUrl"]];
                model.idStr = [NSString stringWithFormat:@"%@",dataDict[@"id"]];
                
                [_ListArr addObject:model];
            
            }
            [self.tableView reloadData];
            [SVProgressHUD dismiss];
            [self.tableView.mj_footer endRefreshing];
    
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [SVProgressHUD dismiss];
            [self.tableView.mj_footer endRefreshing];
            
        }];

    }
    
}


-(void)setUItableview{
    
    self.tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.rowHeight = kScreenHeight/3;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = NO;
    [self.view addSubview:self.tableView];
    
    
}

#pragma mark -- TableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _ListArr.count;
}

//行高
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return kScreenHeight/3;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *ID = @"cell";
    XXVideoListCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[XXVideoListCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
    }

    XXVideoListModel *model = [_ListArr objectAtIndexCheck:indexPath.row];
    [cell.ImageView sd_setImageWithURL:[NSURL URLWithString:model.ImageView]];
 
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    XXNextProjectVC *project = [[XXNextProjectVC alloc]init];
   
    project.model = [_ListArr objectAtIndexCheck:indexPath.row];
   
    [self.navigationController pushViewController:project animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
