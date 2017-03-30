//
//  XXPopularVC.m
//  SmileBella
//
//  Created by Bella on 17/1/18.
//  Copyright © 2017年 Bella. All rights reserved.
//

#import "XXPopularVC.h"
#import "XXGIfFooter.h"
#import "XXGIfRfresh.h"
#import <SVProgressHUD.h>
#import <AFNetworking.h>
#import "XXVideoListModel.h"
#import "XXPopularCell.h"
#import <UIImageView+WebCache.h>
#import "XXDailyDetailVC.h"
#import "NSArray+XX.h"

@interface XXPopularVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) NSString *NextPageStr;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *ListArr;

@property (nonatomic, strong) UILabel *topLine;

@property (nonatomic, strong) UILabel *line;

@property (nonatomic, strong) UIButton *seleBtn;

@property (nonatomic, strong) NSString *getNetDataUrl;


@end

@implementation XXPopularVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"排行";
  
    [self initView];
    self.getNetDataUrl = PopularUrl;
    [self setTableVie];
//    [self getPopular];

    
    [self setupRefresh];
}

//刷新控件
- (void)setupRefresh
{
    self.tableView.mj_header = [XXGIfRfresh headerWithRefreshingTarget:self refreshingAction:@selector(getPopular)];
    
    [self.tableView.mj_header beginRefreshing];

        // footer
        self.tableView.mj_footer = [XXGIfFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreJson)];
    
    
}//

-(void)initView{
    
    UIView *topView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, kScreenWidth, 40)];
    topView.backgroundColor = [UIColor whiteColor];
    
    NSArray *arr = [NSArray arrayWithObjects:@"周排行",@"月排行",@"总排行", nil];
    for (int i = 0;i < 3;i ++)
    {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(i*(kScreenWidth/3), 5, kScreenWidth/3, 30);
        btn.tag = i;
        [btn setTitle:arr[i] forState:(UIControlStateNormal)];
        [btn setTitleColor:[UIColor grayColor] forState:(UIControlStateNormal)];
        [btn setTitleColor:[UIColor blackColor] forState:(UIControlStateSelected)];
        [btn addTarget:self action:@selector(Click:) forControlEvents:(UIControlEventTouchUpInside)];
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        [topView addSubview:btn];
        if (i == 0)
        {   btn.selected = YES;
            self.seleBtn = btn;
            btn.titleLabel.font = [UIFont systemFontOfSize:14];
        } else {
            btn.selected = NO;
        }
    }
    CGFloat lineWidth = kScreenWidth/6;
    self.line = [[UILabel alloc]initWithFrame:CGRectMake(lineWidth/2,34, lineWidth, 0.5)];
    self.line.backgroundColor = [UIColor grayColor];
    self.line.tag = 100;
    [topView addSubview:self.line];
    
    self.topLine = [[UILabel alloc]initWithFrame:CGRectMake(lineWidth/2, 5, lineWidth, 0.5)];
    self.topLine.backgroundColor = [UIColor grayColor];
    self.topLine.tag = 101;
    [topView addSubview:self.topLine];
    
    [self.view addSubview:topView];
    
}

-(void)Click:(UIButton *)sender{
    
    if (sender.tag == 0) {
        self.getNetDataUrl = PopularUrl;
    }else if (sender.tag == 1){
        self.getNetDataUrl = PopularMonth;
    }else{
        self.getNetDataUrl = PopularAll;
    }
    
    [self getPopular];
    self.seleBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    self.seleBtn.selected = NO;
    self.seleBtn = sender;
    self.seleBtn.selected = YES;
    self.seleBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [UIView animateWithDuration:0.2 animations:^{
        
        CGPoint frame = self.line.center;
        frame.x = kScreenWidth/6 + kScreenWidth/3 * (sender.tag);
        self.line.center = frame;
        
        CGPoint frame2 = self.topLine.center;
        frame2.x = kScreenWidth/6 + kScreenWidth/3 * (sender.tag);
        self.topLine.center = frame2;
    }];
 
}



#pragma mark  -- 获取URL
-(void)getPopular{
    
    self.ListArr = [[NSMutableArray alloc]init];
    
    //正方形的背景样式(或颜色),黑色背景,白色圆环和文字
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [SVProgressHUD showWithStatus:@"数据加载中..."];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager new];
    [manager GET:self.getNetDataUrl parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
  
        self.NextPageStr = [NSString stringWithFormat:@"%@",responseObject[@"nextPageUrl"]];
        
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
         [self.tableView.mj_header endRefreshing];
        [SVProgressHUD dismiss];
    }];
}

-(void)loadMoreJson{
    
    if ([self.NextPageStr isEqualToString:@"<null>"]) {
        
        [self.tableView.mj_footer endRefreshingWithNoMoreData];
        
    }else{
        
        //正方形的背景样式(或颜色),黑色背景,白色圆环和文字
        [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
        [SVProgressHUD showWithStatus:@"数据加载中..."];
        
        AFHTTPSessionManager *manage  = [AFHTTPSessionManager new];
        [manage GET:self.NextPageStr parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            self.NextPageStr = [NSString stringWithFormat:@"%@",responseObject[@"nextPageUrl"]];
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


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    XXPopularCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[XXPopularCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    }
//    if (indexPath.row < _ListArr.count) {
    
    XXVideoListModel *model = [_ListArr objectAtIndexCheck:indexPath.row];
    
//    _datasourceArray objectAtIndexCheck:indexPath.row]
    
    NSLog(@"_ListArr == %@",_ListArr[indexPath.row]);
    
    [cell.ImageView sd_setImageWithURL:[NSURL URLWithString:model.ImageView]];
    cell.titleLabel.text = model.titleLabel;
    cell.messageLabel.text = [NSString stringWithFormat:@"#%@%@%@",model.category,@" / ",[self timeStrFormTime:model.duration]];
    cell.indexLabel.text = [NSString stringWithFormat:@"%ld",indexPath.row+1];
//    }
    return cell;
}

//点击跳转
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    XXDailyDetailVC *detail = [[XXDailyDetailVC alloc]init];

    detail.model = [_ListArr objectAtIndexCheck:indexPath.row];
  
//    [self presentViewController:detail animated:YES completion:nil];
     [self.navigationController pushViewController:detail animated:YES];
    
    
}


//转换时间格式
-(NSString *)timeStrFormTime:(NSString *)timeStr
{
    int time = [timeStr intValue];
    int minutes = time / 60;
    int second = (int)time % 60;
    return [NSString stringWithFormat:@"%02d'%02d\"",minutes,second];
}

-(void)setTableVie{
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 104, kScreenWidth, kScreenHeight - 104) style:UITableViewStylePlain];
    self.tableView.rowHeight = kScreenHeight/3;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = NO;
    [self.view addSubview:self.tableView];
    
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _ListArr.count;
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
