//
//  XXVideoCell.m
//  SmileBella
//
//  Created by Bella on 16/12/30.
//  Copyright © 2016年 Bella. All rights reserved.
//

#import "XXVideoCell.h"
#import <Masonry.h>
#import "UIImageView+Download.h"
#import "XXVideoModel.h"
#import <Masonry.h>
#import <UIImageView+WebCache.h>
#import "XXPlayVC.h"
#import "XXShareView.h"

@interface XXVideoCell ()

@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UIImageView *iconImage;
@property (nonatomic, strong) UIButton *moreBtn;

@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, strong) UIButton *dingBtn;
@property (nonatomic, strong) UIButton *caiBtn;
@property (nonatomic, strong) UIButton *sharBtn;
@property (nonatomic, strong) UIButton *pingBtn;

@property (nonatomic, strong)UIImageView *playImage;
@property (nonatomic, strong)UIButton *playBtn;



@end


@implementation XXVideoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}



-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self initCell];
    }
    return self;
    
}


-(void)initCell{
    //头像
    UIImageView *iconImage = [UIImageView new];
    iconImage.layer.cornerRadius = 5;
    iconImage.clipsToBounds = YES;
    //    iconImage.backgroundColor =[UIColor purpleColor];
    self.iconImage = iconImage;
    
    UILabel *nameLabel = [UILabel new];
    nameLabel.textColor = xGray;
    nameLabel.font = [UIFont systemFontOfSize:15];
    self.nameLabel = nameLabel;
    
    UILabel *timeLabel = [UILabel new];
    timeLabel.textColor = xGray;
    timeLabel.font = [UIFont systemFontOfSize:13];
    self.timeLabel = timeLabel;
    
    UIButton *moreBtn = [UIButton new];
    [moreBtn setImage:[UIImage imageNamed:@"cellmorebtnclick" ] forState:UIControlStateNormal];
    self.moreBtn = moreBtn;
    
    UILabel *contentLabel = [UILabel new];
    contentLabel.textColor = xBlack;
    contentLabel.font = [UIFont systemFontOfSize:14];
    contentLabel.textAlignment=NSTextAlignmentLeft;
    contentLabel.numberOfLines=0;
    self.contentLabel = contentLabel;
    
    UIImageView *playImage = [UIImageView new];
    self.playImage = playImage;
    playImage.image = [UIImage imageNamed:@"launch"];

    UIButton *playBtn = [UIButton new];
    [playBtn setImage:[UIImage imageNamed:@"video-play"] forState:UIControlStateNormal];
    self.playBtn = playBtn;
    [playBtn addTarget:self action:@selector(playButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    UIView *ToolView = [UIView new];
    //    ToolView.backgroundColor = xRed;
    
    UIButton *dingBtn = [UIButton new];
    [dingBtn setImage:[UIImage imageNamed:@"mainCellDing"] forState:UIControlStateNormal];
    [dingBtn setTitle:@"赞" forState:UIControlStateNormal];
    [dingBtn setTitleColor:xGray forState:UIControlStateNormal];
    self.dingBtn = dingBtn;
    [dingBtn addTarget:self action:@selector(dingButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *caiBtn = [UIButton new];
    [caiBtn setImage:[UIImage imageNamed:@"mainCellCai"] forState:UIControlStateNormal];
    [caiBtn setTitle:@"踩"forState:UIControlStateNormal];
    [caiBtn setTitleColor:xGray forState:UIControlStateNormal];
    self.caiBtn = caiBtn;
    [caiBtn addTarget:self action:@selector(caiButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *sharBtn = [UIButton new];
    [sharBtn setImage:[UIImage imageNamed:@"mainCellShare"] forState:UIControlStateNormal];
    [sharBtn setTitle:@"分享"forState:UIControlStateNormal];
    [sharBtn setTitleColor:xGray forState:UIControlStateNormal];
    self.sharBtn = sharBtn;
    [sharBtn addTarget:self action:@selector(sharEverthing) forControlEvents:UIControlEventTouchUpInside];
   
    UIButton *pingBtn = [UIButton new];
    [pingBtn setImage:[UIImage imageNamed:@"mainCellComment"] forState:UIControlStateNormal];
    [pingBtn setTitle:@"评论"forState:UIControlStateNormal];
    [pingBtn setTitleColor:xGray forState:UIControlStateNormal];
    self.pingBtn = pingBtn;
    [pingBtn addTarget:self action:@selector(commentButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self.contentView addSubview:ToolView];
    [ToolView addSubview:pingBtn];
    [ToolView addSubview:dingBtn];
    [ToolView addSubview:sharBtn];
    [ToolView addSubview:caiBtn];
    
    //    self.contentView.backgroundColor = [UIColor yellowColor];
    [self.contentView addSubview:iconImage];
    [self.contentView addSubview:nameLabel];
    [self.contentView addSubview:timeLabel];
    [self.contentView addSubview:moreBtn];
    [self.contentView addSubview:contentLabel];
    [self.contentView addSubview:playImage];
    [self.contentView addSubview:playBtn];
   
    [iconImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(self.contentView).offset(10);
        make.size.mas_offset(CGSizeMake(45, 45));
//        make.bottom.equalTo(contentLabel.mas_top);
    }];
    
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(iconImage.mas_top);
        make.top.equalTo(self.contentView).offset(10);
        make.left.equalTo(iconImage.mas_right).offset(10);
    }];
    
    [timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(nameLabel.mas_bottom).offset(5);
        make.left.equalTo(nameLabel.mas_left);
    }];
    [moreBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(10);
        make.right.offset(-10);
        make.size.mas_offset(CGSizeMake(45, 45));
    }];
   
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.iconImage.mas_bottom).offset(5);
        make.left.equalTo(self.contentView.mas_left).offset(10);
        make.right.equalTo(self.contentView.mas_right).offset(-10);
        make.bottom.equalTo(playImage.mas_top).offset(-10);
    }];
    
    
    [playImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(contentLabel.mas_bottom).offset(5);
        make.left.equalTo(self.contentView.mas_left).offset(10);
        make.right.equalTo(self.contentView.mas_right).offset(-10);
//        make.bottom.equalTo(ToolView.mas_top).offset(5);
    }];
    [playBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(playImage.mas_centerX);
        make.centerY.equalTo(playImage.mas_centerY);
        make.size.mas_offset(CGSizeMake(45, 45));
    }];
    
    [ToolView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(playImage.mas_bottom).offset(15);
        make.left.right.offset(0);
        make.height.offset(40);
        make.bottom.equalTo(self.contentView.mas_bottom);
    }];
    [dingBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(ToolView.mas_left);
        make.top.equalTo(ToolView.mas_top);
        make.size.mas_offset(CGSizeMake(80, 40));
    }];
    
    [caiBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(dingBtn.mas_right).offset(15);
        make.top.equalTo(ToolView.mas_top);
        make.size.mas_offset(CGSizeMake(80, 40));
    }];
    
    [sharBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(pingBtn.mas_left).offset(-15);
        make.top.equalTo(ToolView.mas_top);
        make.size.mas_offset(CGSizeMake(80, 40));
    }];
    
    [pingBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(ToolView.mas_right);
        make.top.equalTo(ToolView.mas_top);
        make.size.mas_offset(CGSizeMake(80, 40));
    }];
    
}

-(void)setModel:(XXVideoModel *)model{
    
    _model = model;
    
    [self.iconImage xx_setHeader:model.profile_image];
    self.nameLabel.text = model.name;
    self.timeLabel.text = model.passtime;
    self.contentLabel.text = model.text;
    
   
    [self.playImage sd_setImageWithURL:[NSURL URLWithString:model.image_small] placeholderImage:[UIImage imageNamed:@"setup-head-default"] options:SDWebImageDelayPlaceholder | SDWebImageRetryFailed];
   
    [self.dingBtn setTitle:model.ding forState:UIControlStateNormal];
    [self.caiBtn setTitle:model.cai forState:UIControlStateNormal];
    [self.sharBtn setTitle:model.favourite forState:UIControlStateNormal];
    [self.pingBtn setTitle:model.comment forState:UIControlStateNormal];
    

}


//播放视频
- (void)playButtonClick
{
    self.playblock();
    NSLog(@"我是播放器我是播放器我是播放器");
    
}
//点赞
-(void)dingButtonClick
{
    
}

//踩
-(void)caiButtonClick{
    
}

//评论
-(void)commentButtonClick{
    
}

//分享
-(void)sharEverthing{
    
    
    NSLog(@"点击分享按钮");
    XXShareView *sharView = [[XXShareView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];

    [sharView showView];

}






-(void)setFrame:(CGRect)frame{
    frame.size.height -= 10;
    [super setFrame:frame];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
