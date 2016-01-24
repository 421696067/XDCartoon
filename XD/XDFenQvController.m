//
//  XDFenQvController.m
//  XD
//
//  Created by 李攀祥 on 16/1/8.
//  Copyright © 2016年 李攀祥. All rights reserved.

#import "XDFenQvController.h"
#import "FenQvModel.h"
#import "FenQvCell.h"
#import "FenQHeadSection.h"

#define TitleColor [UIColor blackColor]
#define CellWidth  Screen_Width/3
@interface XDFenQvController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
{
    NSMutableArray * _dataArr;
}
//边框的颜色 D4D4D4
@property(nonatomic,strong)UICollectionView * indexCollectionView;
@end

@implementation XDFenQvController

- (void)viewDidLoad {
    [super viewDidLoad];
    _dataArr=[[NSMutableArray alloc] init];
    self.view.backgroundColor=[UIColor clearColor];
    [self.view addSubview:self.indexCollectionView];
    [self loadData];
}

-(void)loadData
{
   [HYBNetworking  getWithUrl:FanQv success:^(id response)
    { NSLog(@"分区--success");
     _dataArr=[[FenQvManger arrWithDict:response] mutableCopy];
        [self.indexCollectionView reloadData];
    } fail:^(NSError *error) {
        NSLog(@"分区--error%@",error);
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
        layout.itemSize = CGSizeMake(CellWidth,CellWidth);
        //最小格间距（每个单元格之间的最小间距）
        layout.minimumInteritemSpacing = 0;
        //最小行间距
        layout.minimumLineSpacing = 0;
        //距离上下左右的边距
        layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
        //设置滚动的方法(Vertical竖向)
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        _indexCollectionView=[[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width , Screen_Height-Nav_Height-Tab_Height) collectionViewLayout:layout];
        _indexCollectionView.backgroundColor = [UIColor clearColor];
        //遵循代理
        _indexCollectionView.delegate = self;
        _indexCollectionView.dataSource = self;
        //注册cell
        [_indexCollectionView registerNib:[UINib nibWithNibName:@"FenQvCell" bundle:nil] forCellWithReuseIdentifier:@"fenqccell"];
        //注册Section头部视图
        [_indexCollectionView registerClass:[FenQHeadSection class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"flSectionHead"];
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
    FenQvZu * model=_dataArr[section];
    return model.children.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    FenQvCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"fenqccell" forIndexPath:indexPath];
    if (_dataArr.count)
    {
        FenQvZu * model=_dataArr[indexPath.section];
        FenQvOne * one = model.children[indexPath.row];
        cell.model = one;
    }
    return cell;
}

#pragma mark- cell的点击事件
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    FenQvZu * model=_dataArr[indexPath.section];
    FenQvOne * one = model.children[indexPath.row];
    self.cellButBlock(one._id);
}


#pragma mark-Section头尾部视图的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeMake(Screen_Width, 35*View_Radio);
}
#pragma mark-返回的头尾部视图
-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    FenQvZu * model=_dataArr[indexPath.section];
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        FenQHeadSection * headerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"flSectionHead" forIndexPath:indexPath];
        headerView.model =model;
        return headerView;
    }else
    {
        return NULL;
    }
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
