//
//  SumSortController.m
//  XD
//
//  Created by 李攀祥 on 16/1/19.
//  Copyright © 2016年 李攀祥. All rights reserved.
//

#import "SumSortController.h"
#import "SumSortManger.h"
#import "ZhuTiModel.h"
#import "SumSortHead.h"
#import "SumSortCell.h"
#import "AnimaDetailModel.h"

#define iconHeadHeight  120*View_Radio
@interface SumSortController ()<UITableViewDelegate,UITableViewDataSource>
{
    float _HeadViewheight;//头部视图的高度
    NSMutableArray * _dataArr;//数据源
}
@property (nonatomic,strong)SumSortHead * headView;
@property (nonatomic,strong)UITableView * indexTableView;
@end

@implementation SumSortController

- (void)viewDidLoad {
      [super viewDidLoad];
      _dataArr=[NSMutableArray array];
       //设置导航栏
       [self creatNav];
       //添加tableView
       [self.view addSubview:self.indexTableView];
       //请求数据
       [self loadData];
}


#pragma mark-导航栏
-(void)creatNav
{
    //导航栏的标题视图
    [self setTitleView:self.ZTModel.title textColor:[UIColor orangeColor]];
    
    [self setHtBut];
    //TODO: 分享按钮还没有添加
    //右边的分享按钮
//    [self setLeft:NO ImageName:@"" target:self select:@selector(rightClick)];
}
-(void)loadData
{
    [HYBNetworking getWithUrl:[NSString stringWithFormat:FanZu_FenLei_ZhuTi_More,self.ZTModel._id] success:^(id response) {
        _dataArr=[SumSortManger arrWithArr:response];
        [self.indexTableView reloadData];
    } fail:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}
#pragma mark-tableView的代理方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellIdentifier = @"SumSortCell";
    SumSortCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier ];
    if (!cell)
    {
        cell=[[SumSortCell alloc] initWithStyle:UITableViewCellStyleDefault
                                reuseIdentifier:cellIdentifier];
    }
    
    if (_dataArr)
    {
        AnimaDetailModel * model =_dataArr[indexPath.row];
        [cell configCellWithModel:model];
     }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    AnimaDetailModel * model =_dataArr[indexPath.row];
    //通过父类 get方法  跳转界面
    self.animeDetailId=model._id;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AnimaDetailModel * model =_dataArr[indexPath.row];
    return [SumSortCell hyb_heightForIndexPath:indexPath config:^(UITableViewCell *sourceCell) {
        SumSortCell *cell = (SumSortCell *)sourceCell;
        // 配置数据
        [cell configCellWithModel:model];
    }];
//    return 150*View_Radio;
}

#pragma mark-懒加载
-(UITableView *)indexTableView
{
    if (!_indexTableView)
    {
        _indexTableView =[[UITableView alloc] initWithFrame:CGRectMake(0, Nav_Height,Screen_Width , Screen_Height-Nav_Height)];
        _indexTableView.showsVerticalScrollIndicator=NO;
        _indexTableView.showsHorizontalScrollIndicator=NO;
        _indexTableView.delegate=self;
        _indexTableView.dataSource=self;
        _indexTableView.backgroundColor=[UIColor clearColor];
        //separator分隔  设置cell的分隔符
        _indexTableView.separatorStyle=UITableViewCellSeparatorStyleNone;
        //这句是 防止出现tableview底部 多条线
        _indexTableView.tableFooterView = [UIView new];
        //设置头部视图
        _indexTableView.tableHeaderView =self.headView;
    }
    return _indexTableView;
}

-(SumSortHead *)headView
{
    if (!_headView)
    {
        _headView=[[SumSortHead alloc] init];
        _headView.model = self.ZTModel;
        _headView.jsBlock=^(float h)
        {
            _HeadViewheight = h;
        };
        [_headView jSheight];//专门为了在实例化shead时候 调用block用的
        _headView.frame=CGRectMake(0, 64, Screen_Width, _HeadViewheight);
    }
    return _headView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
