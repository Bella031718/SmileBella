//
//  XXPlayVC.m
//  SmileBella
//
//  Created by Bella on 17/1/5.
//  Copyright © 2017年 Bella. All rights reserved.
//

#import "XXPlayVC.h"
#import <RBVideoPlayer.h>
#import <Masonry.h>

@interface XXPlayVC ()<RBPlayerViewDelegate>

@property(nonatomic,strong)RBVideoPlayer *player;

@end

@implementation XXPlayVC

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self setRBplay];
}

//创建播放器
-(void)setRBplay{
   
    NSString *url = self.VideoURL;
    
    self.player = [[RBVideoPlayer alloc] init];
    
    [self.view addSubview:self.player.view];
    
    self.player.view.delegate = self;
    [self.player.view mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.mas_topLayoutGuideBottom);;
        //        make.leading.bottom.trailing.insets(UIEdgeInsetsZero);
        make.leading.bottom.trailing.insets(UIEdgeInsetsMake(10, 10, 10, 10));
    }];
   
   self.view.backgroundColor = [UIColor blackColor];
    
    
    // 设置标题
    RBPlayerItem *item = [[RBPlayerItem alloc] init];
    item.title = self.videoTitle? self.videoTitle: @"这都是什么电影";
    item.assetTitle = @"清晰";
    
    RBPlayerItemAsset *itemAsset1 = [[RBPlayerItemAsset alloc] initWithType:@"清晰" URL:[NSURL URLWithString:url]];
    RBPlayerItemAsset *itemAsset2 = [[RBPlayerItemAsset alloc] initWithType: @"高清" URL:[NSURL URLWithString:url]];
    
    item.assets = @[itemAsset1, itemAsset2];
    
    [self.player replaceCurrentItemWithPlayerItem:item];
    [self.player playWithItemAsset:itemAsset1]; // 默认播放的清晰度
    
    
    // 设置左边按钮
    if ([_player.topMask isKindOfClass:[RBPlayerTopMask class]]) {
        RBPlayerTopMask *topMask = (RBPlayerTopMask *)_player.topMask;
        
        __weak typeof(self) weakSelf = self;
        RBPlayerControlBackButton *backButton = [[RBPlayerControlBackButton alloc] initWithMask:topMask mainBlock:^{
            weakSelf.player.view.supportedOrientations = UIInterfaceOrientationMaskAll;
            [weakSelf.player.view performOrientationChange:UIInterfaceOrientationUnknown animated:NO];
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakSelf.navigationController popViewControllerAnimated:YES];
            });
        }];
        topMask.leftButtons = @[ backButton ];
    }
    
    [self.view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss)]];
  
}

- (void)dismiss {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)dealloc
{
    NSLog(@"%s",__func__);
}



#pragma mark - RBPlayerViewDelegate
- (BOOL)playerView:(RBPlayerView *)playerView willOrientationChange:(UIInterfaceOrientation)orientation {
    
    UIInterfaceOrientation statusBarOrientation = [[UIApplication sharedApplication] statusBarOrientation];
    
    if (orientation != UIInterfaceOrientationUnknown) {
        [[UIApplication sharedApplication] setStatusBarOrientation:orientation animated:NO];
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
        
        if (UIInterfaceOrientationIsLandscape(statusBarOrientation) && [playerView containsMask:self.player.topMask]) {
            [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationNone];
        } else {
            [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationNone];
        }
    } else {
        dispatch_async(dispatch_get_main_queue(), ^{
            [[UIApplication sharedApplication] setStatusBarOrientation:UIInterfaceOrientationPortrait animated:NO];
            [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:YES];
            [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationNone];
        });
    }
    return YES;
}

- (BOOL)playerView:(RBPlayerView *)playerView willAddMask:(RBPlayerViewMask *)mask animated:(BOOL)animated {
    if ([mask isEqual:self.player.topMask]) {
        UIInterfaceOrientation statusBarOrientation = [[UIApplication sharedApplication] statusBarOrientation];
        if (UIInterfaceOrientationIsLandscape(statusBarOrientation)) {
            [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:animated ? UIStatusBarAnimationFade : UIStatusBarAnimationNone];
        }
    }
    return YES;
}

- (BOOL)playerView:(RBPlayerView *)playerView willRemoveMask:(RBPlayerViewMask *)mask animated:(BOOL)animated {
    if ([mask isEqual:self.player.topMask] && playerView.isFullScreen) {
        [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:animated ? UIStatusBarAnimationFade : UIStatusBarAnimationNone];
    }
    return YES;
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
