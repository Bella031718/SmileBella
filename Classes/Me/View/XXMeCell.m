//
//  XXMeCell.m
//  SmileBella
//
//  Created by Bella on 16/12/22.
//  Copyright © 2016年 Bella. All rights reserved.
//

#import "XXMeCell.h"
#import <UIImageView+WebCache.h>
#import "XXMeModel.h"

@interface XXMeCell ()
@property (weak, nonatomic) IBOutlet UIImageView *iconImage;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@end


@implementation XXMeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setModel:(XXMeModel *)model{
    _model = model;
    [_iconImage sd_setImageWithURL:[NSURL URLWithString:model.icon]];
    _nameLabel.text = model.name;
    
}

@end
