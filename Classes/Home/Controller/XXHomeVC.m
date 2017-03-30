//
//  XXHomeVC.m
//  SmileBaby
//
//  Created by Bella on 16/7/21.
//  Copyright © 2016年 Bella. All rights reserved.
//

#import "XXHomeVC.h"
#import <MJRefresh.h>
#import <Masonry.h>
#import <MJExtension.h>
#import "NSObject+UIBarButtonItem.h"
#import "UIView+frame.h"
#import "XXTitleButton.h"

#import "XXVideoVC.h"
#import "XXPictureVC.h"
#import "XXJokeVC.h"

#import "XXScanningVc.h"
#import "SGAlertView.h"
#import "SGQRCodeTool.h"
#import "SGScanningQRCodeView.h"
#import <AVFoundation/AVFoundation.h>

#import <Photos/Photos.h>


@interface XXHomeVC ()<UIScrollViewDelegate>

@property (nonatomic,weak)UIScrollView *scrollView;

@property (nonatomic,weak)UIView *titleView;

@property (nonatomic,weak)UIView *underline;

/** 上一次点击的标题按钮 */
@property (nonatomic, weak) XXTitleButton *lastTitleBtn;



@end

@implementation XXHomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"主标题"]];
    //导航条左边按钮
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithimage:[UIImage imageNamed:@"扫一扫"] highImage:[UIImage imageNamed:@"扫一扫"] target:self action:@selector(go2ScanningVc)];
    
    [self initChildControllView];
    //scrollView
    [self setupScrollView];
    
    [self setupTitleView];
    
    // 添加第0个子控制器的view
    [self addChildViewControllerIntoScr:0];
}



/**
 初始化控制器
 */
-(void)initChildControllView{
    
    [self addChildViewController:[XXVideoVC new]];
    [self addChildViewController:[XXPictureVC new]];
    [self addChildViewController:[XXJokeVC new]];
}



/**
 创建ScrollView
 */
-(void)setupScrollView{
    //不允许自动修改UIscrollView的内边距
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    UIScrollView *scrollView = [UIScrollView new];
    scrollView.backgroundColor = self.view.backgroundColor;
    scrollView.frame = self.view.bounds;
    scrollView.delegate = self;
    scrollView.showsHorizontalScrollIndicator = NO;//是否显示水平滚动条
    scrollView.showsVerticalScrollIndicator = NO;//是否显示垂直滚动条
    scrollView.pagingEnabled = YES;
    scrollView.scrollsToTop = NO; //点击状态栏的时候,这个ScView不会滚动到最顶部
    
    [self.view addSubview:scrollView];
    self.scrollView = scrollView;
    
    // 添加子控制器的view
    NSUInteger count = self.childViewControllers.count;
    CGFloat scrollViewW = scrollView.xx_width;
    scrollView.contentSize = CGSizeMake(count * scrollViewW, 0);
}


/**
 标题栏
 */
-(void)setupTitleView{
    
    UIView *titleView = [[UIView alloc]init];
    //设置背景色  并设置透明度
    titleView.backgroundColor = [UIColor whiteColor];
    titleView.frame = CGRectMake(0, 64, self.view.xx_width, 35);
    [self.view addSubview: titleView];
    self.titleView = titleView;
    
    [self setupTitleButtons];
    
    [self setupUnderline];
}
    
/**
 标题栏按钮
 */

- (void)setupTitleButtons
{
    //文字
    NSArray *title = @[@"视频",@"图片",@"段子"];
    NSUInteger count = title.count;
    
    //标题按钮的尺寸
    CGFloat titleBtnW = self.titleView.xx_width/count;
    CGFloat titltBtnH = self.titleView.xx_height;
    
    //创建5个标题按钮
    for (NSUInteger i = 0; i < count ; i++) {
        XXTitleButton *titleBtn = [[XXTitleButton alloc]init];
        titleBtn.tag = i;
        [titleBtn addTarget:self action:@selector(titleViewBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.titleView addSubview:titleBtn];
        //frame
        titleBtn.frame = CGRectMake(i * titleBtnW, 0, titleBtnW, titltBtnH);
        
        //btn文字
        [titleBtn setTitle:title[i] forState:UIControlStateNormal];
        NSLog(@"++++++++++++++%@",title[i]);
        
    }
    
}

-(void)setupUnderline{
    
    // 标题按钮
    XXTitleButton *firstTitleButton = self.titleView.subviews.firstObject;
    
    // 下划线

    UIView *titleUnderline = [[UIView alloc] init];
    titleUnderline.xx_height = 2;
    
    titleUnderline.xx_y = self.titleView.xx_height - titleUnderline.xx_height;

    
    titleUnderline.backgroundColor = [firstTitleButton titleColorForState:UIControlStateSelected];
    [self.titleView addSubview:titleUnderline];
    self.underline = titleUnderline;
    
    // 切换按钮状态
    firstTitleButton.selected = YES;
    self.lastTitleBtn = firstTitleButton;
    
    [firstTitleButton.titleLabel sizeToFit]; // 让label根据文字内容计算尺寸
    
    //尺寸
    self.underline.xx_width = firstTitleButton.titleLabel.xx_width + 10;
    self.underline.xx_centerX = firstTitleButton.xx_centerX;
    
    NSLog(@"%f",firstTitleButton.titleLabel.xx_width);
}

/**
 标题点击事件
 */
-(void)titleViewBtnClick:(XXTitleButton *)titleBtn{
    
    //重复点击标题按钮
    if (self.lastTitleBtn == titleBtn) {
        
        //发送通知
        [[NSNotificationCenter defaultCenter] postNotificationName:@"ClickNotification" object:nil];
    }
    
    // 处理标题按钮点击
    [self dealTitleButtonClick:titleBtn];
}


/**
 *  处理标题按钮点击
 */
- (void)dealTitleButtonClick:(XXTitleButton *)titleButton{
        // 切换按钮状态
        self.lastTitleBtn.selected = NO;
        titleButton.selected = YES;
        self.lastTitleBtn = titleButton;
        
        NSUInteger index = titleButton.tag;
        [UIView animateWithDuration:0.25 animations:^{
            // 处理下划线
            self.underline.xx_width = titleButton.titleLabel.xx_width + 10;
            self.underline.xx_centerX = titleButton.xx_centerX;
            
            // 滚动scrollView
            CGFloat offsetX = self.scrollView.xx_width * index;
            self.scrollView.contentOffset = CGPointMake(offsetX, self.scrollView.contentOffset.y);
        } completion:^(BOOL finished) {
            // 添加子控制器的view
            [self addChildViewControllerIntoScr:index];
        }];
        
        // 设置index位置对应的tableView.scrollsToTop = YES， 其他都设置为NO
        for (NSUInteger i = 0; i < self.childViewControllers.count; i++) {
            UIViewController *childVc = self.childViewControllers[i];
            // 如果view还没有被创建，就不用去处理
            if (!childVc.isViewLoaded) continue;
            
            UIScrollView *scrollView = (UIScrollView *)childVc.view;
            if (![scrollView isKindOfClass:[UIScrollView class]]) continue;
            
            scrollView.scrollsToTop = (i == index);
        }

}

#pragma mark -- ScrollView

/**
 当用户松开View并滑动结束时调用这个代理方法

 @param scrollView 停止滚动的时候
 */
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    //求出标题按钮的索引
    NSUInteger index = scrollView.contentOffset.x / scrollView.xx_width;
    
    //点击对应的标题按钮跳转
    XXTitleButton *titlebtn = self.titleView.subviews[index];
    
    [self dealTitleButtonClick:titlebtn];
    
}

/**
 *  添加第index个子控制器的view到scrollView中
 */
-(void)addChildViewControllerIntoScr:(NSUInteger)index{
    UIViewController *childVC  = self.childViewControllers[index];
    
    //如果view被加载,直接返回
    if (childVC.isViewLoaded) return;
    
    //取出index位置对应的子控制器
    UIView *childView = childVC.view;
    
    //设置子控制器view的frame
    CGFloat scrollView = self.scrollView.xx_width;
    childView.frame = CGRectMake(index *scrollView, 0, scrollView, self.scrollView.xx_height);
    //添加子控制器的view到scrollview中
   [self.scrollView addSubview:childView];
}


#pragma mark -- 跳转扫一扫界面
-(void)go2ScanningVc{

    // 1、 获取摄像设备
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    if (device) {
        // 判断授权状态
        PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
        if (status == PHAuthorizationStatusRestricted) { // 因为家长控制, 导致应用无法方法相册(跟用户的选择没有关系)
            NSLog(@"因为系统原因, 无法访问相册");
        } else if (status == PHAuthorizationStatusDenied) { // 用户拒绝当前应用访问相册
            SGAlertView *alertView = [SGAlertView alertViewWithTitle:@"⚠️ 警告" delegate:nil contentTitle:@"请去-> [设置 - 隐私 - 照片 - SGQRCodeExample] 打开访问开关" alertViewBottomViewType:(SGAlertViewBottomViewTypeOne)];
            [alertView show];
        } else if (status == PHAuthorizationStatusAuthorized) { // 用户允许当前应用访问相册
           XXScanningVc  *scanning = [[XXScanningVc alloc]init];
            [self.navigationController pushViewController:scanning animated:YES];
    } else if (status == PHAuthorizationStatusNotDetermined) { // 用户还没有做出选择
            // 弹框请求用户授权
            [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
                if (status == PHAuthorizationStatusAuthorized) { // 用户点击了好
                    
                }
            }];
        }
        
    }else {
        
        SGAlertView *alertView = [SGAlertView alertViewWithTitle:@"⚠️ 警告" delegate:nil contentTitle:@"未检测到您的摄像头, 请在真机上测试" alertViewBottomViewType:(SGAlertViewBottomViewTypeOne)];
        [alertView show];
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
