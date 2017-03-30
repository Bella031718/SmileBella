//
//  XXTabBarController.m
//  SmileBaby
//
//  Created by Bella on 16/7/21.
//  Copyright © 2016年 Bella. All rights reserved.
//

#import "XXTabBarController.h"
#import "XXHomeVC.h"
#import "XXFindVC.h"
#import "XXCircleVC.h"
#import "XXMeVC.h"
#import "XXNavigationController.h"
#import "PrefixHeader.pch"
#import "XXAddVC.h"
#import "XXTabBar.h"
#import "XXCircleViewContro.h"



@interface XXTabBarController ()

@end

@implementation XXTabBarController



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //设置背景View
    UIView *backgroundView = [[UIView alloc]initWithFrame:self.tabBar.bounds];
    //插入背景
    [self.tabBar insertSubview:backgroundView atIndex:0];
    
    //初始化子控制器(切勿切勿只知道抄代码 不看代码!!!)
    XXHomeVC *homeVC = [[XXHomeVC alloc]init];
    [self addChildVc:homeVC title:@"动态" image:@"shouye-拷贝" selectedImage:@"shouye-拷贝"];

    XXFindVC *findVC = [[XXFindVC alloc]init];
    [self addChildVc:findVC title:@"发现" image:@"Compass" selectedImage:@"Compass_click"];
   
//    XXAddVC *addVC = [[XXAddVC alloc]init];
//    [self addChildVc:addVC title:nil image:@"tabBar_publish_click_icon" selectedImage:@"tabBar_publish_click_icon"];
//    addVC.tabBarItem.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0);
    
    
    XXCircleVC *circleVC = [[XXCircleVC alloc]init];
    [self addChildVc:circleVC title:@"圈子" image:@"women" selectedImage:@"women"];
//    XXCircleViewContro *circle = [[XXCircleViewContro alloc]init];
//    [self addChildVc:circle title:@"圈子" image:@"women" selectedImage:@"women"];
    
    
    XXMeVC *me = [[XXMeVC alloc]init];
    [self addChildVc:me title:@"我" image:@"User-Profile" selectedImage:@"User-Profile_click"];
    //中间+号tabbar
//    XXCircleVC *collection = [[XXCircleVC alloc]init];
//    [self addChildVc:collection title:@"我" image:@"User-Compass" selectedImage:@"Compass"];
    
    [self setupBar];
}

#pragma  mark --自定义tabbar
-(void)setupBar{
    
    XXTabBar *tabBar = [[XXTabBar alloc] init];
    [self setValue:tabBar forKey:@"tabBar"];
    
}


+ (void)initialize
{
    UITabBarItem *tabItem = [UITabBarItem appearance];
    // 普通状态下的字体颜色
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSForegroundColorAttributeName] = kBLColor(116, 117, 128);
    [tabItem setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    
    NSMutableDictionary *selecTextAttrs = [NSMutableDictionary dictionary];
    selecTextAttrs[NSForegroundColorAttributeName] = xBRed;
    [tabItem setTitleTextAttributes:selecTextAttrs forState:UIControlStateSelected];
}


- (void)addChildVc:(UIViewController *)childVc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage
{
    //设置子控制器的图片
    childVc.tabBarItem.image = [UIImage imageNamed:image];
    //自定义选择图片  设置图片的渲染模式:imageWithRenderingMode
    childVc.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    //设置子控制器的文字标题
    childVc.title = title;
 
    // 先给外面传进来的小控制器包装一个导航控制器
    XXNavigationController *nav = [[XXNavigationController alloc] initWithRootViewController:childVc];
    
    //    [nav setEnableBackGesture:YES]; // 开启手势
    // 添加子控制器
    [self addChildViewController:nav];
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
