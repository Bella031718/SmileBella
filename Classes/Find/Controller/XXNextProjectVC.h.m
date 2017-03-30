//
//  XXNectProjectVC.m
//  SmileBella
//
//  Created by Bella on 17/1/23.
//  Copyright © 2017年 Bella. All rights reserved.
//

#import "XXNextProjectVC.h"
#import "XXVideoListModel.h"
#import "XXVideoListCell.h"
#import <UIImageView+WebCache.h>
#import "XXDailyDetailVC.h"
#import <SVProgressHUD.h>
#import <AFNetworking.h>
#import "XXGIfFooter.h"
#import "XXGIfRfresh.h"
#import "XXVideoListModel.h"
#import "NSArray+XX.h"

@interface XXNextProjectVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong)NSMutableArray *ListArr;
@property (nonatomic, strong) NSString *nextPageUrl;

@end

@implementation XXNextProjectVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initTableview];
    
    [self setupRefresh];
}

//刷新控件
- (void)setupRefresh
{
    self.tableView.mj_header = [XXGIfRfresh headerWithRefreshingTarget:self refreshingAction:@selector(getNetDate)];
    
    [self.tableView.mj_header beginRefreshing];
    
    // footer
    self.tableView.mj_footer = [XXGIfFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreJson)];
    
    
}//

-(void)getNetDate{
    
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [SVProgressHUD showWithStatus:@"数据正在加载"];
    
    self.ListArr = [[NSMutableArray alloc]init];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager new];
    
    NSString *url = [NSString stringWithFormat:@"%@%@%@",ZhuanTi1,self.model.idStr,ZhuanTi2];
    [manager GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        self.nextPageUrl = [NSString stringWithFormat:@"%@",responseObject[@"nextPageUrl"]];
        NSDictionary *itemListDict = [responseObject objectForKey:@"itemList"];
        
        for (NSDictionary *dict in itemListDict) {
            NSDictionary *dataDict = dict[@"data"];
            
            XXVideoListModel *model = [[XXVideoListModel alloc]init];
            model.ImageView = [NSString stringWithFormat:@"%@",dataDict[@"cover"][@"detail"]];
            model.titleLabel = [NSString stringWithFormat:@"%@",dataDict[@"title"]];
            model.category = [NSString stringWithFormat:@"%@",dataDict[@"category"]];
            model.duration = [NSString stringWithFormat:@"%@",dataDict[@"duration"]];
            model.desc = [NSString stringWithFormat:@"%@",dataDict[@"description"]];
            model.playUrl = [NSString stringWithFormat:@"%@",dataDict[@"playUrl"]];
            NSDictionary *Dic = dataDict[@"consumption"];
            model.consumption = Dic;
            
            [_ListArr addObject:model];
        }
        
        [self.tableView reloadData];
        [SVProgressHUD dismiss];
        [self.tableView.mj_header endRefreshing];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD dismiss];
        [self.tableView.mj_header endRefreshing];
        
    }];
    
}

-(void)loadMoreJson{
    
    if ([self.nextPageUrl isEqualToString:@"<null>"]) {
        [self.tableView.mj_footer endRefreshingWithNoMoreData];
    }else{
        [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
        [SVProgressHUD showWithStatus:@"数据加载中"];
        
        AFHTTPSessionManager *manager = [AFHTTPSessionManager new];
        [manager GET:self.nextPageUrl parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            self.nextPageUrl = [NSString stringWithFormat:@"%@",responseObject[@"nextPageUrl"]];
            NSDictionary *itemListDict = [responseObject objectForKey:@"itemList"];
            
            for (NSDictionary *dict in itemListDict) {
                NSDictionary *dataDict = dict[@"data"];
                
                XXVideoListModel *model = [[XXVideoListModel alloc]init];
                model.ImageView = [NSString stringWithFormat:@"%@",dataDict[@"cover"][@"detail"]];
                model.titleLabel = [NSString stringWithFormat:@"%@",dataDict[@"title"]];
                model.category = [NSString stringWithFormat:@"%@",dataDict[@"category"]];
                model.duration = [NSString stringWithFormat:@"%@",dataDict[@"duration"]];
                model.desc = [NSString stringWithFormat:@"%@",dataDict[@"description"]];
                model.playUrl = [NSString stringWithFormat:@"%@",dataDict[@"playUrl"]];
                NSDictionary *Dic = dataDict[@"consumption"];
                model.consumption = Dic;
                
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

-(void)initTableview{
    
    _tableView  = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate  = self;
    
    _tableView.rowHeight = kScreenHeight/3;
    _tableView.separatorStyle = NO;
    [self.view addSubview:_tableView];
    
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
//    if (indexPath.row < _ListArr.count) {
    XXVideoListModel *model = [_ListArr objectAtIndexCheck:indexPath.row];
    [cell.ImageView sd_setImageWithURL:[NSURL URLWithString:model.ImageView]];
    cell.titleLabel.text = model.titleLabel;
    cell.messageLabel.text = [NSString stringWithFormat:@"#%@%@%@",model.category,@" / ",[self timeStrFormTime:model.duration]];
//    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    XXDailyDetailVC *detail= [[XXDailyDetailVC alloc]init];
   
    detail.model = [_ListArr objectAtIndexCheck:indexPath.row];
   
     [self.navigationController pushViewController:detail animated:YES];
    
//    [self presentViewController:detail animated:YES completion:nil];
    
}

//转换时间格式
-(NSString *)timeStrFormTime:(NSString *)timeStr
{
    int time = [timeStr intValue];
    int minutes = time / 60;
    int second = (int)time % 60;
    return [NSString stringWithFormat:@"%02d'%02d\"",minutes,second];
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
