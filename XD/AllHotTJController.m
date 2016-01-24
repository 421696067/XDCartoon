//
//  AllHotTJController.m
//  XD
//
//  Created by 李攀祥 on 16/1/13.
//  Copyright © 2016年 李攀祥. All rights reserved.
//

#import "AllHotTJController.h"
#import "User.h"
#import "AllHotModel.h"
#import "AllHotDataSource.h"
#import "AllHotCell.h"
@interface AllHotTJController ()
{
    int _page;
    NSMutableArray * _dataArr;
}
@property (nonatomic,strong)UITableView * indexTableView;
@property (nonatomic, strong) NSMutableArray *cellIdentifiers;
@property (nonatomic,strong)AllHotDataSource * datasource;
@end
@implementation AllHotTJController
- (void)viewDidLoad {
    [super viewDidLoad];
    _dataArr=[[NSMutableArray alloc] init];
    _page=0;
    //创建并添加tableView
    [self.view addSubview:self.indexTableView];
    // 初始化datasource
    [self configDataSource];
}
#pragma mark-初始化dataSource
- (void)configDataSource
{
    // cell数据
    [self loadData:_page];
    // cell复用
    [self configIdentifier];
    // cell事件
    CellSelectedBlock cellSelectedBlock = ^(id obj){
        // cell点击事件
        [self cellSelectedWithObj:obj];
    };
    _datasource.cellSelectedBlock = cellSelectedBlock;
}

- (void)configIdentifier
{
     _cellIdentifiers = [[NSMutableArray alloc] init];
    [_cellIdentifiers addObject:NSStringFromClass([AllHotCell class])];
    [_indexTableView registerNib:[AllHotCell nib] forCellReuseIdentifier:NSStringFromClass([AllHotCell class])];
}

-(void)loadData:(int)page
{
    NSDictionary * dict=@{@"offset":[NSString stringWithFormat:@"%d",20]};
    [HYBNetworking  getWithUrl:self.url params:dict success:^(id response) {
        _dataArr=[[MADDetailManger arrWithDict:response] mutableCopy];
          //必须要请求成功之后 才值初始化和遵循代理
          //初始化dataSource
          _datasource = [[AllHotDataSource alloc] initWithServerData:_dataArr
          andCellIdentifiers:_cellIdentifiers];
         _indexTableView.delegate=_datasource;
         _indexTableView.dataSource=_datasource;
          //而且还别忘了 这个刷新
          [_indexTableView reloadData];
         NSLog(@"所有的hot -success");
        //绑定datasource和tableView
    } fail:^(NSError *error){
        NSLog(@"所有的hot--faile");
}];

}
#pragma mark-懒加载
-(UITableView *)indexTableView
{
    if (!_indexTableView)
    {
        _indexTableView=[[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
        //separator分隔  设置cell的分隔符
        _indexTableView.separatorStyle=UITableViewCellSeparatorStyleNone;
        
        //这句是 防止出现tableview底部 多条线
        //_indexTableView.tableFooterView = [UIView new];
        _indexTableView.backgroundColor=[UIColor redColor];
    }
    return _indexTableView  ;
}


#pragma mark - tableView的点击事件
- (void)cellSelectedWithObj:(id)obj
{
    NSIndexPath * path= (NSIndexPath*)obj;
    NSLog(@"点击了第%d行，第%d列",(int)path.section,(int)path.row);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
