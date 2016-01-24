//
//  SegementView.m
//  XD
//
//  Created by 李攀祥 on 16/1/7.
//  Copyright © 2016年 李攀祥. All rights reserved.

#import "SegementView.h"
//按钮的宽高
#define ButWidth 70*View_Radio
#define ButHeight 40.0f
//底部滑块的宽高 空白（距离左边）距离
#define SpaceSlider 5*View_Radio
#define SliderWidth ButWidth-2*SpaceSlider
#define SliderHeight 2
//分割线的空白距离（距离上边） 和分割线的宽高
#define SpaceLineTop  5.0f
#define LineHeiht   30.0f
#define LineWidth   1.0f* View_Radio
//TODO:按钮的颜色、底部滑块、分割线的颜色需要改变
#define ButSelectColor  [UIColor colorWithHexString:@"FB4209"]
#define ButNormalColor  [UIColor colorWithHexString:@"29333E"]
#define SliderColor     [UIColor colorWithHexString:@"FB4209"]
#define LineColor      [UIColor colorWithHexString:@"D4D4D4"]

@interface SegementView ()

@property(nonatomic,strong)UILabel * sliderLabel;//底部滑块
@property (nonatomic,strong)NSArray * titleArr;//储存传过来的title数组
@end

@implementation SegementView
-(id)initWithFrame:(CGRect)frame TitleArr:(NSArray *)titleArr
{
    if (self=[super initWithFrame:frame])
    {
        self.titleArr=[[NSArray alloc] initWithArray:titleArr];
        [self creatSegementWithTitle:titleArr];
    }
    return self;
}

-(void)creatSegementWithTitle:(NSArray *)titleArr
{
    for (int i=0; i<titleArr.count; i++)
    {
        UIButton * but = [UIButton buttonWithType:UIButtonTypeCustom];
        but.frame=CGRectMake(ButWidth*i, 0 , ButWidth , ButHeight);
        //TODO: sege 按钮颜色
        [but setTitleColor:ButNormalColor forState:UIControlStateNormal];
        [but setTitle:titleArr[i] forState:UIControlStateNormal];
        but.titleLabel.font=BoldFont(14.0f*View_Radio);
        but.tag=300+i;
        [but  addTarget:self action:@selector(butClick:) forControlEvents:UIControlEventTouchUpInside];
        if (i==0)
        {
            [but setTitleColor:ButSelectColor forState:UIControlStateNormal];
        }
        [self addSubview:but];
    }
    self.sliderLabel.frame=CGRectMake(SpaceSlider,ButHeight-1, SliderWidth, 1);
    
    //创建sege中间的分割线
    for (int i=0; i<self.titleArr.count-1; i++)
    {
        UILabel * lineLabel=[[UILabel alloc] initWithFrame:CGRectMake((ButWidth-LineWidth)+ButWidth*i, SpaceLineTop, LineWidth, LineHeiht)];
        //TODO: 设置颜色
        lineLabel.backgroundColor=LineColor;
        [self addSubview:lineLabel];
    }
    
    //滑动slierView 改变按钮的选中状态
    __weak typeof(self) wself = self;
    self.sliderBlock= ^(NSInteger number){
        UIButton * but =[wself viewWithTag:(NSInteger)300+number];
        [wself didButClick:but];
    };
}

-(void)butClick:(UIButton *)but
{
    [self didButClick:but];
    //按钮的点击事件 调用改变slierview的contentoffset
    self.selectBlock((int)but.tag-300);
}

-(void)didButClick:(UIButton *)but
{
    [self  changed:but];
    [UIView animateWithDuration:0.05 animations:^{
        self.sliderLabel.frame=CGRectMake(SpaceSlider+but.frame.origin.x,ButHeight-SliderHeight, SliderWidth, SliderHeight);
    }];
}

-(void)changed:(UIButton *)but
{
    for (int i=0; i<self.titleArr.count; i++)
    {
        UIButton * button=(UIButton *)[self viewWithTag:300+i];
        [but setTitleColor:ButSelectColor forState:UIControlStateNormal];
        [button setTitleColor:ButNormalColor forState:UIControlStateNormal];
        if (i==self.titleArr.count-1)
        {
          [but setTitleColor:ButSelectColor forState:UIControlStateNormal];
        }
    }
}

#pragma mark-懒加载
-(UILabel *)sliderLabel
{
    if (!_sliderLabel)
    {
        _sliderLabel=[[UILabel alloc] init];
        _sliderLabel.backgroundColor= SliderColor;
        [self addSubview:_sliderLabel];
    }
    return _sliderLabel;
}


@end
