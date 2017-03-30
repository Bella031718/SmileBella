//
//  XXCircleVC.m
//  SmileBella
//
//  Created by Bella on 17/2/20.
//  Copyright © 2017年 Bella. All rights reserved.
//

#import "XXCircleVC.h"

#import "XXHomeCycleView.h"
#import "XXCircleCell.h"
#import "NSString+XXTimes.h"
#import "XXNetworkTool.h"
#import "XXTopModel.h"
#import <MJExtension.h>
#import <SDCycleScrollView.h>
#import "XXMenueHeader.h"



@interface XXCircleVC ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,XXHomeCycleViewDelegate>


//collection
@property (nonatomic, strong)UICollectionView *collection;

@property (nonatomic, strong)XXHomeCycleView *headerView;


@end



@implementation XXCircleVC


- (void)viewDidLoad {
    [super viewDidLoad];
    // titleView
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"主标题"]];
    
    //广告栏
    self.headerView = [[XXHomeCycleView alloc]init];//WithFrame:CGRectMake(0, 0, kScreenWidth, 200*KWidth_Scale+35)];//200*KWidth_Scale
    _headerView.backgroundColor = xOrange;
//    [self getTopBannerArr];
    
    
    [self initCollectionView];
    
}


-(void)initCollectionView{
    
    //必须要有创建一个UICollectionViewFlowLayout的对象
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
//    同一行相邻两个Cell的最小间距
    layout.minimumLineSpacing = 0;
    //垂直间距
    layout.minimumInteritemSpacing = 0;
    //设置Cell大小
    layout.itemSize = CGSizeMake((kScreenWidth-40)/2, 120);
//    //上下左右间距
    layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    
    //创建collection
    self.collection = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight-64-Tabbar_H) collectionViewLayout:layout];
    NSLog(@"我是导航栏高度--%f",Navigation_H);
    NSLog(@"我是Tabbar高度--%f",Tabbar_H);
    
    
    //遵循代理
    self.collection.delegate = self;
    self.collection.dataSource = self;
    //背景颜色
    self.collection.backgroundColor = [UIColor lightGrayColor];
    //设置滚动条
//    self.collection.showsVerticalScrollIndicator = NO;
//    //    self.collection.showsHorizontalScrollIndicator = NO;
    
    //自适应大小
    self.collection.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    
    //自动滚动调整,默认为yes
    self.automaticallyAdjustsScrollViewInsets = NO;

    //注册头部cell
    [self.collection registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"ReusableView"];
    
    //头部cell
    [self.collection registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"cellHeader"];
    
    //    //注册cell
        [self.collection registerClass:[XXCircleCell class] forCellWithReuseIdentifier:@"cell"];
    
    [self.view addSubview:self.collection];

    
}




#pragma mark -- CollectionDelegate

/** 返回header轮播图尺寸 */
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        //轮播加头部
        return CGSizeMake(kScreenWidth, 200*KWidth_Scale+33);
    }else{
        return CGSizeMake(kScreenWidth, 40);
    }
    
  
}


/** 一共有多少组 */
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 1;
}

/** 每一组有多少个cell */
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    //强制转换格式
    return 4;
}

//定义每一个cell的大小
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    return CGSizeMake(220, 120);
//}


/** 每一个cell是什么 */
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{

    static NSString *identify = @"cell";
//    XXCollectionCell *cell =[collectionView dequeueReusableCellWithReuseIdentifier:identify forIndexPath:indexPath];
    XXCircleCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identify forIndexPath:indexPath];
//    [cell sizeToFit];
////    cell.imgView.image = [UIImage imageNamed:@""];
////    cell.text.text = @"这么难嘛!";
//    cell.liveImage.image = [UIImage imageNamed:@"Img_default"];
//    cell.liveImage.backgroundColor = xRed;
//    cell.introduceLable.text = @"恭喜你发财";
//    cell.SexIcon.image = [UIImage imageNamed:@"mainCellCaiClick"];
//    cell.nameLabel.text = @"请叫我可翠花";
//    cell.personNum.text = @"12312";
    
    return cell;
    
}

/** 头部显示的内容 */

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    
#warning 我先把这个展示两个的先注释
   /*
    UICollectionReusableView *headerView = nil;
    if (kind == UICollectionElementKindSectionHeader){
    if (indexPath.section == 0) {
//
//
    self.headerView  = [collectionView dequeueReusableSupplementaryViewOfKind:
                                            UICollectionElementKindSectionHeader withReuseIdentifier:@"ReusableView" forIndexPath:indexPath];
    
        headerView = self.headerView;

    }else{
#warning 这个是小组头
    
        XXMenueHeader *cellHeader = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"cellHeader" forIndexPath:indexPath];
        headerView = cellHeader;
        }
        
    }
    return headerView;
    */
#warning 这里是展示一组的
    
    
    
    UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:
                                            UICollectionElementKindSectionHeader withReuseIdentifier:@"ReusableView" forIndexPath:indexPath];
    [headerView addSubview:_headerView];
    
    return headerView;
    
}



/** cell的点击事件 */
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
}


/** 轮播点击事件 */
-(void)homeCycleView:(XXHomeCycleView *)homeCycleView roomId:(NSString *)roomId{
    
    
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
