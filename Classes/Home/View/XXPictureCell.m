//
//  XXPictureCell.m
//  SmileBella
//
//  Created by Bella on 17/1/3.
//  Copyright © 2017年 Bella. All rights reserved.
//

#import "XXPictureCell.h"
#import <Masonry.h>
#import "XXAllModel.h"
#import "UIImageView+Download.h"
#import <UIImageView+WebCache.h>
#import "XXSeeBigPicture.h"

@interface XXPictureCell ()

@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UIImageView *iconImage;
@property (nonatomic, strong) UIButton *moreBtn;

@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, strong) UIButton *dingBtn;
@property (nonatomic, strong) UIButton *caiBtn;
@property (nonatomic, strong) UIButton *sharBtn;
@property (nonatomic, strong) UIButton *pingBtn;

@property (nonatomic, strong) UIImageView *gifImage;
@property (nonatomic, strong) UIImageView *pictureImage;
@property (nonatomic, strong) UIButton *chooseBtn;


@end


@implementation XXPictureCell

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
    
    UIImageView *gif = [UIImageView new];
    gif.image = [UIImage imageNamed:@"common-gif"];
    self.gifImage = gif;
    
    
    UIImageView *picture = [UIImageView new];
    self.pictureImage = picture;
    //设置图片交互
    self.pictureImage.userInteractionEnabled = YES;
    [self.pictureImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(seeBig)]];
//    picture.image = [UIImage imageNamed:@"launch"];
    
    UIButton *chooseBtn = [UIButton new];
    [chooseBtn setImage:[UIImage imageNamed:@"see-big-picture"] forState:UIControlStateNormal];
    [chooseBtn setBackgroundImage:[UIImage imageNamed:@"see-big-picture-background"] forState:UIControlStateNormal];
    [chooseBtn setTitle:@" 点击查看大图" forState:UIControlStateNormal];
    
    self.chooseBtn = chooseBtn;
    [chooseBtn addTarget:self action:@selector(seeBig) forControlEvents:UIControlEventAllEvents];
    
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
    [sharBtn addTarget:self action:@selector(sharEverthing) forControlEvents:UIControlEventTouchUpInside];
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
    [self.contentView addSubview:picture];
    [self.contentView addSubview:chooseBtn];
    [self.contentView addSubview:gif];
    
    
    
    [iconImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(self.contentView).offset(10);
        make.size.mas_offset(CGSizeMake(45, 45));
      
    }];
    
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
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
        make.height.mas_offset(50);
    }];
    
    
    [picture mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(contentLabel.mas_bottom).offset(5);
        make.left.equalTo(self.contentView.mas_left).offset(10);
        make.right.equalTo(self.contentView.mas_right).offset(-10);
        //        make.bottom.equalTo(ToolView.mas_top).offset(5);
    }];
    [chooseBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(picture.mas_left);
        make.right.equalTo(picture.mas_right);
        make.height.offset(45);
        make.bottom.equalTo(picture.mas_bottom);
        
    }];
    [gif mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(picture.mas_top);
        make.left.equalTo(picture.mas_left);
    }];
    
    [ToolView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(picture.mas_bottom).offset(15);
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
    /** 
     花花又得当保姆,
     
     */
}

-(void)setModel:(XXAllModel *)model{
    
    _model = model;
    
    [self.iconImage xx_setHeader:model.profile_image];
    self.nameLabel.text = model.name;
    self.timeLabel.text = model.passtime;
    self.contentLabel.text = model.text;
 
    
    [self.dingBtn setTitle:model.ding forState:UIControlStateNormal];
    [self.caiBtn setTitle:model.cai forState:UIControlStateNormal];
    [self.sharBtn setTitle:model.favourite forState:UIControlStateNormal];
    [self.pingBtn setTitle:model.comment forState:UIControlStateNormal];

    
#warning 图片展开不完善
    [self.pictureImage sd_setImageWithURL:[NSURL URLWithString:model.image0]
                    placeholderImage:[UIImage imageNamed:@"launch.png"]
                             options:SDWebImageDelayPlaceholder | SDWebImageRetryFailed];
    
//        self.pictureImage.contentMode=UIViewContentModeTop;
//        self.pictureImage.autoresizingMask=UIViewAutoresizingNone;
//        self.pictureImage.layer.masksToBounds=YES;
//        
//    }];
    self.gifImage.hidden = !model.is_gif;
  
    
    
}

//查看大图
-(void)seeBig{
    
    XXSeeBigPicture *vc = [[XXSeeBigPicture alloc] init];
    vc.model = self.model;
    [self.window.rootViewController presentViewController:vc animated:YES completion:nil];

}

-(void)setFrame:(CGRect)frame{
    frame.size.height -= 10;
    [super setFrame:frame];
}


-(void)sharEverthing{
    
    NSLog(@"分享");
    
    
}


@end
