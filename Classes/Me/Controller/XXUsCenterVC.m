//
//  XXUsVC.m
//  SmileBaby
//
//  Created by Bella on 16/7/21.
//  Copyright © 2016年 Bella. All rights reserved.
//

#import "XXUsCenterVC.h"
#import <Masonry.h>
#import "UIButton+Extension.h"
#import "XXHeaderVC.h"
#import "XXMyStudyVC.h"
#import "XXMyCacheVC.h"
#import "XXAnswerVC.h"
#import "XXMyCollectionVC.h"
#import "XXMySettingVC.h"


@interface XXUsCenterVC ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_tableView;
    NSArray *_dataArray;
    
}
@property (nonatomic,strong)NSMutableArray *imageArr;
@property (nonatomic,strong)UIImageView *leftImag;
@property (nonatomic,strong)UIImageView *rightImag;
@property (nonatomic,copy)NSString *imageName;
@end

@implementation XXUsCenterVC

//懒加载
-(NSMutableArray *)imageArr{
    if (!_imageArr) {
        _imageArr = [@[@"关于我们",@"关于我们",@"关于我们",@"关于我们",@"关于我们"]mutableCopy];

    }
    return _imageArr;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self initTableView];
}



//初始化tableView
-(void)initTableView{
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.bounces = NO;
    //不显示右侧滑块
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;//分割线
    //    _tableView.backgroundColor = [UIColor redColor];
    
    _dataArray = @[@"我的学习",@"我的缓存",@"我的问答",@"我的收藏"];
    
    
    [self.view addSubview:_tableView];
  
}
#pragma mark - 设置tableView分界线的宽度
- (void)viewDidLayoutSubviews
{
    if ([_tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [_tableView setSeparatorInset:UIEdgeInsetsMake(10, 10, 10, 10)];
    }
    if ([_tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [_tableView setLayoutMargins:UIEdgeInsetsMake(10, 10, 10, 10)];
    }
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsMake(10, 10, 10, 10)];
    }
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsMake(10, 10, 10, 10)];
    }
}


//设置分组
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 3;
}

//设置每个分组下tableView的行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 0) {
        return 1;
    }else if (section == 1){
        return _dataArray.count;
    }else{
        return 1;
    }
    
}

//设置每个分组上边预留空白的高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 20;
}

//设置每个分组下面预留的空白高度
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 2) {
        return 35;
    }
    return 20;
}
//设置每个分组下面对应的tableView高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0 ) {
        return 80 ;
    }
    return 40;
    
}

//设置每行对应的Cell展示的内容
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //去除tableView点击阴影
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    static NSString *identifer = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
    if (cell == nil) {
        cell =[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
    }

    if (indexPath.section == 0) {
        cell =[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@""];
        UIImageView *ImageView = [[UIImageView alloc]initWithFrame:CGRectMake(12, 0, 80, 80)];
        ImageView.backgroundColor = [UIColor grayColor];   //[UIImage imageNamed:@"图层-1"];
        [cell.contentView addSubview:ImageView];
        
        UILabel *nikeName = [[UILabel alloc]initWithFrame:CGRectMake(100, 0, 60, 80)];
        nikeName.text = @"小仙女";
        
        UILabel *userName = [[UILabel alloc]initWithFrame:CGRectMake(100, 20, 60, 80)];
        userName.text = @"VIP用户";
        userName.font = [UIFont systemFontOfSize:14];
        
        [cell.contentView addSubview:nikeName];
        [cell.contentView addSubview:userName];

    }else if (indexPath.section == 1){
        cell.textLabel.text = [_dataArray objectAtIndex:indexPath.row];
        cell.imageView.image=[UIImage imageNamed:self.imageArr[indexPath.row]];
    }else{
        cell.textLabel.text = @"我的设置";
        cell.textLabel.textAlignment = NSTextAlignmentLeft;
        cell.imageView.image=[UIImage imageNamed:self.imageArr[indexPath.row]];
    }
    self.rightImag = [UIImageView new];
    self.rightImag.image = [UIImage imageNamed:@"accessory_right"];
    
    self.leftImag = [UIImageView new];
   
   
    
    [cell.contentView addSubview:self.rightImag];
    [cell.contentView addSubview:self.leftImag];
   
    [self.rightImag mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.offset(0);
        make.right.offset(-10);
    }];
    [self.leftImag mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.offset(0);
        make.left.offset(10);
        make.size.mas_offset(CGSizeMake(20, 20));
    }];
    
    return cell;
}

//获取图片
-(void)setImageName:(NSString *)imageName{
    _imageName = imageName;
    self.leftImag.image = [UIImage imageNamed:self.imageName];
    
}

//点击cell跳转
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0) {
        XXHeaderVC *header = [XXHeaderVC new];
        [self.navigationController pushViewController:header animated:YES];
    }else if(indexPath.section == 1){
        switch (indexPath.row) {
        case 0:{
            XXMyStudyVC *study = [XXMyStudyVC new];
            [self.navigationController pushViewController:study animated:YES];
            NSLog(@"%ld",indexPath.row);
        }
            break;
        case 1:{
            XXMyCacheVC *cache = [XXMyCacheVC new];
            [self.navigationController pushViewController:cache animated:YES];
            NSLog(@"%ld",indexPath.row);
        }
            break;
        case 2:{
            XXAnswerVC *answer = [XXAnswerVC new];
            [self.navigationController pushViewController:answer animated:YES];
            NSLog(@"%ld",indexPath.row);

        }
            break;
        case 3:{
            XXMyCollectionVC *collection = [XXMyCollectionVC new];
            [self.navigationController pushViewController:collection animated:YES];
            NSLog(@"%ld",indexPath.row);
                    }
            break;
        default:
            break;
    }
    }else{
        XXMySettingVC *setting = [XXMySettingVC new];
        [self.navigationController pushViewController:setting animated:YES];
        NSLog(@"%ld",indexPath.section);

    }
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
