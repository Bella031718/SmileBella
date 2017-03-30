//
//  XXCircleCell.m
//  SmileBella
//
//  Created by Bella on 17/3/20.
//  Copyright © 2017年 Bella. All rights reserved.
//

#import "XXCircleCell.h"
#import <Masonry.h>

@interface XXCircleCell ()



@end


@implementation XXCircleCell

-(instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        UIImageView *liveImage = [UIImageView new];
        liveImage.image = [UIImage imageNamed:@"Img_default"];
        self.liveImage = liveImage;
        [self.contentView addSubview:liveImage];
        
        UIView *aphaView = [UIView new];
        aphaView.backgroundColor = [UIColor blackColor];
        aphaView.alpha = 0.5;
        [liveImage addSubview:aphaView];
        
        
        UILabel *introduceLabel = [UILabel new];
        introduceLabel.text =@"直播可翠花钓鱼";
        introduceLabel.font = [UIFont systemFontOfSize:12];
        introduceLabel.textAlignment = NSTextAlignmentLeft;
        introduceLabel.textColor = [UIColor greenColor];
        self.introduceLable = introduceLabel;
        [liveImage addSubview:introduceLabel];
        
        UILabel *nameLabel = [UILabel new];
        nameLabel.text = @"可翠花";
        nameLabel.font = [UIFont systemFontOfSize:12];
        nameLabel.textAlignment = NSTextAlignmentLeft;
        nameLabel.textColor = [UIColor grayColor];
        self.nameLabel = nameLabel;
        [self.contentView addSubview:nameLabel];
        
        UILabel *peopleNum = [UILabel new];
        peopleNum.text = @"12121";
        peopleNum.font = [UIFont systemFontOfSize:12];
        peopleNum.textAlignment = NSTextAlignmentLeft;
        peopleNum.textColor = [UIColor grayColor];
        self.personNum = peopleNum;
        [self.contentView addSubview:peopleNum];
        self.contentView.backgroundColor = [UIColor yellowColor];
        
        [liveImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.equalTo(self.contentView).offset(0);
            make.bottom.equalTo(self.contentView).offset(-20);
            
        }];
        [aphaView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(liveImage).offset(0);
            make.height.offset(20);
        }];
        [introduceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(aphaView.mas_top);
            make.left.equalTo(aphaView.mas_left);
            make.right.equalTo(aphaView.mas_right);
            make.bottom.equalTo(aphaView.mas_bottom);
        }];
        [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView.mas_left);
            //        make.right.equalTo(peopleNum.mas_left).offset(0);
            make.bottom.equalTo(self.contentView.mas_bottom);
        }];
        [peopleNum mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.contentView.mas_right);
            make.bottom.equalTo(self.contentView.mas_bottom);
        }];
        
        
    }
    return self;
}


















@end
