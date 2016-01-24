//
//  TuiJianFLHead.m
//  XD
//
//  Created by 李攀祥 on 16/1/10.
//  Copyright © 2016年 李攀祥. All rights reserved.
//

#import "TuiJianFLHead.h"
@interface TuiJianFLHead ()
@property(nonatomic,strong)UIImageView * iconImage;
@property (nonatomic,strong)UILabel * titleName;
@end
@implementation TuiJianFLHead

-(void)setModel:(EverZu *)model
{
    _model=model;
    [self.iconImage sd_setImageWithURL:[NSURL URLWithString:model.icon]];
    self.titleName.text=model.name;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.iconImage];
        [self addSubview:self.titleName];
        [self crearLayout];
    }
    return self;
}

-(void)crearLayout
{
    [self.iconImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.mas_centerY);
        make.left.mas_equalTo(10*View_Radio);
        make.height.mas_equalTo(28*View_Radio);
        make.width.mas_equalTo(40*View_Radio);
    }];
    
    [self.titleName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.mas_centerY);
        make.left.mas_equalTo(self.iconImage.mas_right).offset(5*View_Radio);
        make.height.mas_equalTo(25*View_Radio);
    }];
}
- (void)awakeFromNib {

}
-(UIImageView *)iconImage
{
    if (!_iconImage)
    {
        _iconImage=[[UIImageView alloc] init];
    }
    return _iconImage;
}
-(UILabel *)titleName
{
    if (!_titleName) {
        _titleName=[[UILabel alloc] init];
        _titleName.textColor=[UIColor blackColor];
        _titleName.font=Font(15*View_Radio);
        _titleName.textAlignment=NSTextAlignmentLeft;
    }
    return _titleName;
}
@end
