//
//  FenQvButController.m
//  XD
//
//  Created by 李攀祥 on 16/1/21.
//  Copyright © 2016年 李攀祥. All rights reserved.

#import "FenQvButController.h"
#import "CycleScrollView.h"
#import "FenQBModel.h"
#import "FenQBHotCell.h"
@interface FenQvButController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray * _dataArr;
    NSArray * _ADArr;
    NSArray * _HotArr;
    NSArray * _TuijianArr;
    NSArray * _NewArr;
}
@property(nonatomic,strong)UITableView * indextableView;
@property (nonatomic,strong)CycleScrollView * headView;

@end

@implementation FenQvButController

- (void)viewDidLoad {
    [super viewDidLoad];
    _dataArr=[[NSMutableArray alloc] init];
    [self loadData];
}
#pragma mark-加载数据
-(void)loadData
{
    [self loadAD];//加载广告业
    [self loadHot];//加载Hot
    [self loadTuijian];//加载推荐
    [self loadNews];//加载资讯
}

-(void)loadAD
{
   [HYBNetworking getWithUrl:[NSString stringWithFormat:AMD_More_Image,self._id] success:^(id response) {
       NSLog(@"AMD-更多-Success");
       NSDictionary * dict =(NSDictionary *)response;
       NSString  * number=dict[@"result"][@"total"];
       if ([number intValue]!=0)
       {
           
       }

       
   } fail:^(NSError *error) {
       
   }];
}
-(void)loadHot
{
   [HYBNetworking getWithUrl:[NSString stringWithFormat:AMD_More_Hots,self._id] success:^(id response) {
       NSDictionary * dict =(NSDictionary *)response;
       NSString  * number=dict[@"result"][@"total"];
       NSArray * arr=dict[@"eps"];
       if ([number intValue]!=0)
       {
           _HotArr=[FenQBHotManger arrWithArr:arr];
           [_dataArr addObject:_HotArr];
       }
       

   } fail:^(NSError *error) {
       
   }];
}

-(void)loadTuijian
{
    [HYBNetworking getWithUrl:[NSString stringWithFormat:AMD_More_TuiJian,self._id] success:^(id response) {
        NSDictionary * dict =(NSDictionary *)response;
        NSString  * number=dict[@"result"][@"total"];
        NSArray * arr=dict[@"eps"];
        if ([number intValue]!=0)
        {
            _TuijianArr=[FenQBHotManger arrWithArr:arr];
            [_dataArr addObject:_TuijianArr];
        }
        
    } fail:^(NSError *error) {
        
    }];
}
-(void)loadNews
{
    [HYBNetworking getWithUrl:[NSString stringWithFormat:AMD_More_NEWS,self._id] success:^(id response) {
        NSDictionary * dict =(NSDictionary *)response;
        NSString  * number=dict[@"result"][@"total"];
        if ([number intValue]!=0)
        {
            
        }

    } fail:^(NSError *error) {
        
    }];
}

#pragma mark-tableView的代理方法
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _dataArr.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray * arr=_dataArr[section];
    return arr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0)
    {
    }
    return NULL;
}

#pragma mark-懒加载
-(UITableView *)indextableView
{
    if (!_indextableView) {
        _indextableView =[[UITableView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, Screen_Height-Nav_Height) style:UITableViewStylePlain];
        _indextableView.delegate=self;
        _indextableView.dataSource=self;
        _indextableView.separatorStyle=UITableViewCellSeparatorStyleNone;
        _indextableView.tableFooterView=[UIView new];
        [_indextableView registerNib:[UINib nibWithNibName:@"FenQBHotCell" bundle:nil] forCellReuseIdentifier:@"FQHot"];
    }
    return _indextableView;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}
@end
