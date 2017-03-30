//
//  XXFindViewController.m
//  SmileBella
//
//  Created by Bella on 16/11/29.
//  Copyright © 2016年 Bella. All rights reserved.
//

#import "XXFindVC.h"
#import "XXRecommendVC.h"
#import "NSObject+UIBarButtonItem.h"
//#import "UIView+frame.h"
#import "XXFindCollectionCell.h"
#import <AFNetworking.h>
#import "XXFindModel.h"
#import <UIImageView+WebCache.h>
#import <MJRefresh.h>
#import "XXGIfRfresh.h"
#import <SVProgressHUD.h>
#import "XXPopularVC.h"
#import "XXDiscoverDetailVC.h"
#import "XXProjectVC.h"



@interface XXFindVC ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic, strong)NSMutableArray *ListArr;
@property (nonatomic, strong)UICollectionView  *collectionView;
@property (nonatomic, strong)NSIndexPath *currentIndexPath;

@end

@implementation XXFindVC


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self setUpNavBar];
  
    //流水布局:调整cell尺寸
    UICollectionViewFlowLayout *layout = [self setupCollectionViewFlowLayout];
    
    
    [self setupCollectionView:layout];
    
    [self setupRefresh];
    
}

//刷新控件
- (void)setupRefresh
{
    self.collectionView.mj_header = [XXGIfRfresh headerWithRefreshingTarget:self refreshingAction:@selector(getJsonDate)];
    
    [self.collectionView.mj_header beginRefreshing];
    
    
//    // footer
//    self.tableView.mj_footer = [XXGIfFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreTopics)];
//    
    
}//


/** 获取数据 */
-(void)getJsonDate{
    _ListArr = [[NSMutableArray alloc]init];
    
    //正方形的背景样式(或颜色),黑色背景,白色圆环和文字
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [SVProgressHUD showWithStatus:@"正在加载"];
    NSString *url = @"http://baobab.wandoujia.com/api/v3/discovery";
   
     AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [manager GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject){
        
        NSDictionary *itemList = [responseObject objectForKey:@"itemList"];
        for (NSDictionary *dict in itemList) {
            NSString *type = [dict objectForKey:@"type"];
            if ([type isEqualToString:@"squareCard"]) {
                
                NSDictionary *dataDic = dict[@"data"];
                NSMutableArray *arr = [[NSMutableArray alloc]init];
                [arr addObject:dataDic];
                
                for (NSDictionary *Dic in arr) {
                    
                    XXFindModel *model = [[XXFindModel alloc]init];
                    model.image = [NSString stringWithFormat:@"%@",Dic[@"image"]];
                    model.actionUrl = [NSString stringWithFormat:@"%@",Dic[@"actionUrl"]];
                    model.title = [NSString stringWithFormat:@"%@",Dic[@"title"]];
                    model.IdStr = [NSString stringWithFormat:@"%@",Dic[@"id"]];
                    [_ListArr addObject:model];
                    
                }
            }
            
        }
//        NSLog(@"%@",responseObject);
        [self.collectionView reloadData];
        [SVProgressHUD dismiss];
        // 结束刷新
        [self.collectionView.mj_header endRefreshing];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (error.code != NSURLErrorCancelled) { // 并非是取消任务导致的error，其他网络问题导致的error
            [SVProgressHUD showErrorWithStatus:@"网络繁忙，请稍后再试！"];
            
        }
        [SVProgressHUD dismiss];
        // 结束刷新
        [self.collectionView.mj_header endRefreshing];
    }];

    
    
}



#pragma mark -- 创建流水布局
-(UICollectionViewFlowLayout *)setupCollectionViewFlowLayout{
    
    
    //创建一个layout布局类
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    CGFloat width = (kScreenWidth - 9)/2;
    //定义大小
    layout.itemSize = CGSizeMake(width, width);

    layout.sectionInset = UIEdgeInsetsMake(3, 3, 3, 3);
    
    //设置滚动方向(默认垂直滚动)
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    //水平布局
//    UICollectionViewScrollDirectionHorizontal  系统会在一行充满后进行第二行的排列，如果设置为水平布局，则会在一列充满后，进行第二列的布局，这种方式也被称为流式布局
    
    //设置最小行间距
    layout.minimumLineSpacing = 3;
    //设置最小列间距
    layout.minimumInteritemSpacing = 1.5;
    
    /*
    // 开启分页
    self.collectionView.pagingEnabled = YES;
    // 隐藏水平滚动条
    self.collectionView.showsHorizontalScrollIndicator = NO;
    // 取消弹簧效果
    self.collectionView.bounces = NO;
    */
    
    return layout;
    
}


#pragma mark -- 创建CollectionView
-(void)setupCollectionView:(UICollectionViewFlowLayout *)layout{

    //创建
    UICollectionView *collection = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
    collection.backgroundColor = [UIColor whiteColor];
    
    collection.center = self.view.center;
    collection.bounds = self.view.bounds;
    
    //加入到view上
    [self.view addSubview:collection];
    
    //代理
    collection.delegate = self;
    collection.dataSource = self;
    
    [collection registerClass:[XXFindCollectionCell class] forCellWithReuseIdentifier:@"cell"];
    
    self.collectionView = collection;
    
    
}


#pragma mark - UICollectionViewDelegate, UICollectionViewDataSource

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 1;
    
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    

    return _ListArr.count;
}



/** 返回cell */
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    XXFindCollectionCell *cell = (XXFindCollectionCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    XXFindModel *model = _ListArr[indexPath.row];
    [cell.ImageView sd_setImageWithURL:[NSURL URLWithString:model.image]];
    cell.titleLabel.text = model.title;
    return cell;
    
}




/** 点击cell跳转  */
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        
        XXPopularVC *popular = [[XXPopularVC alloc]init];
        popular.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:popular animated:YES];
        
    }else if (indexPath.row == 1){
        
        XXProjectVC *project = [[XXProjectVC alloc]init];
        project.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:project animated:YES];
        
    }else{
        
        XXDiscoverDetailVC *dis = [[XXDiscoverDetailVC alloc]init];
        XXFindModel *model = _ListArr[indexPath.row];
        dis.actionUrl = model.actionUrl;
        dis.pageTitle = model.title;
        dis.idStr = model.IdStr;
        dis.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:dis animated:YES];
    }
    
    
}



#pragma mark -- 设置导航条
-(void)setUpNavBar{
    
    //导航条左边按钮
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithimage:[UIImage imageNamed:@"MainTagSubIcon"] highImage:[UIImage imageNamed:@"MainTagSubIconClick"] target:self action:@selector(go2RecommendTags)];
    // titleView
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"主标题"]];
    
}

//进入推荐
-(void)go2RecommendTags{
    XXRecommendVC *recommTag = [XXRecommendVC new];
    [self.navigationController pushViewController:recommTag animated:YES];
}



@end


