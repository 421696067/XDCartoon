//
//  ZhuYeCell.m
//  XD
//  Created by 李攀祥 on 16/1/7.
//  Copyright © 2016年 李攀祥. All rights reserved.

#import "ZhuYeCell.h"
#import "ZhuYeModel.h"
@implementation ZhuYeCell

- (void)awakeFromNib {
    
    //设置背景颜色
    self.backgroundColor=[UIColor clearColor];
    //设置cell的选中样式
    self.selectionStyle=UITableViewCellSelectionStyleNone;
    
    [self.contentView addSubview:self.lefImage];
    [self.contentView addSubview:self.rightImage];
    [self.contentView addSubview:self.label];
    
    [self.lefImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(5*View_Radio);
        make.left.mas_equalTo(10*View_Radio);
        make.width.height.mas_equalTo(40*View_Radio);
    }];
    
    [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.lefImage.mas_right).offset(10*View_Radio);
        make.top.mas_equalTo(10*View_Radio);
        make.bottom.mas_equalTo(-10*View_Radio);
    }];
    
    [self.rightImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
        make.right.mas_equalTo(10*View_Radio);
        make.height.width.mas_equalTo(40*View_Radio);
    }];
    
 
}
#pragma mark-懒加载
-(UIImageView *)lefImage
{
    if (!_lefImage)
    {
        _lefImage=[[UIImageView alloc] init];
    }
    return _lefImage;
}

-(UIImageView *)rightImage
{
    if (!_rightImage)
    {
        _rightImage=[[UIImageView alloc] init];
    }
    return _rightImage;
}

-(UILabel *)label
{
    if (!_label)
    {
        _label=[[UILabel alloc] init];
        _label.textColor=[UIColor whiteColor];
        _label.font=Font(14*View_Radio);
        _label.textAlignment=NSTextAlignmentLeft;
    }
    return _label;
}


- (void)configCellWithEntity:(id)entity
{
    if (entity)
    {
        ZhuYeModel * model=entity;
        self.lefImage.image=[UIImage imageNamed:model.iconImage];
        self.rightImage.image=[UIImage imageNamed:@"qianjin"];
        self.label.text=model.name;
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated{
    [super setSelected:selected animated:animated];
}

@end
