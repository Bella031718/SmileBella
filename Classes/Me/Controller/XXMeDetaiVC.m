//
//  XXMeDetaiVC.m
//  SmileBella
//
//  Created by Bella on 16/12/22.
//  Copyright © 2016年 Bella. All rights reserved.
//

#import "XXMeDetaiVC.h"
#import "UIButton+Extension.h"
#import <Masonry.h>

@interface XXMeDetaiVC ()<WKUIDelegate,WKNavigationDelegate>
@property(nonatomic,weak)UIView *footerView;
@property(nonatomic,weak)WKWebView *webView;
@property (weak, nonatomic)UIProgressView *progressView;
@property (nonatomic,weak)UIView *nav;

@end

@implementation XXMeDetaiVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self initView];
//    [self FooterView];

}


-(void)initView{
    NSLog(@"......");
    self.automaticallyAdjustsScrollViewInsets = NO;
    //导航栏视图
    UIView *nav = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 64)];
    nav.backgroundColor = kBLColor(244, 75, 63);//      编辑按钮
    UIButton *backBtn = [[UIButton alloc]init];
    //    backBtn.backgroundColor = [UIColor redColor];
    [backBtn setImage:[UIImage imageNamed:@"返回"] forState:UIControlStateNormal];
    [backBtn addActionWithTouchUpInside:^{
        [self.navigationController popViewControllerAnimated:YES];
    }];

    [self.view addSubview:nav];
    [nav addSubview:backBtn];

    WKWebView *webView = [[WKWebView alloc]init];
    webView.navigationDelegate = self; // 设置WKWebView代理方法
    webView.UIDelegate = self;
    webView.backgroundColor = xOrange;
    [self.view addSubview:webView];
    
    //展示网页
    NSURLRequest *request = [NSURLRequest requestWithURL:_url];
    [webView loadRequest:request];
    
    //进度条
    UIProgressView *progressView = [UIProgressView new];
    self.progressView = progressView;
    progressView.tintColor = xRed;
    progressView.trackTintColor = [UIColor clearColor];
    [self.nav addSubview:progressView];
    
    // 进度条
    [webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
    
    
    UIView *footerView = [[UIView alloc]init];   //WithFrame:CGRectMake(0, kScreenHeight-50, kScreenWidth, 50)];
    
    footerView.backgroundColor = xRed;
    
    UIButton *collect = [UIButton new];
    [collect setImage:[UIImage imageNamed:@"favourite"] forState:UIControlStateNormal];
    [collect setImage:[UIImage imageNamed:@"favourite_click"] forState:UIControlStateSelected];
    
    UIButton *share = [UIButton new];
    [share setImage:[UIImage imageNamed:@"Share_1"] forState:UIControlStateNormal];
    
    UIButton *more = [UIButton new];
    [more setImage:[UIImage imageNamed:@"MORE"] forState:UIControlStateNormal];
    
    [self.view addSubview:footerView];
    [footerView addSubview:collect];
    [footerView addSubview:share];
    [footerView addSubview:more];
    
    
    [webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.nav.mas_bottom);
        make.left.right.offset(0);
        make.bottom.equalTo(self.footerView.mas_top);
    }];
    
    [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(30);
        make.left.offset(10);
        make.height.equalTo(backBtn.mas_width);
    }];
    
    [nav mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.offset(0);
    }];

    [progressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.offset(0);
        make.height.offset(2);
    }];
    [self.footerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.offset(0);
        make.height.offset(44);
    }];
    
  
}

// 只要观察对象属性有新值就会调用
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{

    self.title = self.webView.title;
    self.progressView.progress = self.webView.estimatedProgress;
    self.progressView.hidden = self.webView.estimatedProgress >= 1;
}







#pragma mark - 对象被销毁

-(void)dealloc{
    [self.webView removeObserver:self forKeyPath:@"estimatedProgress"];
}

#pragma mark -- 隐藏导航栏
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
