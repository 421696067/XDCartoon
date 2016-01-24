//
//  TuiJianHeadView.m
//  XD
//
//  Created by 李攀祥 on 16/1/8.
//  Copyright © 2016年 李攀祥. All rights reserved.
//

#import "TuiJianHeadView.h"
#import "CycleScrollView.h"
#import "TuiJianModel.h"
#import "BenJiView.h"

//TODO: 需要的时候这里需要更改
#define  HeadViewAllHeight ADHeight+130*View_Radio+2*BjSpaceTop + BJsighHeight+MoreButHeight+BjSpaceTop//100+130+2*5+30+5+40

#define  ADHeight 100 * View_Radio//-50-10-10
#define  ADTime  2.0f

//title颜色
#define  titleColor [UIColor colorWithHexString:@"29333E"]

//每个cell的宽度
//底部滑动视图的每个cell的间隔
#define  SpaceCell  10 * View_Radio
#define  WidthCell  80 * View_Radio

//本季新番的高度
#define BJsighHeight  30* View_Radio//本季图标的高度
#define BjTitleHeight 30* View_Radio//本季标题的高度
#define BjSpaceTop  5*View_Radio//图标距离上部的间距
//更多按钮的高度
#define MoreButHeight  35*View_Radio

@interface TuiJianHeadView ()<CycleScrollViewDelegate>
{
    NSMutableArray * _admArr;//广告界面的数据源
    NSMutableArray   * _bjArr;//本季新番scroller数据源
}
@property(nonatomic,strong)CycleScrollView * adSC;
@property (nonatomic,strong)UIImageView * leftImage;
@property (nonatomic,strong)UILabel * titleLabel;
//本季新番的scrollerView
@property (nonatomic,strong)UIScrollView * benjiSC;
//底部查看更多的按钮
@property (nonatomic,strong)UIButton * moreBut;

@end

@implementation TuiJianHeadView
-(id)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame])
    {
        _bjArr=[[NSMutableArray alloc] init];
        _admArr=[[NSMutableArray alloc] init];
        //添加控件
        [self configUI];
         //添加约束
        [self creatLayout];
        //添加数据
        [self loadData];
    }
    return self;
}

#pragma mark-添加控件
-(void)configUI
{
    [self addSubview:self.adSC];
    [self addSubview:self.leftImage];
    [self addSubview:self.titleLabel];
    [self addSubview:self.benjiSC];
    [self addSubview:self.moreBut];
}

#pragma mark-添加约束
-(void)creatLayout
{
    //本季新番的图标
    [self.leftImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10*View_Radio);
        make.top.mas_equalTo(self.adSC.mas_bottom).offset(BjSpaceTop);
        make.height.width.mas_equalTo(BJsighHeight);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.leftImage.mas_centerY);
        make.left.mas_equalTo(self.leftImage.mas_right).offset(10*View_Radio);
        make.height.mas_equalTo(BjTitleHeight);
    }];
    
    [self.benjiSC mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(self.leftImage.mas_bottom).offset(BjSpaceTop);
        make.height.mas_equalTo(130*View_Radio);
    }];
    
    
    [self.moreBut mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.benjiSC.mas_bottom).offset(BjSpaceTop);
        make.left.mas_equalTo(10*View_Radio);
        make.right.mas_equalTo(-10*View_Radio);
        make.height.mas_equalTo(MoreButHeight);
    }];
    
}

#pragma mark-添加数据
-(void)loadData
{
    //添加广告业数据
    [self ADData];
    //添加本季新番数据
    [self BJData];
}
-(void)ADData
{
    NSMutableArray * imageArr=[[NSMutableArray alloc] init];
    [HYBNetworking getWithUrl:TuiJianAD success:^(id response) {
        NSLog(@"广告页 请求成功");
        NSData *data =   [NSJSONSerialization dataWithJSONObject:response options:NSJSONWritingPrettyPrinted error:nil];
        _admArr = [[TuiJianadManger arrJsonWithData:data] mutableCopy];
        for (int i=0; i<_admArr.count; i++) {
            TuiJianADModel * model=_admArr[i];
            [imageArr addObject:model.imageUrl];
        }
        self.adSC.imageURLStringsGroup = imageArr;
       } fail:^(NSError *error) {
           NSLog(@"推荐广告业请求失败%@",error);
       }];
}

-(void)BJData
{
    [HYBNetworking getWithUrl:TuiJian_BenJi success:^(id response) {
        NSLog(@"推荐-本季新番请求成功");
     _bjArr=[[TuiJianBJManger arrayWithArr:response] mutableCopy];
        [self creatSlierView];
        } fail:^(NSError *error) {
        NSLog(@"推荐-本季新番请求失败%@",error);
    }];
}

-(void)creatSlierView
{
    for (int i=0; i<_bjArr.count; i++)
    {
        tuijianBJModel * model=_bjArr[i];
        BenJiView * bjV=[[BenJiView alloc] initWithFrame:CGRectMake(SpaceCell+(SpaceCell+WidthCell)*i, 0, WidthCell, 130*View_Radio) Model:model];
        bjV.tag=320+i;

        bjV.butBlock=^(NSString * _id)
        {
           [self cellClick:_id];
        };
        [self.benjiSC addSubview:bjV];
    }
    self.benjiSC.contentSize=CGSizeMake(_bjArr.count * (SpaceCell+WidthCell) ,130*View_Radio);
}

#pragma mark-下部按钮的回调
-(void)cellClick:(NSString *)_id
{
    NSLog(@"推荐-本季-分类-—id=%@",_id);
    //NSLog(@"%@",[NSString stringWithFormat:Anime_Detail,_id]);
    self.bjBlock(_id);
}


#pragma mark-CycleScrollerView的代理方法
/*!
 *  点击 轮播的图片时 调用的方法
 */
- (void)cycleScrollView:(CycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
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

#pragma mark-懒加载
-(CycleScrollView *)adSC
{
    if (!_adSC)
    {
        //这个第三方库不能用约束了·只能用frame来约束
        _adSC=[[CycleScrollView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, ADHeight)];
        _adSC.delegate=self;
        _adSC.autoScrollTimeInterval=ADTime;
        _adSC.pageControlStyle = CycleScrollViewPageContolStyleAnimated;
        _adSC.pageControlAliment = CycleScrollViewPageContolAlimentCenter;
        }
    return _adSC;
}

-(UIImageView *)leftImage
{
    if (!_leftImage)
    {
        _leftImage=[[UIImageView alloc] init];
        _leftImage.image=imageRender(@"tuijian_bj");
    }
    return _leftImage;
}
-(UILabel *)titleLabel
{
    if (!_titleLabel)
    {
        _titleLabel=[[UILabel alloc] init];
        _titleLabel.text=@"本季新番";
        _titleLabel.textColor = titleColor;
        _titleLabel.font=Font(14*View_Radio);
    }
    return _titleLabel;
}

-(UIScrollView *)benjiSC
{
    if (!_benjiSC)
    {
        _benjiSC=[[UIScrollView alloc] init];
        _benjiSC.showsVerticalScrollIndicator=NO;
        _benjiSC.showsHorizontalScrollIndicator=NO;
        _benjiSC.contentOffset=CGPointMake(0, 0);
        _benjiSC.bounces=YES;
    }
    return _benjiSC;
}

-(UIButton *)moreBut
{
    if (!_moreBut)
    {
        _moreBut=[UIButton buttonWithType:UIButtonTypeCustom];
        [_moreBut setBackgroundImage:imageRender(@"butMore") forState:UIControlStateNormal];
        [_moreBut addTarget:self action:@selector(moreClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _moreBut;
}

#pragma mark-底部更多按钮的点击事件
-(void)moreClick
{
    self.allXF();
}
@end
