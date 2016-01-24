//
//  XDFanZuController.m
//  XD
//
//  Created by 李攀祥 on 16/1/8.
//  Copyright © 2016年 李攀祥. All rights reserved.
//

#import "XDFanZuController.h"
#import "FanzuheadView.h"
#import "MyLayout.h"
#import "FanZuModel.h"
#import "FanZuCollectionCell.h"
#import "XDFootView.h"

//头部视图的总高度
#define HeadHeight 185*View_Radio

@interface XDFanZuController ()<MyLayoutDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
{
    int _page;
    NSMutableArray * _dataArr;//数据源
}
@property(nonatomic,strong)UICollectionView * indexCollection;
@end

@implementation XDFanZuController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor clearColor];
    _dataArr=[[NSMutableArray alloc] init];
    _page=0;
    //加载数据
    [self loadData:_page];
    //添加collectionview
    [self.view addSubview:self.indexCollection];
    //添加头部视图
    [self addheadView];
}
-(void)addheadView
{
    FanzuheadView * view=[[FanzuheadView alloc] initWithFrame:CGRectMake(0, -HeadHeight, Screen_Width, HeadHeight)];
    __weak typeof (self)wSelf=self;
    view.block=^(NSString * url,NSString * type)
    {
        [wSelf didSelectAdUrl:url type:type];
    };
    view.fenLeiButBlock=^{
        [wSelf  didfanZuBut];
    };
    view.xfTimeBlock=^{
        [wSelf didXinFanTime];
    };
    self.indexCollection.contentInset=UIEdgeInsetsMake(HeadHeight, 0, 0, 0);
    [self.indexCollection addSubview:view];
}

#pragma mark - 广告页面的回调
-(void)didSelectAdUrl:(NSString *)url type:(NSString *)type
{
    self.block(url,type);
}

#pragma mark - 番组分类按钮回调
-(void)didfanZuBut
{
    self.fenLeiButBlock();
}

#pragma mark-新番时间表按钮回调
-(void)didXinFanTime
{
 self.xfTimeBlock();
}

#pragma mark-数据的加载
-(void)loadData:(int )page
{
       NSDictionary * dict=@{@"offset":[NSString stringWithFormat:@"%d",page]};
  //    [HYBNetworking enableInterfaceDebug:YES];
   [HYBNetworking getWithUrl:FanZu_FenLei params:dict success:^(id response) {
      NSLog(@"番组--分类请求成功");
     _dataArr=[[fanzuFlManger arrwithArr:response] mutableCopy];
    [self.indexCollection  reloadData];
    } fail:^(NSError *error) {
     NSLog(@"番组分类失败%@",error);
  }];
}

#pragma mark--懒加载
-(UICollectionView *)indexCollection
{
    if (!_indexCollection) {
        //布局对象
        /*!
         *  特别注意：（如果一直出现数组的情况）且找不到原因，一定要注意是不是这个
         *  UIEdgeInsetsMake(5, 5, 5, 5) 属性 是不是设置多了
         */
        MyLayout *layout = [[MyLayout alloc] initWithSectionInsets:UIEdgeInsetsMake(5*View_Radio, 8*View_Radio, 5*View_Radio, 8*View_Radio) itemSpace:8*View_Radio lineSpace:8*View_Radio];
        //设置代理
        layout.delegate = self;
        //网格视图
        _indexCollection = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width , Screen_Height-Nav_Height-Tab_Height) collectionViewLayout:layout];
        _indexCollection.showsVerticalScrollIndicator=NO;
        _indexCollection.showsHorizontalScrollIndicator=NO;
        _indexCollection.backgroundColor=[UIColor clearColor];
        _indexCollection .delegate=self;
        _indexCollection.dataSource=self;
        //注册cell
        [_indexCollection registerNib:[UINib nibWithNibName:@"FanZuCollectionCell" bundle:nil] forCellWithReuseIdentifier:@"fanzucollection"];
    }
    return _indexCollection;
}

#pragma mark - UICollectionView代理
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _dataArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    FanZuCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"fanzucollection" forIndexPath:indexPath];
    if (_dataArr.count)
    {
        fanzuFlModel *model = _dataArr[indexPath.row];
        cell.model=model;
    }
    cell.backgroundColor = [UIColor clearColor];
    return cell;
}
#pragma mark-cell的点击事件
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"点击新番");
    fanzuFlModel *model = _dataArr[indexPath.row];
    self.cellBlock(model._id);
}


#pragma mark - MyLayout代理
-(int)columnsInCollectionView
{
    return 2;
}

- (CGFloat)heightForCellAtIndexPath:(NSIndexPath *)indexPath
{
    fanzuFlModel *model = _dataArr[indexPath.item];
    return model.height;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
