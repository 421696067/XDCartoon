//
//  XFSortDetailController.m
//  XD
//
//  Created by 李攀祥 on 16/1/21.
//  Copyright © 2016年 李攀祥. All rights reserved.
//

#import "XFSortDetailController.h"
#import "SumSortCell.h"
#import "AnimaDetailModel.h"
#import "XFSortDetailCell.h"
@interface XFSortDetailController ()<UITableViewDelegate,UITableViewDataSource>
{
    int _page;
    NSMutableArray * _dataArr;//数据源
}
@property (nonatomic,strong)UITableView * indexTableView;
@end

@implementation XFSortDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    _page=0;
    _dataArr=[NSMutableArray array];
    //设置导航栏
    [self creatNav];
    //添加tableView
    [self.view addSubview:self.indexTableView];
    //请求数据
    [self loadData:_page];}
-(void)creatNav
{
    [self setHtBut];
}
-(void)loadData:(int)page
{
    NSDictionary * dict=@{@"offset":[NSString stringWithFormat:@"%d",page]};
    
    [HYBNetworking getWithUrl:[NSString stringWithFormat:FanZu_FenLei_Detail_Cell,self._id] params:dict success:^(id response){
        [response enumerateObjectsUsingBlock:^(NSDictionary * dict, NSUInteger idx, BOOL * _Nonnull stop)
        {
            AnimaDetailModel * model = [AnimaDetailModel yy_modelWithJSON:dict];
            model.url = dict[@"image"][@"url"];
            [_dataArr addObject:model];
        }];
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
    static NSString * cellIdentifier = @"XFSortDetail";
    XFSortDetailCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier ];
    if (!cell)
    {
        cell=[[XFSortDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
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
    self.animeDetailId=model._id;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AnimaDetailModel * model =_dataArr[indexPath.row];
    return [XFSortDetailCell hyb_heightForIndexPath:indexPath config:^(UITableViewCell *sourceCell) {
        XFSortDetailCell *cell = (XFSortDetailCell *)sourceCell;
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
    }
    return _indexTableView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
