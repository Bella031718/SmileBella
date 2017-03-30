//
//  XXPopularCell.m
//  SmileBella
//
//  Created by Bella on 17/1/19.
//  Copyright © 2017年 Bella. All rights reserved.
//

#import "XXPopularCell.h"
#import "UIView+Addition.h"

@implementation XXPopularCell



-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        //图片
        UIImageView *image = [[UIImageView alloc] init];
        [self.contentView addSubview:image];
        self.ImageView = image;
        //阴影图片
        UIImageView *shadeView = [[UIImageView alloc]init];
        shadeView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
        self.shadeView = shadeView;
        [image addSubview:self.shadeView];
        
        //标题
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.textColor = [UIColor whiteColor];
        titleLabel.font = [UIFont fontWithName:MyChinFont size:14.f];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:titleLabel];
        self.titleLabel = titleLabel;
        
        //描述
        UILabel *messageLabel = [[UILabel alloc] init];
        messageLabel.textColor = [UIColor whiteColor];
        messageLabel.font = [UIFont systemFontOfSize:12.f];
        messageLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:messageLabel];
        self.messageLabel = messageLabel;
        //角标
        UILabel *index = [[UILabel alloc] init];
        index.textColor = [UIColor whiteColor];
        //设置字体和字号
        index.font = [UIFont fontWithName:MyEnFontTwo size:12];
        index.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:index];
        self.indexLabel = index;
        
        UIButton *top = [[UIButton alloc]init];
        top.backgroundColor = [UIColor whiteColor];
        top.userInteractionEnabled = NO;
        [self.contentView addSubview:top];
        self.topLine = top;
        
        UIButton *bottom = [[UIButton alloc]init];
        bottom.backgroundColor = [UIColor whiteColor];
        bottom.userInteractionEnabled = NO;
        [self.contentView addSubview:bottom];
        self.bottomLine = bottom;
        
        
    }
    
    return self;
}


// 设置所有的子控件的frame
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.ImageView.frame = self.bounds;
    
    self.shadeView.frame = self.bounds;
    
    /** 标题 */
    self.titleLabel.frame = CGRectMake(5, self.bounds.size.height/2 - 10, self.bounds.size.width - 10, 20);
    
    /** 信息 */
    self.messageLabel.frame = CGRectMake(0, _titleLabel.bottom, _titleLabel.width, 25);
    
    self.topLine.frame = CGRectMake(kScreenWidth/2 - 15, _messageLabel.bottom + 20, 30, 0.5);
    
    self.indexLabel.frame = CGRectMake(kScreenWidth/2 - 30, _topLine.bottom + 5, 60, 15);
    
    self.bottomLine.frame = CGRectMake(kScreenWidth/2 - 15, _indexLabel.bottom + 3, 30, 0.5);
}




- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
