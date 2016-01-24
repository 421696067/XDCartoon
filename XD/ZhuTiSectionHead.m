//
//  ZhuTiSectionHead.m
//  XD
//
//  Created by 李攀祥 on 16/1/19.
//  Copyright © 2016年 李攀祥. All rights reserved.
//

#import "ZhuTiSectionHead.h"
#import "ZhuTiModel.h"
@interface ZhuTiSectionHead ()
@property(nonatomic,strong)UIButton * topButton;
@property (nonatomic,strong)UILabel * mainTitle;
@property (nonatomic,strong)UILabel * secondTitle;
@property (nonatomic,strong)UILabel * rightLabel ;
@property (nonatomic,strong)UIImageView * rightImage;

@property (nonatomic,strong)UIView * backView;  //设置背景颜色
@property (nonatomic,strong)UIView * line;//底部的一根线
@end
@implementation ZhuTiSectionHead

-(void)setModel:(ZhuTiZu *)model
{
    _model=model;
    self.mainTitle.text=model.title;
    self.secondTitle.text=model.intro;
    self.rightLabel.text=[NSString stringWithFormat:@"共%@部",model.anime];
}

-(id)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame])
    {
        [self addSubview:self.backView];
        
        [self  addSubview:self.mainTitle];
        [self  addSubview:self.secondTitle];
        [self  addSubview:self.rightLabel];
        [self  addSubview:self.rightImage];
        [self  addSubview:self.line];
        [self  addSubview:self.topButton];

        [self creatLayout];
    }
    return self;
}
-(void)creatLayout
{
    [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.mas_equalTo(0);
    }];
    
    [self.mainTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(4*View_Radio);
        make.left.mas_equalTo(5*View_Radio);
    }];
    
    [self.secondTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mainTitle.mas_bottom).offset(3*View_Radio);
        make.left.mas_equalTo(5*View_Radio);
        make.right.mas_equalTo(self.rightLabel.mas_left).offset(10*View_Radio);
    }];
    
    [self.rightImage  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self. mas_centerY);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(5*View_Radio);
        make.width.mas_equalTo(40*View_Radio);
    }];
    
    [self.rightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.mas_centerY);
        make.right.mas_equalTo(self.rightImage.mas_left).offset(-1*View_Radio);
        make.height.mas_equalTo(40*View_Radio);
    }];
    
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.secondTitle.mas_bottom).offset(5*View_Radio);
        make.height.mas_equalTo(1*View_Radio);
        make.left.mas_equalTo(5*View_Radio);
        make.right.mas_equalTo(-5*View_Radio);
    }];
    
    [self.topButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.left.right.mas_equalTo(0);
    }];
}
#pragma mark-懒加载
-(UILabel *)mainTitle
{
    if (!_mainTitle)
    {
        _mainTitle=[UILabel new];
        _mainTitle.textColor=[UIColor colorWithHexString:@"FD6F35"];
        _mainTitle.font=Font(15*View_Radio);
        _mainTitle.textAlignment=NSTextAlignmentLeft;
    }
    return _mainTitle;
}

-(UILabel *)secondTitle
{
    if (!_secondTitle)
    {
        _secondTitle=[UILabel new];
        _secondTitle.textColor=[UIColor colorWithHexString:@"FFFFFF"];
        _secondTitle.font=Font(13*View_Radio);
        _secondTitle.textAlignment=NSTextAlignmentLeft;
    }
    return _secondTitle;
}

-(UILabel *)rightLabel
{
    if (!_rightLabel)
    {
        _rightLabel=[UILabel new];
        _rightLabel.textAlignment=NSTextAlignmentRight  ;
        _rightLabel.font=Font(13*View_Radio);
        _rightLabel.textColor=[UIColor whiteColor];
    }
    return _rightLabel;
}
-(UIImageView*)rightImage
{
    if (!_rightImage)
    {
      _rightImage=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"qianjinBlack"]];
    }
    return _rightImage;
}
-(UIView *)line
{
    if (!_line)
    {
        _line=[[UIView alloc] init];
        _line.backgroundColor=[UIColor colorWithHexString:@"D4D4D4"];
    }
    return _line;
}
-(UIView *)backView
{
    if (!_backView)
    {
        _backView=[[UIView alloc] init];
        _backView.backgroundColor=[UIColor whiteColor];
        _backView.alpha=0.4;
    }
    return _backView;
}
-(UIButton *)topButton
{
    if (!_topButton)
    {
        _topButton=[UIButton buttonWithType:UIButtonTypeCustom];
        [_topButton addTarget:self action:@selector(butClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _topButton;
}
#pragma mark-点击事件
-(void)butClick
{
    self.block(self.model);
}

@end
