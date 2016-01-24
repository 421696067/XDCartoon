//
//  FenQvCell.m
//  XD
//
//  Created by 李攀祥 on 16/1/12.
//  Copyright © 2016年 李攀祥. All rights reserved.
//

#import "FenQvCell.h"
@interface FenQvCell()
@property(nonatomic,strong)UIImageView * icon;
@property (nonatomic,strong)UILabel * label;
@property (nonatomic,strong) UIView * bgView;
@end


@implementation FenQvCell
-(void)setModel:(FenQvOne *)model
{
    _model=model;
    [self.icon sd_setImageWithURL:[NSURL URLWithString:model.icon]];
    self.label.text=model.name;
}

- (void)awakeFromNib {
    self.layer.borderWidth=0.5*View_Radio;
    //设置边框颜色
    self.layer.borderColor=[[UIColor colorWithHexString:@"D4D4D4"] CGColor];
    [self.contentView addSubview:self.bgView];
    [self.contentView addSubview:self.icon];
    [self.contentView addSubview:self.label];
    [self creatLayout];
}

-(void)creatLayout
{
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.top.right.mas_equalTo(0);
    }];
    [self.icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.mas_centerX).offset(0);
        make.top.mas_equalTo(10*View_Radio);
        make.width.height.mas_equalTo(35*View_Radio);
    }];
    
    [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.mas_centerX).offset(0);
        make.top.mas_equalTo(self.icon.mas_bottom).offset(5*View_Radio);
        //TODO: 如果这一句加上去的话  就会报错说什么 修改静态约束什么的
         //make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(20*View_Radio);
    }];
    
}
-(UILabel *)label
{
    if (!_label)
    {
        _label=[[UILabel  alloc] init];
        _label.textAlignment=NSTextAlignmentCenter;
        _label.textColor=[UIColor blackColor];
        _label.font=Font(14*View_Radio);
    }
    return _label;
}

-(UIImageView *)icon
{
    if (!_icon)
    {
        _icon=[[UIImageView alloc] init];
    }
    return _icon;
}

-(UIView *)bgView
{
    if (!_bgView) {
        _bgView =[[UIView alloc] init];
        _bgView.backgroundColor=[UIColor whiteColor ];
        _bgView.alpha=0.5;
    }
    return _bgView;
}

@end
