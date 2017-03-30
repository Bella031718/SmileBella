//
//  XXRecommmendCell.m
//  SmileBella
//
//  Created by Bella on 16/12/20.
//  Copyright © 2016年 Bella. All rights reserved.
//

#import "XXRecommmendCell.h"
#import <Masonry.h>
#import "XXRemmoendModel.h"
#import <UIImageView+WebCache.h>

@implementation XXRecommmendCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupView];
        
    }
    return self;
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark --模型展示数据
-(void)setModel:(XXRemmoendModel *)model{
    _model = model;
    
    _nameLabel.text = model.theme_name;
    
    NSString *numStr = [NSString stringWithFormat:@"%@人订阅",model.sub_number];
    NSInteger num = model.sub_number.integerValue;//转化成整型
    if (num > 10000) {
        CGFloat numS = num/10000.0;
        numStr = [NSString stringWithFormat:@"%.1f万人订阅",numS];
        numStr = [numStr stringByReplacingOccurrencesOfString:@".0" withString:@""];
    }
    
    _numLabel.text = numStr;
    
    //设置头像
    [_headImage sd_setImageWithURL:[NSURL URLWithString:model.image_list] placeholderImage:[UIImage imageNamed:@"usericon"]];
    
    
}


-(void)setFrame:(CGRect)frame{
    frame.size.height -= 1;
    
    [super setFrame:frame];
}



//布局
-(void)setupView{
    //头像
    UIImageView *headerImage = [UIImageView new];
    self.headImage = headerImage;
    //把图片裁剪成圆角
    headerImage.layer.cornerRadius = 30;
    headerImage.clipsToBounds = YES;
    headerImage.backgroundColor =[UIColor purpleColor];
    //名称
    UILabel *NameLabel = [UILabel new];
    self.nameLabel =NameLabel;
   
    NameLabel.textColor = xBlack;
    NameLabel.font =[UIFont systemFontOfSize:15];
    //订阅数
    UILabel *num = [UILabel new];
    self.numLabel = num;
//    num.backgroundColor = xRed;
    num.textColor = xBlack;
    num.font =[UIFont systemFontOfSize:14];
    //按钮
    UIButton *subBtn = [UIButton new];
    self.subscribeBtn = subBtn;
    [subBtn setTitle:@"+订阅" forState:UIControlStateNormal];
    [subBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    subBtn.backgroundColor = [UIColor whiteColor];
    subBtn.titleLabel.font = [UIFont systemFontOfSize:16];
  
    [self.contentView addSubview:headerImage];
    [self.contentView addSubview:NameLabel];
    [self.contentView addSubview:num];
    [self.contentView addSubview:subBtn];
    
    [headerImage mas_makeConstraints:^(MASConstraintMaker *make) {
    
        make.left.offset(20);
        make.centerY.offset(0);
        make.size.mas_offset(CGSizeMake(60, 60));
    }];
    
    [NameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(10);
        make.left.equalTo(headerImage.mas_right).offset(10);
        make.size.mas_offset(CGSizeMake(35, 35));
    }];
    
    [num mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(NameLabel.mas_bottom).offset(0);
        make.left.equalTo(headerImage.mas_right).offset(10);
        make.size.mas_offset(CGSizeMake(100, 20));

    }];
    
    [subBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(30);
        make.centerY.offset(0);
        make.right.offset(-20);
        make.size.mas_offset(CGSizeMake(60, 35));
    }];
    
 
}




@end
