//
//  XXShareView.h
//  SmileBella
//
//  Created by Bella on 17/3/22.
//  Copyright © 2017年 Bella. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XXShareView : UIView

//遮罩幕布
@property (nonatomic, strong)UIView *maskView;

//关闭按钮
@property (nonatomic, strong)UIButton *cancelBtn;

//分享视图
@property (nonatomic, strong)UIImageView  *shareImage;

//显示
-(void)showView;
//取消
-(void)disMiss;
@end
