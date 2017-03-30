//
//  XXAllCell.h
//  SmileBella
//
//  Created by Bella on 17/1/3.
//  Copyright © 2017年 Bella. All rights reserved.
//

#import <UIKit/UIKit.h>

@class XXAllModel;
@interface XXAllCell : UITableViewCell
@property (nonatomic, strong)XXAllModel *model;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UIImageView *iconImage;
@property (nonatomic, strong) UIButton *moreBtn;

@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, strong) UIButton *dingBtn;
@property (nonatomic, strong) UIButton *caiBtn;
@property (nonatomic, strong) UIButton *sharBtn;
@property (nonatomic, strong) UIButton *pingBtn;


@end
