//
//  XXHeaderVC.m
//  SmileBella
//
//  Created by Bella on 16/12/8.
//  Copyright © 2016年 Bella. All rights reserved.
//

#import "XXHeaderVC.h"
#import <Masonry.h>

@interface XXHeaderVC ()<UITableViewDataSource,UITableViewDelegate,UIPickerViewDataSource,UIPickerViewDelegate>
{
    UITableView *_tableView;
    NSArray *_dataArray;
    UIPickerView *_pickerView;
}

@property (nonatomic,strong)NSArray * letter;//保存要展示的字母



@end

@implementation XXHeaderVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor =[UIColor grayColor];
    self.title = @"用户信息";
    [self.view addSubview:_pickerView];
    
    [self initTableView];
}

#pragma mark -- 初始化tableView
-(void)initTableView{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0,kScreenWidth , kScreenHeight/2+20) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.bounces = NO;
//    _tableView.tableFooterView = [UIView new];
    _dataArray = @[@"头像",@"用户名",@"性别",@"个性签名"];
    
    [self.view addSubview:_tableView];
    
    
}

#pragma mark -- 初始化pickView
-(void)initPickerView{

    _pickerView = [[UIPickerView alloc]init];
    _pickerView.backgroundColor = [UIColor redColor];
        _pickerView.delegate = self;
        _pickerView.dataSource = self;
    [self.view addSubview:_pickerView];
    
    [_pickerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view.mas_bottom).offset(-50);
        make.size.mas_offset(CGSizeMake(kScreenWidth, kScreenHeight/2-60));
    }];

}
#pragma mark 加载数据
-(void)loadData{
    //需要展示的数据以数组的形式保存
    self.letter = @[@"男",@"女"];
}

#pragma mark UIPickerView DataSource Method 数据源方法

//指定pickerview有几个表盘
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;//第一个展示字母、第二个展示数字
}

//指定每个表盘上有几行数据
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    NSInteger result = 0;
    switch (component) {
        case 0:
            result = self.letter.count;//根据数组的元素个数返回几行数据
            break;
        default:
            break;
    }
    return result;
}

#pragma mark UIPickerView Delegate Method 代理方法

//指定每行如何展示数据（此处和tableview类似）
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    NSString * title = nil;
    switch (component) {
        case 0:
            title = self.letter[row];
            break;
        default:
            break;
    }
    return title;
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
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        
        return 100;
    
    }else if(indexPath.row == 1 || indexPath.row == 2){
        
        return 50;
    
    }else{
       
        return 70;
    }
}

//设置每行对应的Cell展示的内容
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifer = @"cell";
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
        }
    cell.textLabel.text = [_dataArray objectAtIndex:indexPath.row];
    if (indexPath.row == 0) {
        UIImageView *headImg = [[UIImageView alloc]init];
        headImg.backgroundColor = [UIColor grayColor];
        headImg.layer.cornerRadius = 38;// 裁剪成圆形图片
        headImg.clipsToBounds = YES;


        [cell.contentView addSubview:headImg];
        
        [headImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.offset(10);
            make.right.offset(-10);
            make.size.mas_offset(CGSizeMake(75, 75));

        }];
        
        
    }else if(indexPath.row == 1){
        UILabel *userName = [UILabel new];
        userName.text = @"bella";
        userName.font = [UIFont systemFontOfSize:15];
        userName.textAlignment = NSTextAlignmentRight;
        [cell.contentView addSubview:userName];
        
        [userName mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.offset(-30);
            make.size.mas_offset(CGSizeMake(35, 35));
        }];
    }else if(indexPath.row == 2){
        UIButton *sexBtn = [UIButton new];
        [sexBtn setImage:[UIImage imageNamed:@"pulllist"] forState:UIControlStateNormal];
        [sexBtn setImage:[UIImage imageNamed:@"pulllist"] forState:UIControlStateHighlighted];
        [sexBtn addTarget:self action:@selector(go2DataPicker) forControlEvents:UIControlEventTouchUpInside];
        [cell.contentView addSubview:sexBtn];
        
        [sexBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.offset(-15);
            make.size.mas_offset(CGSizeMake(45, 45));
        }];
 
    }
    return cell;
}

//点击cell跳转
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];// 取消选中
    

}




-(void)go2DataPicker{
    NSLog(@"弹出视图");
    [self loadData];
    [self initPickerView];
  
    
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
