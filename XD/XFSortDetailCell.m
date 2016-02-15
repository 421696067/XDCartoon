//
//  SumSortCell.m
//  XD
//
//  Created by 李攀祥 on 16/1/20.
//  Copyright © 2016年 李攀祥. All rights reserved.
//

#import "XFSortDetailCell.h"
#import "AnimaDetailModel.h"
#import "StarView.h"
#import "NoAdressView.h"
@interface XFSortDetailCell ()
/*!
 * 通过cellID 排列布局  代表有地下的intro的详细介绍
 *
 *  这里可以用枚举来代替
 */
@property(nonatomic,assign)UITableViewCellStyle  style;
@property(nonatomic,strong)UIImageView * iconImage;
@property (nonatomic,strong)UILabel * nameLabel;
@property (nonatomic,strong)UILabel * type;
@property (nonatomic,strong)UILabel * EpCount;
@property (nonatomic,strong)StarView * star;
@property (nonatomic,strong)UILabel * intro;
@property (nonatomic,strong)UIView * containView ;//包含所有控件的视图
@property (nonatomic,strong)UIView * backView ;//设置颜色
@property (nonatomic,strong)NoAdressView * topView;//是否有 播放源
@end

@implementation XFSortDetailCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        self.style  = style;
        self.backgroundColor=[UIColor clearColor];
        self.selectionStyle=UITableViewCellSelectionStyleNone;
        //TODO: 一下的 全都是错的~~求破
        //设置最下面的视图
        //if([reuseIdentifier  isEqualToString:@"SumSortCell"])
        //!!!: 这里不能利用reuseIdentifier 进行判断  也不能利用重写这个系统方法传值来判断那样的话~~系统不会调用的
        /*!
         * 因为reuseIdentifier 有的时候有  有的时候没有   因为要通过这个去取
         *   这里最好是通过 style去 同一个cell  可以选择不同的样式
         *   这里  UITableViewCellStyleDefault
         有底部的详细介绍的cell样式
         *   UITableViewCellStyleValue1 没有底部intro的cell
         */
        //添加视图
        [self addView];
        //添加约束
        [self addAutoLayout];
        
        
        
        self.hyb_lastViewInCell = self.iconImage;
        self.hyb_bottomOffsetToCell = 2*View_Radio+15*View_Radio;
      }
    return self;
}

-(void)addView
{
    [self.contentView addSubview:self.backView];
    [self.contentView addSubview:self.containView];
    
    [self.containView addSubview:self.iconImage];
    [self.containView addSubview:self.topView];
    
    [self.containView addSubview:self.nameLabel];
    [self.containView addSubview:self.type];
    [self.containView addSubview:self.EpCount];
    [self.containView addSubview:self.star];
}

-(void)addAutoLayout
{
    [self.containView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(10*View_Radio);
        make.left.mas_equalTo(10*View_Radio);
        make.right.mas_equalTo(-10*View_Radio);
        make.bottom.mas_equalTo(-5*View_Radio);
    }];
    
    [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(self.containView);
    }];
//    
    [self.iconImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10*View_Radio);
        make.top.mas_equalTo(7*View_Radio);
        make.width.mas_equalTo(60*View_Radio);
        make.height.mas_equalTo(75*View_Radio);
    }];
    
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10*View_Radio);
        make.top.mas_equalTo(7*View_Radio);
        make.width.mas_equalTo(60*View_Radio);
        make.height.mas_equalTo(75*View_Radio);
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(7*View_Radio);
        make.left.mas_equalTo(self.iconImage.mas_right).offset(7*View_Radio);
        make.right.mas_equalTo(-2*View_Radio);
    }];
    
    [self.type mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nameLabel);
        make.right.mas_equalTo(-2*View_Radio);
        make.top.mas_equalTo(self.nameLabel.mas_bottom).offset(2*View_Radio);
    }];
    [self.EpCount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nameLabel);
        make.top.mas_equalTo(self.type.mas_bottom).offset(2*View_Radio);
        make.right.mas_equalTo(-2*View_Radio);
    }];
    
    [self.star mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nameLabel);
        make.top.mas_equalTo(self.EpCount.mas_bottom).offset(2*View_Radio);
        make.width.mas_equalTo(70*View_Radio);
        make.height.mas_equalTo(25*View_Radio);
    }];
}

- (void)awakeFromNib {
    
}
#pragma mark-懒加载
-(UIImageView *)iconImage{
    if (!_iconImage) {
        _iconImage=[Factory creatImageViewRadius:5*View_Radio];
    }
    return _iconImage;
}

//TODO: 自定制view  init方法里 加载xib
-(NoAdressView *)topView
{
    if (!_topView) {
        _topView = [[NoAdressView alloc] init];
        _topView.layer.masksToBounds=YES;
        _topView.layer.cornerRadius=5.0f;
    }
    return _topView;
}

-(UILabel *)nameLabel
{
    if (!_nameLabel) {
        _nameLabel=[Factory creatLabelFont:15*View_Radio Alignment:NSTextAlignmentLeft textColor:[UIColor orangeColor] bgColor:[UIColor clearColor] autoLine:NO];
    }
    return _nameLabel;
}
-(UILabel *)type
{
    if (!_type) {
        _type = [Factory creatLabelFont:13*View_Radio Alignment:NSTextAlignmentLeft textColor:[UIColor whiteColor] bgColor:[UIColor clearColor] autoLine:NO];
    }
    return _type;
}
-(UILabel *)EpCount
{
    if (!_EpCount) {
        _EpCount=[Factory creatLabelFont:13*View_Radio Alignment:NSTextAlignmentLeft textColor:[UIColor whiteColor] bgColor:[UIColor clearColor] autoLine:NO];
    }
    return _EpCount;
}

-(StarView *)star
{
    if (!_star)
    {
        _star=[[StarView alloc] init];
    }
    return _star;
}

-(UIView *)backView
{
    if (!_backView) {
        _backView=[[UIView alloc] init];
        
        _backView.backgroundColor=[UIColor colorWithHexString:@"D4D4D4"];
        _backView.alpha=0.5;
    }
    return _backView;
}

-(UIView *)containView
{
    if (!_containView) {
        _containView=[[UIView alloc] init];
        _containView.backgroundColor    =[UIColor clearColor];
    }
    return _containView;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

#pragma mark-配置数据
- (void)configCellWithModel:(AnimaDetailModel *)model
{
    [self.iconImage sd_setImageWithURL:[NSURL URLWithString:model.url]];
    self.nameLabel.text=model.name;
    self.type.text=[model.categoryNames  componentsJoinedByString:@"/"];
    /*!
     * 优化 c=表达式? 正确的结果:错误的结果
     */
    self.EpCount.text = [model.onairEpNumber isEqualToString:model.totalEpCount]?[NSString stringWithFormat:@"%@话全",model.totalEpCount]:[NSString stringWithFormat:@"更新至%@话",model.onairEpNumber];
    if ([model.score isEqualToString:@"0"])
    {   [self.star setStar:[model.score floatValue]/2];
        [self.star removeFromSuperview];
    }
    else
    {
        [self.star setStar:[model.score floatValue]/2];
    }
    
    if ([model.onairEpNumber intValue] !=0)
    {
        [self.topView removeFromSuperview];
    }
    else
    {
    
    }
    
}
@end
