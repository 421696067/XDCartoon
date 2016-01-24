//
//  FanZuCollectionCell.m
//  XD
//
//  Created by 李攀祥 on 16/1/11.
//  Copyright © 2016年 李攀祥. All rights reserved.
//

#import "FanZuCollectionCell.h"

#define nameColor [UIColor blackColor]//名字
#define onairEpColor  [UIColor grayColor] //更新至。。

#define BgTextViewHeight  50*View_Radio//底部背景的高度
@interface FanZuCollectionCell ()
@property (nonatomic,strong)UIImageView * iconImage;
@property (nonatomic,strong)UIView * bgView;//下部背景
@property (nonatomic,strong)UILabel * titleLabel;
@property (nonatomic,strong)UILabel * OnairEp;//更新至多少话

@end

@implementation FanZuCollectionCell
-(void)setModel:(fanzuFlModel *)model
{
    _model=model;
    [self.iconImage sd_setImageWithURL:[NSURL URLWithString:model.url]];
    self.titleLabel.text=model.name;
    self.OnairEp.text=[NSString stringWithFormat:@"更新至%@话",model.onairEpNumber];
}

- (void)awakeFromNib {
   
    self.backgroundColor=[UIColor blackColor];
    self.backgroundColor=[UIColor redColor];
    self.layer.masksToBounds=YES;
    self.layer.cornerRadius=5.0f;
    
    //设置圆角
    self.clipsToBounds=YES;
    [self creatUI];
    [self updateLayout];
}

-(void)creatUI
{
    [self addSubview:self.iconImage];
    [self addSubview:self.bgView];
    [self.bgView addSubview:self.titleLabel];
    [self.bgView addSubview:self.OnairEp];
}

-(void)updateLayout
{
   [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
       make.left.bottom.right.mas_equalTo(0);
       make.height.mas_equalTo(BgTextViewHeight);
   }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       make.top.right.mas_equalTo(0);
       make.left.mas_equalTo(10*View_Radio);
       make.height.equalTo(self.OnairEp);
    }];
    
    [self.OnairEp mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.height.equalTo(self.titleLabel);
        make.left.equalTo(self.titleLabel);
        make.top.mas_equalTo(self.titleLabel.mas_bottom).offset(0);
        make.bottom.mas_equalTo(0);
    }];
    
    [self.iconImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(0);
        make.bottom.mas_equalTo(self.bgView.mas_top).offset(0);
    }];
    
    
}
#pragma mark-懒加载
-(UIImageView *)iconImage
{
    if (!_iconImage)
    {
        _iconImage=[[UIImageView alloc] init];
    }
    return _iconImage;
}


-(UIView *)bgView
{
    if (!_bgView)
    {
        _bgView=[[UIView alloc] init];
        _bgView.backgroundColor=[UIColor whiteColor];
    }
    return _bgView;
}

-(UILabel *)titleLabel
{
    if (!_titleLabel)
    {
        _titleLabel=[[UILabel alloc] init];
        _titleLabel.textColor=nameColor;
        _titleLabel.font=Font(12*View_Radio);
        _titleLabel.textAlignment=NSTextAlignmentLeft;
    }
    return _titleLabel;
}
-(UILabel *)OnairEp
{
    if (!_OnairEp)
    {
        _OnairEp=[[UILabel    alloc] init];
        _OnairEp.textColor=onairEpColor;
        _OnairEp.font=Font(10*View_Radio);
        _OnairEp.textAlignment=NSTextAlignmentLeft;
    }
    return _OnairEp;
}


@end
