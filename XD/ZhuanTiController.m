//
//  ZhuanTiController.m
//  XD
//
//  Created by 李攀祥 on 16/1/18.
//  Copyright © 2016年 李攀祥. All rights reserved.
//

#import "ZhuanTiController.h"
#import "ZhuTiModel.h"
#import "ZhuTiCell.h"
#import "ZhuTiSectionHead.h"
#import "ZhuTiSectionFoot.h"
#import "SumSortController.h"
//#define CellWidth 90*View_Radio

#define CellWidth  Screen_Width/3

#define CellHeight 140*View_Radio

#define SectionHeadHeight 50*View_Radio

#define SectionFootHeight 20*View_Radio
@interface ZhuanTiController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
{
    int _page;
    NSMutableArray * _dataArr;
}
@property(nonatomic,strong)UICollectionView * indexCollectionView;
@end

@implementation ZhuanTiController

- (void)viewDidLoad {
    [super viewDidLoad];
    _dataArr=[NSMutableArray  array];
    _page=0;
    [self.view addSubview:self.indexCollectionView];
    [self loadData:_page];
}
#pragma mark-请求数据
-(void)loadData:(int)page
{
    NSDictionary * dict=@{@"offset":[NSString stringWithFormat:@"%d",page]};
    [HYBNetworking getWithUrl:FanZu_FenLei_ZhuanTi params:dict success:^(id response) {
        NSLog(@"番组--主题 success");
        _dataArr =[ZhuTiManger arrWithArr:response];
        [self.indexCollectionView reloadData];
    } fail:^(NSError *error) {
        NSLog(@"番组--主题失败");
    }];
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
        layout.minimumInteritemSpacing = 0;
        //最小行间距
        layout.minimumLineSpacing = 0;
        //距离上下左右的边距
        layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
        //设置滚动的方法(Vertical竖向)
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        _indexCollectionView=[[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width , Screen_Height-Nav_Height) collectionViewLayout:layout];
        _indexCollectionView.backgroundColor = [UIColor clearColor];
        //遵循代理
        _indexCollectionView.delegate = self;
        _indexCollectionView.dataSource = self;
        //注册cell
        [_indexCollectionView registerNib:[UINib nibWithNibName:@"ZhuTiCell" bundle:nil] forCellWithReuseIdentifier:@"ZhuTiCell"];
        
         //注册Section头部视图
         [_indexCollectionView registerClass:[ZhuTiSectionHead class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"ZhuTiSectionHead"];
        
          [_indexCollectionView registerClass:[ZhuTiSectionFoot class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"ZhuTiSectionFoot"];
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
    ZhuTiZu * model=_dataArr[section];
    return model.items.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ZhuTiCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ZhuTiCell" forIndexPath:indexPath];
    if (_dataArr.count)
    {
        ZhuTiZu * model=_dataArr[indexPath.section];
        ZhuTiOne * one = model.items[indexPath.row];
        cell.model = one;
    }
    return cell;
}

#pragma mark- cell的点击事件
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    ZhuTiZu * model=_dataArr[indexPath.section];
    ZhuTiOne * one = model.items[indexPath.row];
    self.didCellBlock(one._id);
}

#pragma mark-Section头尾部视图的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeMake(Screen_Width,SectionHeadHeight);
}

#pragma mark-Section尾部视图的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    return CGSizeMake(Screen_Width,SectionFootHeight);
}


#pragma mark-返回的头尾部视图
-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    ZhuTiZu * model=_dataArr[indexPath.section];
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        ZhuTiSectionHead * headerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"ZhuTiSectionHead" forIndexPath:indexPath];
        headerView.model =model;
        __weak typeof(self)Wself=self;
        headerView.block=^(ZhuTiZu * model)
        {
            [Wself didSectionHead:model];
        };
        return headerView;
    }else
    {
        ZhuTiSectionFoot * foot1 =[collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"ZhuTiSectionFoot" forIndexPath:indexPath];
        return foot1;
    }
}

#pragma mark-点击section头部的 点击事件
/*!
 * 共多少部分动漫
 */
-(void)didSectionHead:(ZhuTiZu *)model
{
    self.sectionHeadBlock(model);
};


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
