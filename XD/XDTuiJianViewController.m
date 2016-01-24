//
//  XDTuiJianViewController.m
//  XD
//  Created by 李攀祥 on 16/1/8.
//  Copyright © 2016年 李攀祥. All rights reserved.

#import "XDTuiJianViewController.h"
#import "TuiJianHeadView.h"

#import "TuiJianFLModel.h"
#import "TuiJianFLCell.h"
#import "TuiJianFLHead.h"
#import "TuiJianFLFoot.h"

//头部视图的总高度
#define HeadHeight 315*View_Radio//多加了10（查看更多按钮）底部的空白
//每个cell的高度
#define  CellWidth  (Screen_Width-30*View_Radio)/2
#define  CellHeight 150*View_Radio

@interface XDTuiJianViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
{
    NSMutableArray * _dataArr;//数据源
    TuiJianHeadView  * headView;//头部视图
}
@property (nonatomic,strong)UICollectionView * indexCollectionView;
@end

@implementation XDTuiJianViewController
- (void)viewDidLoad
{
     [super viewDidLoad];
    _dataArr=[[NSMutableArray alloc]init];
     // self.view.backgroundColor=[UIColor colorWithHexString:@"ECEFF3"];
    self.view.backgroundColor=[UIColor clearColor];
    
    [self.view addSubview:self.indexCollectionView];
    
    //添加整个collectionview的头部视图
    [self addHeadView];
    //请求数据
    [self loadData];
    
}

#pragma mark-添加整个collectionview的头部视图
-(void)addHeadView
{
    headView=[[TuiJianHeadView alloc] initWithFrame:CGRectMake(0, -HeadHeight, Screen_Width,HeadHeight)];
    __weak typeof (self)wSelf=self;
    headView.block=^(NSString * url,NSString * type)
    {
        [wSelf didSelectAdUrl:url type:type];
    };
    headView.allXF=^{
        [wSelf didAllXf];
    };
    headView.bjBlock=^(NSString * _id)
    {
        [wSelf didBjButSC:_id];
    };
    
    self.indexCollectionView.contentInset=UIEdgeInsetsMake(HeadHeight, 0, 0, 0);
    [ self.indexCollectionView addSubview:headView];
}
-(void)loadData
{
    [HYBNetworking getWithUrl:TuiJian_FenLei success:^(id response) {
        NSLog(@"推荐分类 成功");
        _dataArr=[[TuiJIanFlManger arrWithArr:response] mutableCopy];
        //特别注意：要请求数据成功之后在调用代理
        [self.indexCollectionView reloadData];
    } fail:^(NSError *error) {
        NSLog(@"推荐分类数据请求失败%@",error);
    }];
}

#pragma mark - 广告页面的回调
-(void)didSelectAdUrl:(NSString *)url type:(NSString *)type
{
    self.block(url,type);
}

#pragma mark- 本季新番下面的查看更多按钮 跳转到第一个新番界面
-(void)didAllXf
{
    self.allXF();
}
#pragma mark - 本季新番-scrollerView内部的but的点击
-(void)didBjButSC:(NSString * )_id
{
    self.bjButBlock(_id);
}

#pragma mark-添加约束
-(void)creatLayout
{
  
    
}

#pragma mark-懒加载
-(UICollectionView *)indexCollectionView
{
    if (!_indexCollectionView) {
        //创建流式布局对象
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        //单元格（每一项）的大小（宽高）
//TODO: 这里需要和cell的宽高对应
        layout.itemSize = CGSizeMake(CellWidth,CellHeight);
        //最小格间距（每个单元格之间的最小间距）
        layout.minimumInteritemSpacing = 10 *View_Radio;
        //最小行间距
        layout.minimumLineSpacing = 10*View_Radio;
        //距离上下左右的边距
        layout.sectionInset = UIEdgeInsetsMake(0, 10*View_Radio, 0, 10*View_Radio);
        //设置滚动的方法(Vertical竖向)
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        
        _indexCollectionView=[[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width , Screen_Height-Nav_Height-Tab_Height) collectionViewLayout:layout];
        _indexCollectionView.backgroundColor = [UIColor clearColor];
        //遵循代理
        _indexCollectionView.delegate = self;
        _indexCollectionView.dataSource = self;
        //注册cell
        [_indexCollectionView registerNib:[UINib nibWithNibName:@"TuiJianFLCell" bundle:nil] forCellWithReuseIdentifier:@"flcollection"];
        //注册Section头部视图
        [_indexCollectionView registerClass:[TuiJianFLHead class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"tuijian_fl_head"];
        //注册Section尾部视图
        [_indexCollectionView registerClass:[TuiJianFLFoot class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"tuijian_fl_foot"];
     }
    return _indexCollectionView;
}

#pragma mark-collectionView代理方法
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return _dataArr.count;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    EverZu * model=_dataArr[section];
    return model.eps.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    TuiJianFLCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"flcollection" forIndexPath:indexPath];
    if (_dataArr.count)
    {   EverZu * model=_dataArr[indexPath.section];
        EverOne * one = model.eps[indexPath.row];
        cell.model = one;  }
    return cell;
}

#pragma mark- cell的点击事件
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    EverZu * model=_dataArr[indexPath.section];
    EverOne * one = model.eps[indexPath.row];
    self.cellBlock(one._id);
}


#pragma mark-Section头尾部视图的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeMake(Screen_Width, 35*View_Radio);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    return CGSizeMake(Screen_Width, 55*View_Radio);
}

#pragma mark-返回的头尾部视图
-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    EverZu * model=_dataArr[indexPath.section];
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        TuiJianFLHead * headerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"tuijian_fl_head" forIndexPath:indexPath];
        headerView.model =model;
        return headerView;
    }else
    {
        TuiJianFLFoot *footView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"tuijian_fl_foot" forIndexPath:indexPath];
        //点击每组 更多按钮的回调
        __weak typeof (self)Wself=self;
        footView.block=^
        {
            [Wself didSelectFootBut:model._id];
//            NSLog(@"点击--%@",model.name);
        };
        return footView;
    }
}

#pragma mark - 尾部视图按钮的 点击事件
-(void)didSelectFootBut:(NSString *)_id
{
    self.footBLock(_id);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
