//
//  XXMeVC.m
//  SmileBella
//
//  Created by Bella on 16/12/22.
//  Copyright © 2016年 Bella. All rights reserved.
//

#import "XXMeVC.h"
#import <Masonry.h>
#import "XXMeCell.h"
#import "XXMeModel.h"
#import <AFNetworking.h>
#import "UIView+Frame.h"
#import <MJExtension.h>
#import "NSObject+UIBarButtonItem.h"
#import "XXUsCenterVC.h"
#import "XXMeDetaiVC.h"
#import "XXLoginVC.h"
#import "XXMessageVC.h"


static NSString * const ID = @"cell";
static NSInteger const cols = 4;
static CGFloat const margin = 1;
#define itemWH (kScreenWidth - (cols - 1) * margin) / cols

@interface XXMeVC () <UICollectionViewDataSource,UICollectionViewDelegate>
@property (nonatomic, weak) UICollectionView *collectionView;
@property (nonatomic,strong)NSMutableArray *dataArry;

@end

@implementation XXMeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    
    [self setupFootView];
    [self LoadJsonDate];
    [self setUpNavBar];
    
}



//请求数据

-(void)LoadJsonDate{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    NSDictionary *param = @{
                            @"a":@"square",
                            @"c":@"topic"
                            };
    [manager GET:@"http://api.budejie.com/api/api_open.php"
 parameters:param progress:^(NSProgress * _Nonnull downloadProgress) {
 } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
     
     NSArray *dictArr = responseObject[@"square_list"];
     
     // 字典数组转换成模型数组
     _dataArry = [XXMeModel mj_objectArrayWithKeyValuesArray:dictArr];
     
     // 处理数据
     [self resloveData];
     
     
     // 设置tableView滚动范围:自己计算
     self.tableView.tableFooterView = self.collectionView;
     // 刷新表格
     [self.collectionView reloadData];

     
 } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
     
     
 }];
    
    
    
}


#pragma mark - 处理请求完成数据
- (void)resloveData
{
    // 判断下缺几个
    NSInteger count = self.dataArry.count;
    NSInteger exter = count % cols;
    if (exter) {
        exter = cols - exter;
        for (int i = 0; i < exter; i++) {
            XXMeModel *item = [[XXMeModel alloc] init];
            [self.dataArry addObject:item];
        }
    }
    
}

#pragma mark --设置底部视图

-(void)setupFootView{
    //1.初始化设置流水布局
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    // 设置cell尺寸
    layout.itemSize = CGSizeMake(itemWH, itemWH);
    layout.minimumInteritemSpacing = margin;
    layout.minimumLineSpacing = margin;
//    layout.sectionInset = UIEdgeInsetsMake(5, 5, 5, 5);
    
    //创建collectionView
    UICollectionView *collection = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, 0, 900) collectionViewLayout:layout];
    _collectionView = collection;
    collection.backgroundColor = self.tableView.backgroundColor;
//    collection.backgroundColor = xRed;
    self.tableView.tableFooterView = collection;
    
    collection.dataSource = self;
    collection.delegate =self;
    collection.scrollEnabled =NO;
    
    //注册cell
    [collection registerNib:[UINib nibWithNibName:@"XXMeCell" bundle:nil] forCellWithReuseIdentifier:ID];
    
}
#pragma mark - UICollectionView
//选中跳转
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    XXMeModel *model = self.dataArry[indexPath.row];
    if (![model.url containsString:@"http"]) return;
    
    XXMeDetaiVC *deta = [[XXMeDetaiVC alloc]init];
    deta.url = [NSURL URLWithString:model.url];
    NSLog(@"~~~~~~~~~~~%@",model.url);
    [self.navigationController pushViewController:deta animated:YES];
    
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.dataArry.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    // 从缓存池取
    XXMeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    
    cell.model = self.dataArry[indexPath.row];
    
    return cell;
}



#pragma mark --UITableView
//设置每行对应的Cell展示的内容
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identifer = @"cell";
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
    }
    
    if (indexPath.section == 0) {
        UIImageView *header = [[UIImageView alloc]initWithFrame:CGRectMake(10, 3, 35, 35)];
        header.image = [UIImage imageNamed:@"setup"];
        header.layer.cornerRadius = 15;// 裁剪成圆形图片
        header.clipsToBounds = YES;
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(60, 10, 70, 20)];
        label.text = @"登录/注册";
        label.font = [UIFont systemFontOfSize:14];
        
        UIImageView *rightImag = [[UIImageView alloc]initWithFrame:CGRectMake(350, 10, 20, 20)];
        rightImag.image = [UIImage imageNamed:@"accessory_right"];
        
        [cell.contentView addSubview:header];
        [cell.contentView addSubview:label];
        [cell.contentView addSubview:rightImag];
        
    
        
        
    }else if (indexPath.section == 1){
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(20, 10, 70, 20)];
        label.text = @"离线缓存";
        label.font = [UIFont systemFontOfSize:14];
        
        UIImageView *rightImag = [[UIImageView alloc]initWithFrame:CGRectMake(350, 10, 20, 20)];
        rightImag.image = [UIImage imageNamed:@"accessory_right"];
        
        
        [cell.contentView addSubview:label];
        [cell.contentView addSubview:rightImag];
        
    }
    
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        XXLoginVC *login = [[XXLoginVC alloc]init];
       
        [self presentViewController:login animated:YES completion:nil];
    }else{
        
        NSLog(@"indexPath.section == %ld",indexPath.section);
        
    }
    
}

//设置分组
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 2;
}

//设置每个分组下tableView的行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;

}

//设置每个分组上边预留空白的高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}

//设置每个分组下面预留的空白高度
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 5;
}
//设置每个分组下面对应的tableView高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
   
    return 40;
    
}

#pragma mark -- 设置导航条
-(void)setUpNavBar{
    
    //导航条左边按钮
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithimage:[UIImage imageNamed:@"关于我们"] highImage:[UIImage imageNamed:@"关于我们"] target:self action:@selector(go2MyMessageVC)];
    // titleView
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"主标题"]];
    
}

-(void)go2MyMessageVC{
    
    XXMessageVC *message = [XXMessageVC new];
    
    [self.navigationController pushViewController:message animated:YES];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
