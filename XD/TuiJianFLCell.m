//
//  TuiJianFLCell.m
//  XD
//
//  Created by 李攀祥 on 16/1/10.
//  Copyright © 2016年 李攀祥. All rights reserved.
//

#import "TuiJianFLCell.h"
//每个cell的高度
#define CellWidth  (Screen_Width-30*View_Radio)/2
#define CellHeight   150*View_Radio
#define IconImageHeight  110*View_Radio

@interface TuiJianFLCell ()

@property (nonatomic,strong)UIImageView * iconImage;
//评论数视图
@property (nonatomic,strong)UIView *commentBgView ;
@property (nonatomic,strong)UIImageView * commentImage;
@property (nonatomic,strong)UILabel * commentNumber;
//下面名字的详情
@property (nonatomic,strong)UILabel * nameLabel;

@end

@implementation TuiJianFLCell
-(void)setModel:(EverOne *)model
{
    _model=model;
    [self.iconImage sd_setImageWithURL:[NSURL URLWithString:model.url]];
    self.commentNumber.text =model.playCount;
    self.nameLabel.text=model.title;
}

- (void)awakeFromNib {
    self.backgroundColor=[UIColor redColor];
    self.layer.masksToBounds=YES;
    self.layer.cornerRadius=5.0f;
    //设置圆角
    self.clipsToBounds=YES;
    [self creatUI];
    [self updateLayout];
}
#pragma mark-添加视图
-(void)creatUI
{   [self.contentView addSubview:self.iconImage];
    [self.contentView addSubview:self.commentBgView];
    [self.contentView addSubview:self.commentImage];
    [self.contentView addSubview:self.commentNumber];
    [self.contentView addSubview:self.nameLabel];
}

-(void)updateLayout
{
    [self.iconImage mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.right.top.mas_equalTo(0);
    make.height.mas_equalTo(IconImageHeight);
    }];
    
    [self.commentBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-5*View_Radio);
        make.bottom.mas_equalTo(self.iconImage.mas_bottom).offset(-10*View_Radio);
        make.width.mas_equalTo(60*View_Radio);
        make.height.mas_equalTo(20*View_Radio);
    }];
    
    [self.commentImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self.commentBgView);
        make.width.height.mas_equalTo(20*View_Radio);
    }];
    
    
    [self.commentNumber mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.bottom.top.equalTo(self.commentBgView);
        make.left.mas_equalTo(self.commentImage.mas_right).offset(0);
    }];
    
   [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(0);
        make.height.mas_equalTo(CellHeight-IconImageHeight);
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

-(UIView *)commentBgView
{
    if (!_commentBgView)
    {
        _commentBgView=[[UIView alloc] init];
        _commentBgView.backgroundColor=[UIColor blackColor];
        _commentBgView .alpha=0.5;
    }
    return _commentBgView;
}
-(UIImageView *)commentImage
{
    if (!_commentImage)
    {
        _commentImage=[[UIImageView alloc] init];
        _commentImage.image=imageRender(@"play");
    }
    return _commentImage;
}

-(UILabel *)commentNumber
{
    if (!_commentNumber) {
        _commentNumber=[[UILabel alloc] init];
        _commentNumber.font=Font(10*View_Radio);
        _commentNumber.textColor=[UIColor whiteColor];
        _commentNumber.textAlignment=NSTextAlignmentCenter;
    }
    return _commentNumber;
}

-(UILabel *)nameLabel
{
    if (!_nameLabel)
    {
        _nameLabel=[[UILabel alloc] init];
        _nameLabel.textColor=[UIColor blackColor];
        _nameLabel.numberOfLines=0;
        _nameLabel.font=Font(12*View_Radio);
        _nameLabel.backgroundColor=[UIColor whiteColor];
        _nameLabel.textAlignment=NSTextAlignmentCenter;
    }
    return _nameLabel;
}


-(void)butClick
{

    
}
@end
