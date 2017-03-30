//
//  XXShareView.m
//  SmileBella
//
//  Created by Bella on 17/3/22.
//  Copyright © 2017年 Bella. All rights reserved.
//

#import "XXShareView.h"
#import <Masonry.h>

@implementation XXShareView

/** 定义一个BOOL值 */
{
    BOOL isShow;
}

-(instancetype)init{
    
    self = [super init];
    if (!self) return nil;
    
    [self initView];
    
    return self;
}

-(void)initView{
    
    [self showView];
}

-(void)showView{
    //调用窗口
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    
   
    //遮罩视图
    self.maskView = [UIView new];
    self.maskView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
    self.maskView.backgroundColor = [UIColor grayColor];
    //透明度
    self.maskView.alpha = 0.4f;
    [self addSubview:self.maskView];
    
//    [UIView animateWithDuration:0.5f animations:^{
//         [UIView animateWithDuration:0.5f animations:^{
//             
//             delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:0 options:UIViewAnimationOptionTransitionCurlDown
       
        self.shareImage = [UIImageView new];
        self.shareImage.image = [UIImage imageNamed:@"标签栏"];
        self.shareImage.userInteractionEnabled = YES;
        [self addSubview:self.shareImage];
        
        self.cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.cancelBtn.frame = CGRectMake(6, kScreenHeight-54, kScreenWidth-12, 46);
        [self.cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        [self.cancelBtn setTitleColor:[UIColor colorWithRed:51/255.0 green:134/255.0 blue:199/255.0 alpha:1.0f] forState:UIControlStateNormal];
        [self.cancelBtn setBackgroundImage:[UIImage imageNamed:@"矩形-3"] forState:UIControlStateNormal];
    [self.cancelBtn addTarget:self action:@selector(touchesEnded:withEvent:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.cancelBtn];
        
        //qq分享按键
        UIButton *qqBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [qqBtn setImage:[UIImage imageNamed:@"qq"] forState:UIControlStateNormal];
        [qqBtn setFrame:CGRectMake(22, 21, 40, 40)];
        [self.shareImage addSubview:qqBtn];
        
        
        UILabel *qqLabel=[[UILabel alloc]initWithFrame:CGRectMake(12, 65, 60, 20)];
        qqLabel.text=@"QQ";
        qqLabel.textAlignment=YES;
        qqLabel.textColor=[UIColor colorWithRed:105/255.0f green:105/255.0f blue:105/255.0f alpha:1.0f];
        qqLabel.font=[UIFont systemFontOfSize:14];
        [self.shareImage addSubview:qqLabel];
        
        //wechat分享按键
        UIButton * wechatButton =[UIButton buttonWithType:UIButtonTypeCustom];
        [wechatButton setImage:[UIImage imageNamed:@"weixin"] forState:UIControlStateNormal];
        [wechatButton setFrame:CGRectMake(100, 21, 40, 40)];
        //        [wechatButton addTarget:self action:@selector(wechatShareClick) forControlEvents:UIControlEventTouchUpInside];
        [self.shareImage addSubview:wechatButton];
        
        UILabel *wechatLabel=[[UILabel alloc]initWithFrame:CGRectMake(90, 65, 60, 20)];
        wechatLabel.text=@"微信好友";
        wechatLabel.textAlignment=YES;
        wechatLabel.textColor=[UIColor colorWithRed:105/255.0f green:105/255.0f blue:105/255.0f alpha:1.0f];
        wechatLabel.font=[UIFont systemFontOfSize:14];
        [self.shareImage addSubview:wechatLabel];
        
        //朋友圈
        UIButton *wechatFriends=[UIButton buttonWithType:UIButtonTypeCustom];
        [wechatFriends setImage:[UIImage imageNamed:@"weixin"] forState:UIControlStateNormal];
        [wechatFriends setFrame:CGRectMake(174, 21, 40, 40)];
        //        [wechatFriends addTarget:self action:@selector(wechatFriendsShareClick) forControlEvents:UIControlEventTouchUpInside];
        [self.shareImage addSubview:wechatFriends];
        
        UILabel *wechatFriendsLabel=[[UILabel alloc]initWithFrame:CGRectMake(164, 65, 60, 20)];
        wechatFriendsLabel.text=@"朋友圈";
        wechatFriendsLabel.textAlignment=YES;
        wechatFriendsLabel.textColor=[UIColor colorWithRed:105/255.0f green:105/255.0f blue:105/255.0f alpha:1.0f];
        wechatFriendsLabel.font=[UIFont systemFontOfSize:14];
        [self.shareImage addSubview:wechatFriendsLabel];
        
        //sina分享按键
        UIButton * sinaButton =[UIButton buttonWithType:UIButtonTypeCustom];
        [sinaButton setImage:[UIImage imageNamed:@"微博"] forState:UIControlStateNormal];
        [sinaButton setFrame:CGRectMake(250, 21, 40, 40)];
        //        [sinaButton addTarget:self action:@selector(sinaShareClick) forControlEvents:UIControlEventTouchUpInside];
        [self.shareImage addSubview:sinaButton];
        
        UILabel *sinaLabel=[[UILabel alloc]initWithFrame:CGRectMake(240, 65, 60, 20)];
        sinaLabel.text=@"新浪微博";
        sinaLabel.textAlignment=YES;
        sinaLabel.textColor=[UIColor colorWithRed:105/255.0f green:105/255.0f blue:105/255.0f alpha:1.0f];
        sinaLabel.font=[UIFont systemFontOfSize:14];
        [self.shareImage addSubview:sinaLabel];
        
        
        [self.maskView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset(0);
            make.left.right.bottom.equalTo(self).offset(0);
        }];
        
        [self.shareImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self).offset(-54);
            make.right.equalTo(self).offset(-6);
            make.left.equalTo(self).offset(6);
            make.height.mas_equalTo(107);
        }];
        
        [self.cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self).offset(-4);
            make.right.equalTo(self).offset(-6);
            make.left.equalTo(self).offset(6);
            make.height.mas_equalTo(46);
        }];
        
        NSInteger topShareWidth=kScreenWidth-12;
        NSInteger  iconSize=(topShareWidth/4-50)/2;
        NSLog(@"~~~~~~~~~~~~~~~%ld",iconSize);
        
        [wechatButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.shareImage.mas_top).offset(18);
            make.left.equalTo(self.shareImage).offset(iconSize);
            make.height.mas_equalTo(50);
            make.width.mas_equalTo(50);
        }];
        
        [wechatLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(wechatButton).offset(53);
            make.centerX.equalTo(wechatButton);
            make.height.mas_equalTo(30);
            make.width.mas_equalTo(60);
        }];
        
        [wechatFriends mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.shareImage).offset(18);
            make.right.equalTo(wechatButton).offset(iconSize*2+50);
            make.height.mas_equalTo(50);
            make.width.mas_equalTo(50);
        }];
        
        [wechatFriendsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(wechatFriends).offset(53);
            make.centerX.equalTo(wechatFriends);
            make.width.mas_equalTo(60);
            make.height.mas_equalTo(30);
        }];
        
        [qqBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.shareImage).offset(18);
            make.right.equalTo(wechatFriends).offset(iconSize*2+50);
            make.height.mas_equalTo(50);
            make.width.mas_equalTo(50);
        }];
        
        [qqLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(qqBtn).offset(53);
            make.centerX.equalTo(qqBtn);
            make.width.mas_equalTo(60);
            make.height.mas_equalTo(30);
        }];
        
        [sinaButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.shareImage).offset(18);
            make.right.equalTo(qqBtn).offset(iconSize*2+50);
            make.height.mas_equalTo(50);
            make.width.mas_equalTo(50);
        }];
        
        [sinaLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(sinaButton).offset(53);
            make.centerX.equalTo(sinaButton);
            make.height.mas_equalTo(30);
            make.width.mas_equalTo(60);
        }];
    
}



- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
    NSLog(@"点击了取消按钮");
         [self disMiss];
   
   
}


-(void)disMiss{
   
    [self removeFromSuperview];
}







@end
