//
//  XXAllCell.m
//  SmileBella
//
//  Created by Bella on 17/1/3.
//  Copyright © 2017年 Bella. All rights reserved.
//

#import "XXAllCell.h"
#import <Masonry.h>
#import "UIImageView+Download.h"
#import "XXAllModel.h"

@implementation XXAllCell

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
    
//    UIImageView *playImage = [UIImageView new];
//    
//    UIButton *playBtn = [UIButton new];
//    [playBtn setImage:[UIImage imageNamed:@"video-play"] forState:UIControlStateNormal];

    UIView *ToolView = [UIView new];
//    ToolView.backgroundColor = xRed;
    
    UIButton *dingBtn = [UIButton new];
    [dingBtn setImage:[UIImage imageNamed:@"mainCellDing"] forState:UIControlStateNormal];
    [dingBtn setTitle:@"赞" forState:UIControlStateNormal];
    [dingBtn setTitleColor:xGray forState:UIControlStateNormal];
    self.dingBtn = dingBtn;

    
    UIButton *caiBtn = [UIButton new];
    [caiBtn setImage:[UIImage imageNamed:@"mainCellCai"] forState:UIControlStateNormal];
    [caiBtn setTitle:@"踩"forState:UIControlStateNormal];
    [caiBtn setTitleColor:xGray forState:UIControlStateNormal];
    self.caiBtn = caiBtn;
    
    UIButton *sharBtn = [UIButton new];
    [sharBtn setImage:[UIImage imageNamed:@"mainCellShare"] forState:UIControlStateNormal];
    [sharBtn setTitle:@"分享"forState:UIControlStateNormal];
    [sharBtn setTitleColor:xGray forState:UIControlStateNormal];
    [sharBtn addTarget:self action:@selector(sharTosomeOnePeople) forControlEvents:UIControlEventTouchUpInside];
    self.sharBtn = sharBtn;
    
    
    UIButton *pingBtn = [UIButton new];
    [pingBtn setImage:[UIImage imageNamed:@"mainCellComment"] forState:UIControlStateNormal];
    [pingBtn setTitle:@"评论"forState:UIControlStateNormal];
    [pingBtn setTitleColor:xGray forState:UIControlStateNormal];
    self.pingBtn = pingBtn;
    
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
//    [self.contentView addSubview:playImage];
    
    
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
    [contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(iconImage.mas_bottom).offset(5);
        make.left.equalTo(self.contentView.mas_left).offset(10);
        make.right.equalTo(self.contentView.mas_right).offset(-10);
        make.bottom.equalTo(ToolView.mas_top).offset(5);
    }];
    
    
    [ToolView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(contentLabel.mas_bottom).offset(15);
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

-(void)setModel:(XXAllModel *)model{
    
    _model = model;
    [self.iconImage xx_setHeader:model.profile_image];
    self.nameLabel.text = model.name;
    self.timeLabel.text = model.passtime;
    self.contentLabel.text = model.text;
    
    // 底部按钮的文字
    
    [self.dingBtn setTitle:model.ding forState:UIControlStateNormal];
    [self.caiBtn setTitle:model.cai forState:UIControlStateNormal];
    [self.sharBtn setTitle:model.favourite forState:UIControlStateNormal];
    [self.pingBtn setTitle:model.comment forState:UIControlStateNormal];
    
    
    
    
}

/**
 *  设置按钮文字
 *  @param number      按钮的数字
 *  @param placeholder 数字为0时显示的文字
 */
- (void)setupButtonTitle:(UIButton *)button number:(NSInteger)number placeholder:(NSString *)placeholder
{
    if (number >= 10000) {
        [button setTitle:[NSString stringWithFormat:@"%.1f万", number / 10000.0] forState:UIControlStateNormal];
    } else if (number > 0) {
        [button setTitle:[NSString stringWithFormat:@"%zd", number] forState:UIControlStateNormal];
    } else {
        [button setTitle:placeholder forState:UIControlStateNormal];
    }
}


-(void)setFrame:(CGRect)frame{
    frame.size.height -= 10;
    [super setFrame:frame];
}

-(void)sharTosomeOnePeople{
    
    NSLog(@"点击分享");
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
