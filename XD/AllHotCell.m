//
//  AllHotCell.m
//  XD
//
//  Created by 李攀祥 on 16/1/13.
//  Copyright © 2016年 李攀祥. All rights reserved.
//

#import "AllHotCell.h"
#import "AllHotModel.h"
@implementation AllHotCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)configCellWithEntity:(id)entity
{
    if (entity)
    {
        MADDetailModel * model=entity;
        [self.icon sd_setImageWithURL:[NSURL URLWithString:model.url]];
    }
}
@end
