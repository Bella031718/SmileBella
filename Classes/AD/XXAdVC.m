//
//  XXAdVC.m
//  SmileBella
//
//  Created by Bella on 16/12/17.
//  Copyright © 2016年 Bella. All rights reserved.
//

/*
 每次启动的时候进入广告
 1.在启动的时候,加个广告界面
 2.启动完成的时候,加个广告界面(展示了启动图片)
 
 -->可取
 A:程序已启动就进入广告界面,窗口的跟控制器设置为广告控制器
 --->麻烦
 B:直接往窗口上加一个广告界面,等几秒过去,在去广告界面移除
 
 
 
 */

#import "XXAdVC.h"
#import <Masonry.h>
#import "XXTabBarController.h"
#import <AFNetworking.h>
#import <MJExtension.h>
#import <UIImageView+WebCache.h>
#import "XXAdmodel.h"


#define code2 @"phcqnauGuHYkFMRquANhmgN_IauBThfqmgKsUARhIWdGULPxnz3vndtkQW08nau_I1Y1P1Rhmhwz5Hb8nBuL5HDknWRhTA_qmvqVQhGGUhI_py4MQhF1TvChmgKY5H6hmyPW5RFRHzuET1dGULnhuAN85HchUy7s5HDhIywGujY3P1n3mWb1PvDLnvF-Pyf4mHR4nyRvmWPBmhwBPjcLPyfsPHT3uWm4FMPLpHYkFh7sTA-b5yRzPj6sPvRdFhPdTWYsFMKzuykEmyfqnauGuAu95Rnsnbfknbm1QHnkwW6VPjujnBdKfWD1QHnsnbRsnHwKfYwAwiu9mLfqHbD_H70hTv6qnHn1PauVmynqnjclnj0lnj0lnj0lnj0lnj0hThYqniuVujYkFhkC5HRvnB3dFh7spyfqnW0srj64nBu9TjYsFMub5HDhTZFEujdzTLK_mgPCFMP85Rnsnbfknbm1QHnkwW6VPjujnBdKfWD1QHnsnbRsnHwKfYwAwiuBnHfdnjD4rjnvPWYkFh7sTZu-TWY1QW68nBuWUHYdnHchIAYqPHDzFhqsmyPGIZbqniuYThuYTjd1uAVxnz3vnzu9IjYzFh6qP1RsFMws5y-fpAq8uHT_nBuYmycqnau1IjYkPjRsnHb3n1mvnHDkQWD4niuVmybqniu1uy3qwD-HQDFKHakHHNn_HR7fQ7uDQ7PcHzkHiR3_RYqNQD7jfzkPiRn_wdKHQDP5HikPfRb_fNc_NbwPQDdRHzkDiNchTvwW5HnvPj0zQWndnHRvnBsdPWb4ri3kPW0kPHmhmLnqPH6LP1ndm1-WPyDvnHKBrAw9nju9PHIhmH9WmH6zrjRhTv7_5iu85HDhTvd15HDhTLTqP1RsFh4ETjYYPW0sPzuVuyYqn1mYnjc8nWbvrjTdQjRvrHb4QWDvnjDdPBuk5yRzPj6sPvRdgvPsTBu_my4bTvP9TARqnam"



@interface XXAdVC ()

@property(strong,nonatomic)UIImageView *launchImg;//启动图片
@property(strong,nonatomic)UIView *adContainView; //广告占位视图
@property(strong,nonatomic)UIImageView *adView; //广告图片
@property(strong,nonatomic)XXAdmodel *item;
@property(weak,nonatomic)NSTimer *timer;//定时器
@property(strong,nonatomic)UIButton *jumpBtn; //跳转按钮

@end

@implementation XXAdVC

//广告界面调用
-(void)tap{
    
    NSURL *url =[NSURL URLWithString:_item.ori_curl];
    UIApplication *app = [UIApplication sharedApplication];
    if ([app canOpenURL:url]) {
        [app openURL:url];
    }
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initView];
    
     // 加载广告数据 => 拿到活时间 => 服务器 => 查看接口文档 1.判断接口对不对 2.解析数据(w_picurl,ori_curl:跳转到广告界面,w,h) => 请求数据(AFN)
    [self loadJsonView];
    
    //创建定时器
    _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(tmerChange) userInfo:nil repeats:YES];
    
}

#pragma mark -- 加载广告数据
-(void)loadJsonView{
    //1.创建请求回话管理者
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    //2.拼接参数
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"code2"] = code2;
    
    //3.发送请求
    [manager GET:@"http://mobads.baidu.com/cpro/ui/mads.php" parameters:param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        NSLog(@"+++++++++++++++++++%@",responseObject);
        
        
//   响应头报错     equest failed: unacceptable content-type: text/html"
        
        //请求数据 --> 解析数据(写成plist文件) -->设计模型 -->字典转模型 --> 展示数据
        [responseObject writeToFile:@"/Users/bella/Desktop/ad.plist" atomically:YES];
        
        //获取字典
        NSDictionary *dict = [responseObject[@"ad"]lastObject];
        
        //字典转模型
         XXAdmodel *item =[XXAdmodel mj_objectWithKeyValues:dict];
//        NSLog(@"------------------%@",item);
        // 创建UIImageView展示图片 =>
        CGFloat h = kScreenWidth / item.w * item.h; //按比例拉伸
        self.adView.frame = CGRectMake(0, 0, kScreenWidth, h);
        
        //展示图片 用SDWebimage
        [self.adView sd_setImageWithURL:[NSURL URLWithString:item.w_picurl]];
        NSLog(@"%@",item.w_picurl);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];

}



-(void)initView{
    UIImageView *launchImg = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    self.launchImg = launchImg;
    
    UIView *adContainView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    adContainView.backgroundColor = [UIColor clearColor];
    
    self.adContainView = adContainView;
    
    UIImageView *iamgeView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];

    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)];
    
    [iamgeView addGestureRecognizer:tap];
    iamgeView.userInteractionEnabled = YES;
//    iamgeView.backgroundColor = [UIColor yellowColor];
    self.adView = iamgeView;
    
    UIButton *jumpBtn = [[UIButton alloc]initWithFrame:CGRectMake(300, 20, 60, 30)];
    [jumpBtn setTitle:@"跳过(3)"forState:UIControlStateNormal];
    jumpBtn.titleLabel.font = [UIFont systemFontOfSize:11];
    
    jumpBtn.backgroundColor = [UIColor grayColor];
    self.jumpBtn = jumpBtn;
    [jumpBtn addTarget:self action:@selector(clickJump:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:launchImg];
    [launchImg addSubview:adContainView];
    [adContainView addSubview:iamgeView];
    [self.view addSubview:jumpBtn];
    
    if (iphone7P) {
        self.launchImg.image = [UIImage imageNamed:@"launch800"];
    }else if (iphone7){
        self.launchImg.image = [UIImage imageNamed:@"launch750"];
    }else if (iphone5){
        self.launchImg.image = [UIImage imageNamed:@"launch560"];
    }else if (iphone4){
        self.launchImg.image = [UIImage imageNamed:@"launch700"];
    }

    
}

-(void)clickJump:(id)sender{
    //销毁广告界面,进入主框架界面
    XXTabBarController *tabbar = [[XXTabBarController alloc]init];
    [UIApplication sharedApplication].keyWindow.rootViewController = tabbar;
    //销毁定时器
    [_timer invalidate];
}



//定时器
-(void)tmerChange{
    //倒计时
    static int i = 3;
    if (i == 0) {
        [self clickJump:nil];
    }
    i--;
    [_jumpBtn setTitle:[NSString stringWithFormat:@"跳过 (%d)",i]forState:UIControlStateNormal];
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
