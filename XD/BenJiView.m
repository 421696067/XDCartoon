//
//  BenJiView.m
//  XD
//
//  Created by 李攀祥 on 16/1/9.
//  Copyright © 2016年 李攀祥. All rights reserved.

#import "BenJiView.h"
#define  nameLabelColor [UIColor blackColor]//底部名字的文字颜色
#define  titleColor    [UIColor whiteColor]//更新至、、的文字颜色
#define  titleBgColor  [UIColor blackColor]//更新至、、的背景view颜色

//总高度是 130*View_Radio
#define iconHeight  100*View_Radio
#define titleHeight 20*View_Radio
#define SpaceHeight 5*View_Radio
#define nameLabel   25*View_Radio

@interface BenJiView ()

@property(nonatomic,strong)UIView * BgView;
@property(nonatomic,strong)UIButton * button;
@property (nonatomic,strong)UILabel * titleLabel;
@property (nonatomic,strong)UIView * titleBg ;


@property (nonatomic,strong)UILabel * namaLabel;

//储存传过来的 model
@property (nonatomic,strong)tuijianBJModel* model;

@end
@implementation BenJiView


-(id)initWithFrame:(CGRect)frame  Model:(tuijianBJModel *)model
{
    if (self=[super initWithFrame:frame]) {
        self.model=model;
        //添加视图
        [self creatUI];
        //更新约束
        [self updatLayout];
        [self updataData];
    }
    return self;
}

#pragma mark-添加视图
-(void)creatUI
{
    [self addSubview:self.BgView];
    [self.BgView addSubview:self.button];
    [self.BgView addSubview:self.titleBg];
    [self.BgView addSubview:self.titleLabel];

    [self addSubview:self.namaLabel];
}

#pragma mark-更新数据赋值model
-(void)updataData
{
    self.namaLabel.text=self.model.name;
    self.titleLabel.text=[NSString stringWithFormat:@"更新至第%@话",self.model.onairEpNumber];
    [self.button sd_setBackgroundImageWithURL:[NSURL URLWithString:self.model.url] forState:UIControlStateNormal];
}

#pragma mark-更新约束
-(void)updatLayout
{
    
    [self.BgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(0);
        make.height.mas_equalTo(iconHeight);
    }];
    
    [self.button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.mas_equalTo(0);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(0);
        make.height.mas_equalTo(titleHeight);
    }];
    
    [self.titleBg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.right.left.top.equalTo(self.titleLabel);
    }];
    
    [self.namaLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.button.mas_bottom).offset(0);
        make.left.bottom.right.mas_equalTo(0);
    }];
}

static NSInteger a=320;
#pragma mark-懒加载
-(UIView *)BgView
{
    if (!_BgView)
    {
        _BgView=[[UIView alloc] init];
        _BgView.layer.masksToBounds=YES;
        _BgView.layer.cornerRadius=5.0f;
        _BgView.clipsToBounds=YES;
    }
    return _BgView;
}
-(UIButton  *)button
{
    if (!_button)
    {
        _button =[UIButton buttonWithType:UIButtonTypeCustom];
        _button.layer.masksToBounds=YES;
        //_button.backgroundColor  =[UIColor redColor];
        _button.layer.cornerRadius =6*View_Radio;
        _button.tag = a++;
        [_button addTarget:self action:@selector(butClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _button;
}

-(UILabel *)namaLabel
{
    if (!_namaLabel)
    {
        _namaLabel=[[UILabel alloc] init];
        _namaLabel.textColor=nameLabelColor;
        _namaLabel.font=Font(12*View_Radio);
        _namaLabel.textAlignment=NSTextAlignmentCenter;
    }
    return _namaLabel;
}
-(UIView *)titleBg
{
    if (!_titleBg)
    {
        _titleBg=[[UIView alloc] init];
        _titleBg.backgroundColor = titleBgColor;
        _titleBg.alpha=0.4;
    }
    return _titleBg;
}
-(UILabel *)titleLabel
{
    if (!_titleLabel)
    {
        _titleLabel=[[UILabel alloc] init];
        _titleLabel.textColor=titleColor;
        _titleLabel.textAlignment=NSTextAlignmentCenter  ;
        _titleLabel.font=Font(10*View_Radio);
    }
    return _titleLabel;
}

//按钮的回调
-(void)butClick
{
    self.butBlock(self.model._id);
}
@end
