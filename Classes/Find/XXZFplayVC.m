//
//  XXZFplayVC.m
//  SmileBella
//
//  Created by Bella on 17/1/24.
//  Copyright © 2017年 Bella. All rights reserved.
//

#import "XXZFplayVC.h"
#import <AVFoundation/AVFoundation.h>
#import <SVProgressHUD.h>
#import <ZFPlayer.h>
#import <Masonry.h>


@interface XXZFplayVC ()<ZFPlayerDelegate>
/**播放器View的父视图，至于为什么看看AVPlayer就知道了*/
@property(nonatomic,weak) UIView *PlayerFatherView;
/**播放器*/
@property(nonatomic,weak) ZFPlayerView *playerView;
/**model*/
@property(nonatomic,strong) ZFPlayerModel *playerModel;
/** 离开页面时候是否在播放 */
@property (nonatomic, assign) BOOL isPlaying;
/** 是否锁定屏幕方向 */
@property (nonatomic, assign) BOOL   isLocked;

@end

@implementation XXZFplayVC

#pragma mark --隐藏导航栏

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
    // pop回来时候是否自动播放
    if (self.navigationController.viewControllers.count == 2 && self.playerView && self.isPlaying) {
        self.isPlaying = NO;
        [self.playerView play];
    }

    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
    // push出下一级页面时候暂停
    if (self.navigationController.viewControllers.count == 3 && self.playerView && !self.playerView.isPauseByUser)
    {
        self.isPlaying = YES;
        [self.playerView pause];
    }

}
//


-(void)viewDidLoad{
    
    UIView *playerFatherView=[UIView new];
    [self.view addSubview:playerFatherView];
    [playerFatherView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(20);
        make.leading.trailing.mas_equalTo(0);
        make.height.mas_equalTo(playerFatherView.mas_width).multipliedBy(9.0f/16.0f);
    }];
    self.PlayerFatherView=playerFatherView;
    
    ZFPlayerView *playerView =[[ZFPlayerView alloc]init];
    [playerView playerControlView:nil playerModel:self.playerModel];
    playerView.delegate=self;
    //（可选设置）可以设置视频的填充模式，内部设置默认（ZFPlayerLayerGravityResizeAspect：等比例填充，直到一个维度到达区域边界）
     self.playerView.playerLayerGravity = ZFPlayerLayerGravityResizeAspect;
    
    // 打开下载功能（默认没有这个功能）
    playerView.hasDownload    = YES;
   
    
    // 打开预览图
    playerView.hasPreviewView = YES;
    
    // 是否自动播放，默认不自动播放
    [playerView autoPlayTheVideo];
    
    self.playerView=playerView;

}

- (ZFPlayerModel *)playerModel
{
    if (!_playerModel) {
        _playerModel                  = [[ZFPlayerModel alloc] init];
        _playerModel.title            = self.titleStr;
        _playerModel.videoURL         = [NSURL URLWithString:self.urlStr];
        
        _playerModel.placeholderImage = [UIImage imageNamed:@"loading_bgView1"];
        _playerModel.fatherView       = self.PlayerFatherView;
        
    }
    return _playerModel;
}

// 返回值要必须为NO
- (BOOL)shouldAutorotate
{
    return NO;
}
- (void)dealloc
{
    NSLog(@"%@释放了",self.class);
}



#pragma mark - ZFPlayerDelegate

- (void)zf_playerBackAction
{
    NSLog(@"返回");
    /** 判断导航栏是否存在 根据上一界面返回 */
    
//    if (self.navigationController.navigationBar != nil) {
        
        [self.navigationController popViewControllerAnimated:YES];
//    }else{
//        
//        [self dismissViewControllerAnimated:YES completion:nil];
//    }
    
    
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
