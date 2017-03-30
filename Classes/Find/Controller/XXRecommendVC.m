//
//  XXRecommendVC.m
//  SmileBella
//
//  Created by Bella on 16/12/19.
//  Copyright © 2016年 Bella. All rights reserved.
//

#import "XXRecommendVC.h"
#import <AFNetworking.h>
#import "XXRemmoendModel.h"
#import "XXRecommmendCell.h"
#import <MJExtension.h>


@interface XXRecommendVC ()

@property(nonatomic,strong) NSArray *subTags;
@property(nonatomic,weak)AFHTTPSessionManager *manager;


@end

@implementation XXRecommendVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"推荐标签";
   //初始化注册cell 加载cell展示数据
    [self.tableView registerClass:[XXRecommmendCell class] forCellReuseIdentifier:NSStringFromClass([XXRecommmendCell class])];
    
    [self loadJSonData];
}


#pragma mark --加载数据
-(void)loadJSonData{
    //创建请求会话者
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    self.manager = manager;
    NSDictionary *param = [NSMutableDictionary dictionary];
    param = @{
              @"a":@"tag_recommend",
              @"action":@"sub",
              @"c":@"topic",
              };
    
    [manager GET:@"http://api.budejie.com/api/api_open.php" parameters:param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        _subTags = [XXRemmoendModel mj_objectArrayWithKeyValuesArray:responseObject];
        
        NSLog(@"----------%@",responseObject);
        
        [self.tableView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"***********%@",error);
        
    }];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.subTags.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
     //自定义cell
    Class currentClass = [XXRecommmendCell class];
    XXRecommmendCell *cell =[tableView dequeueReusableCellWithIdentifier:NSStringFromClass(currentClass)];
    //获取模型 展示数据
    XXRemmoendModel *model = self.subTags[indexPath.row];
    cell.model =model;
    
    NSLog(@"%@",model);
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
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
