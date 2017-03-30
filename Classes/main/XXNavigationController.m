//
//  XXNavigationController.m
//  SmileBaby
//
//  Created by Bella on 16/7/21.
//  Copyright © 2016年 Bella. All rights reserved.
//

#import "XXNavigationController.h"
#import "PrefixHeader.pch"
#import "UIBarButtonItem+Extension.h"

@interface XXNavigationController ()<UIGestureRecognizerDelegate>

@end

@implementation XXNavigationController


+ (void)initialize
{
    UINavigationBar *bar = [UINavigationBar appearance];
    // 设置背景图片
    //    UIImage *top_nav = [UIImage imageNamed:@"top_navigation_background_88"];// 图片高度为88
    //    UIImage *top_nav = [UIImage hyb_imageWithColor:kBLRed toSize:CGSizeMake(1, 64)]; // 把颜色生成的图片，如果高度不等于44则会填充
    //    [bar setBackgroundImage:top_nav forBarMetrics:UIBarMetricsDefault];
    bar.barTintColor = xRed;
    
    // 设置项目所有item的主题样式
    UIBarButtonItem *item = [UIBarButtonItem appearance];
    
    // 设置普通状态
    // key:NS****AttributeName
    NSDictionary *textAttrs = @{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont systemFontOfSize:19]};
    [item setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    //     设置不可用状态
    NSDictionary *disableTextAttrs = @{NSForegroundColorAttributeName:[UIColor grayColor],NSFontAttributeName:[UIFont systemFontOfSize:19]};
    [item setTitleTextAttributes:disableTextAttrs forState:UIControlStateDisabled];
    
    
}

//+ (void)load
//{
//    UINavigationBar *navBar = [UINavigationBar appearanceWhenContainedIn:self, nil];
//    
//    // 只要是通过模型设置,都是通过富文本设置
//    // 设置导航条标题 => UINavigationBar
//    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
//    attrs[NSFontAttributeName] = [UIFont boldSystemFontOfSize:20];
//    [navBar setTitleTextAttributes:attrs];
//    
//    // 设置导航条背景
//    navBar.backgroundColor =xRed;
////    [navBar setBackgroundImage:[UIImage imageNamed:@"标签栏"] forBarMetrics:UIBarMetricsDefault];


/**
 实现该方法能够改变状态栏
 */
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}
/**
 重写这个方法的目的：能够拦截所有push进来的控制器
 */
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.viewControllers.count > 0) {
        // 这时push进来的控制器viewController，不是根控制器
        // 自动隐藏tabbar
        viewController.hidesBottomBarWhenPushed = YES;
        //        [[UINavigationBar appearance] setBarTintColor:[UIColor grayColor]];
        
        // 设置导航栏上面的内容
        // 设置左上角的返回按钮     
        viewController.navigationItem.leftBarButtonItem =[UIBarButtonItem itemWithTarget:self action:@selector(back) image:@"返回" highImage:@"返回"];
    }
    // 重写父类的push方法
    [super pushViewController:viewController animated:animated];
}
/**
 导航栏左上角返回按钮
 */
- (void)back
{
    [self popViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
