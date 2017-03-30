//
//  XXRecommmendCell.h
//  SmileBella
//
//  Created by Bella on 16/12/20.
//  Copyright © 2016年 Bella. All rights reserved.
//

#import <UIKit/UIKit.h>

@class XXRemmoendModel; //声明
@interface XXRecommmendCell : UITableViewCell

@property (nonatomic, strong)XXRemmoendModel *model;
//头像
@property(nonatomic,strong)UIImageView *headImage;
//名称
@property(nonatomic,strong)UILabel *nameLabel;
//人数
@property(nonatomic,strong)UILabel *numLabel;
//订阅按钮
@property(nonatomic,strong)UIButton *subscribeBtn;

@end
