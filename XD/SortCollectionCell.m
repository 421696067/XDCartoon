
//
//  SortCollectionCell.m
//  XD
//
//  Created by 李攀祥 on 16/1/19.
//  Copyright © 2016年 李攀祥. All rights reserved.
//

#import "SortCollectionCell.h"
#import "SortModel.h"
@interface SortCollectionCell ()
@property (weak, nonatomic) IBOutlet UIImageView *iconImage;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *iconHeightConstains;

@end
@implementation SortCollectionCell
-(void)setModel:(SortModel *)model
{
    _model=model;
    [self.iconImage sd_setImageWithURL:[NSURL URLWithString:model.url]];
    self.titleLabel.text=model.name;
}

- (void)awakeFromNib {
    self.iconHeightConstains.constant*=View_Radio;
    self.titleLabel.font=Font(14*View_Radio);
    self.iconImage.layer.masksToBounds=YES;
    self.iconImage.layer.cornerRadius=5.0f;
    self.titleLabel.textColor=[UIColor whiteColor];
}

@end
