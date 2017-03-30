//
//  XXHomeCycleView.m
//  SmileBella
//
//  Created by Bella on 17/3/17.
//  Copyright © 2017年 Bella. All rights reserved.
//

#import "XXHomeCycleView.h"
#import "SDCycleScrollView.h"
#import "XXTopModel.h"


@interface XXHomeCycleView ()<SDCycleScrollViewDelegate>

@property (nonatomic, strong)SDCycleScrollView *cycleView;

@property (nonatomic, strong)UILabel *title;

@property (nonatomic, strong)NSMutableArray *roomIdArr;

@end

@implementation XXHomeCycleView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self firstLoading];
    }//
    return self;
}

- (void)firstLoading{
    //创建轮播
    self.cycleView = [[SDCycleScrollView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 200*KWidth_Scale)];
    //背景颜色
    self.cycleView.backgroundColor = [UIColor whiteColor];
    //分页控件位置
    self.cycleView.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
    //分页控件的样式
    self.cycleView.pageControlStyle = SDCycleScrollViewPageContolStyleClassic;
    //轮播分页控件小圆标颜色
    self.cycleView.pageDotColor = [UIColor whiteColor];
//    轮播占位图片
    self.cycleView.placeholderImage = [UIImage imageNamed:@"Img_default"];
    SDCycleScrollView *cycleView = [[SDCycleScrollView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 170)];
    cycleView.backgroundColor = [UIColor purpleColor];
    self.cycleView.delegate = self;
    [cycleView addSubview:self.cycleView];
    [self addSubview:cycleView];
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(5, CGRectGetMaxY(self.cycleView.frame) +10, 6, 26)];
    lineView.backgroundColor = [UIColor redColor];
    [self addSubview:lineView];
    
    self.title = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(lineView.frame) + 4, CGRectGetMaxY(self.cycleView.frame) + 10, 150, 26)];
    self.title.text = @"最热直播";
    self.title.font = [UIFont boldSystemFontOfSize:16];
    self.title.textColor = [UIColor blackColor];
    self.title.textAlignment = NSTextAlignmentLeft;
//    self.title.backgroundColor = [UIColor yellowColor];
    
    UIButton *moreBtn = [[UIButton alloc]initWithFrame:CGRectMake((CGRectGetMaxX(lineView.frame)+315), CGRectGetMaxY(self.cycleView.frame)+13, 80, 20)];
    [moreBtn setTitle:@"更多 >>" forState:UIControlStateNormal];
    [moreBtn setTitleColor:xGray forState:UIControlStateNormal];
    moreBtn.titleLabel.font = [UIFont systemFontOfSize:15];
//    moreBtn.backgroundColor = [UIColor redColor];
    [self addSubview:self.title];
    [self addSubview:moreBtn];
    
}

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    if ([_delegate respondsToSelector:@selector(homeCycleView:roomId:)]) {
        [_delegate homeCycleView:self roomId:self.roomIdArr[index]];
    }
    
}



@end

