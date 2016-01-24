//
//  FanzuheadView.m
//  XD
//
//  Created by 李攀祥 on 16/1/11.
//  Copyright © 2016年 李攀祥. All rights reserved.
//

#import "FanzuheadView.h"
#import "CycleScrollView.h"
#import "TuiJianModel.h"

#define AllHeight  AdHeight+SpaceBut+HeightBut//100+10+40+35

#define AdTime  2.0f//循环时间
#define AdHeight 100 * View_Radio//广告业高度

#define SpaceBut 10*View_Radio//按钮之间的空白
#define HeightBut 40*View_Radio//按钮的高度

@interface FanzuheadView ()<CycleScrollViewDelegate>
{
    NSMutableArray * _admArr;//广告业数据源
}
@property(nonatomic,strong)CycleScrollView *adSC;
@property (nonatomic,strong)UIButton * fenlei;//分类按钮
@property (nonatomic,strong)UIButton * timeBut;//时间表按钮

@property(nonatomic,strong)UIImageView * iconImage;//全部新番
@property (nonatomic,strong)UILabel * titleName;//全部新番(这四个字)
@end

@implementation FanzuheadView
-(id)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame])
    {
        _admArr=[[NSMutableArray alloc] init];
        //添加视图
        [self creatUI];
        //更新约束
        [self creatLayout];
        //更新数据
        [self loadData];
    }
    return self;
}

-(void)creatUI
{
    [self addSubview:self.adSC];
    [self addSubview:self.fenlei];
    [self addSubview:self.timeBut];
    [self addSubview:self.iconImage];
    [self addSubview:self.titleName];
}

-(void)creatLayout
{
  [self.fenlei mas_makeConstraints:^(MASConstraintMaker *make) {
      make.left.mas_equalTo(SpaceBut);
      make.top.mas_equalTo(self.adSC.mas_bottom).offset(SpaceBut);
      make.height.mas_equalTo(HeightBut);
      make.right.mas_equalTo(self.timeBut.mas_left).offset(-SpaceBut);
  }];
    
    [self.timeBut mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.fenlei);
        make.right.mas_equalTo(-SpaceBut);
        make.width.height.equalTo(self.fenlei);
    }];
    
    
    [self.iconImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.timeBut.mas_bottom).offset(5*View_Radio);
        make.left.mas_equalTo(10*View_Radio);
        make.height.mas_equalTo(30*View_Radio);
        make.width.mas_equalTo(30*View_Radio);
    }];
    
    [self.titleName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.iconImage.mas_centerY);
        make.left.mas_equalTo(self.iconImage.mas_right).offset(5*View_Radio);
        make.height.mas_equalTo(25*View_Radio);
    }];


}

-(void)loadData
{
    NSMutableArray * imageArr=[[NSMutableArray alloc] init];
    [HYBNetworking getWithUrl:TuiJianAD success:^(id response) {
        NSLog(@"番组-广告页 success");
        _admArr = [[FanZuAdManger arrWithDict:response] mutableCopy];
        for (int i=0; i<_admArr.count; i++) {
            TuiJianADModel * model=_admArr[i];
            [imageArr addObject:model.imageUrl];
        }
        self.adSC.imageURLStringsGroup = imageArr;
    } fail:^(NSError *error) {
        NSLog(@"推荐广告业请求失败%@",error);
    }];
    
}


#pragma mark-懒加载
-(CycleScrollView *)adSC
{
    if (!_adSC)
    {
        _adSC=[[CycleScrollView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, AdHeight)];
        _adSC.autoScrollTimeInterval =AdTime;
        _adSC.pageControlStyle=CycleScrollViewPageContolStyleAnimated;
        _adSC.pageControlAliment=CycleScrollViewPageContolAlimentCenter;
        _adSC.delegate=self;
    }
    return _adSC;
}
-(UIButton *)fenlei
{
    if (!_fenlei)
    {
        _fenlei=[UIButton buttonWithType:UIButtonTypeCustom];
        [_fenlei setBackgroundImage:imageRender(@"fanzuFl") forState:UIControlStateNormal];
        [_fenlei addTarget:self action:@selector(leftClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _fenlei;
}
-(UIButton *)timeBut
{
    if (!_timeBut)
    {
        _timeBut=[UIButton buttonWithType:UIButtonTypeCustom];
        [_timeBut setBackgroundImage:imageRender(@"timebiao") forState:UIControlStateNormal];
        [_timeBut addTarget:self action:@selector(rightClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _timeBut;
}
-(UIImageView *)iconImage
{
    if (!_iconImage)
    {
        _iconImage=[[UIImageView alloc] init];
        _iconImage.image=imageRender(@"tuijian_bj");
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
        _titleName.text=@"全部新番";
    }
    return _titleName;
}


-(void)leftClick
{
    self.fenLeiButBlock();
}
-(void)rightClick
{
    self.xfTimeBlock();
}



#pragma mark-广告页 的点击事件
- (void)cycleScrollView:(CycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index;
{
    TuiJianADModel * model=_admArr[index];
    NSString *subStr= [model.url substringFromIndex:16];
    //NSLog(@"%@",[NSString stringWithFormat:Detail,subStr]);
    if([model.url rangeOfString:@"http"].location !=NSNotFound)
    {
        self.block(model.url,@"1");//点击的是网页
    }
    else
    {
        self.block(subStr,@"2");//点击的是动画
    }
}




@end
