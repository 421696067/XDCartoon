//
//  SortViewController.m
//  XD
//
//  Created by 李攀祥 on 16/1/18.
//  Copyright © 2016年 李攀祥. All rights reserved.
//

#import "SortViewController.h"
#import "SortModel.h"
#import "SortCollectionCell.h"
#define CellWidth 90*View_Radio
#define CellHeight 115*View_Radio
@interface SortViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
{
    int _page;
    NSMutableArray * _dataArr;//数据源
}

@property(nonatomic,strong)UICollectionView * indexCollectionView;
@end

@implementation SortViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _page=0;
    _dataArr=[[NSMutableArray alloc] init];
    [self.view addSubview:self.indexCollectionView];
    [self loadData:_page];
}

#pragma mark-加载数据
-(void)loadData:(int)page
{
    NSDictionary * dict=@{@"offset":[NSString stringWithFormat:@"%d",page]};
    [HYBNetworking  getWithUrl:FanZu_FenLei_FL params:dict success:^(id response) {
         NSLog(@"1月新番-10月新番--success");
         _dataArr=[SortManger arrWithArr:response];
         [self.indexCollectionView reloadData];
     } fail:^(NSError *error) {
         NSLog(@"1月新番-10月新番分类--error%@",error);
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
        layout.minimumInteritemSpacing = 10*View_Radio;
        //最小行间距
        layout.minimumLineSpacing =10*View_Radio;
        //距离上下左右的边距
        layout.sectionInset = UIEdgeInsetsMake(10*View_Radio, 10*View_Radio, 0, 10*View_Radio);
        //设置滚动的方法(Vertical竖向)
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        _indexCollectionView=[[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width , Screen_Height-Nav_Height) collectionViewLayout:layout];
        _indexCollectionView.backgroundColor = [UIColor clearColor];
        //遵循代理
        _indexCollectionView.delegate = self;
        _indexCollectionView.dataSource = self;
        //注册cell
        [_indexCollectionView registerNib:[UINib nibWithNibName:@"SortCollectionCell" bundle:nil] forCellWithReuseIdentifier:@"SortCollectionCell"];
    }
    return _indexCollectionView;
}

#pragma mark-代理方法
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _dataArr.count;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    SortCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"SortCollectionCell" forIndexPath:indexPath];
    if (_dataArr.count)
    {
        SortModel *model = _dataArr[indexPath.row];
        cell.model=model;
    }
    cell.backgroundColor = [UIColor clearColor];
    return cell;
}

#pragma mark-cell的点击事件
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    SortModel *model = _dataArr[indexPath.row];
    self.cellBlock(model._id,model.name);
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
