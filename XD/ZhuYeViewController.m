#import "ZhuYeViewController.h"
#import "ZhuYeCell.h"
#import "ZhuYeModel.h"
#import "ZhuYeDataSource.h"
#import "AppDelegate.h"
@interface ZhuYeViewController ()

@property (nonatomic,strong)UIImageView * imageView;//背景图片
@property (nonatomic,strong)UIImageView * TXIamgeView;//头像
@property (nonatomic,strong)UIButton    * xZBut;//选择头像的按钮
@property (nonatomic,strong)UITableView * indexTableView ;//TableView

/*!
 * 服务器返回的数据 cell样式  中间人
 */
@property (nonatomic, strong) NSMutableArray *serverData;
@property (nonatomic, strong) NSMutableArray *cellIdentifiers;
@property (nonatomic,strong)ZhuYeDataSource * datasource;
@end

@implementation ZhuYeViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置背景图片
    [self.view addSubview:self.imageView];
    /*!
     * 特别特别注意 一定要先 创建tableView 再初始化datasource
     * 但是 tableview的代理必须要在初始化dataSource之后在遵循
     */
    //创建并添加tableView
    [self.view addSubview:self.indexTableView];
    // 初始化datasource
    [self configDataSource];
    //绑定datasource和tableView
    _indexTableView.delegate=_datasource;
    _indexTableView.dataSource=_datasource;
    
    //添加UI
    [self.view addSubview:self.TXIamgeView];
    [self.view addSubview:self.xZBut];
    
    //添加约束
    [self creatLayout];
}

#pragma mark-初始化dataSource
- (void)configDataSource
{
    // cell数据
    [self configData];
    // cell复用
    [self configIdentifier];
    // cell事件
    CellSelectedBlock cellSelectedBlock = ^(id obj){
        // cell点击事件
        [self cellSelectedWithObj:obj];
    };
    // 初始化dataSource
    _datasource = [[ZhuYeDataSource alloc] initWithServerData:_serverData
        andCellIdentifiers:_cellIdentifiers];
    _datasource.cellSelectedBlock = cellSelectedBlock;
}

- (void)configData
{
    _serverData =[[NSMutableArray alloc] init];
    NSArray * titleArr=@[ @"收藏", @"设置", @"关于我们", @"建议反馈" ];
    NSArray * iconArr=@[ @"q", @"w", @"e", @"r" ];
    for (int i=0;i<titleArr.count ; i++)
    {
        ZhuYeModel * model=[[ZhuYeModel alloc] init];
        model.name=titleArr[i];
        model.iconImage=iconArr[i];
        [_serverData addObject:model];
    }
}

- (void)configIdentifier
{
    _cellIdentifiers = [[NSMutableArray alloc] init];
    [_cellIdentifiers addObject:NSStringFromClass([ZhuYeCell class])];
    [_indexTableView registerNib:[ZhuYeCell nib] forCellReuseIdentifier:NSStringFromClass([ZhuYeCell class])];
}


#pragma mark-懒加载
-(UIImageView *)imageView
{
    if (!_imageView)
    {
        _imageView=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, Screen_Height)];
        _imageView.image=[UIImage imageNamed:@"side_menu_bg"];
    }
    return _imageView;
}

-(UIImageView *)TXIamgeView
{
    if (!_TXIamgeView)
    {
        _TXIamgeView=[[UIImageView alloc] init];
        _TXIamgeView.image=[UIImage imageNamed:@"normalTX"];
        _TXIamgeView.layer.masksToBounds=YES;
        _TXIamgeView.layer.cornerRadius=40*View_Radio;
    }
    return _TXIamgeView;
}

-(UIButton *)xZBut
{
    if (!_xZBut)
    {
        _xZBut=[UIButton buttonWithType:UIButtonTypeCustom];
        [_xZBut setTitle:@"" forState:UIControlStateNormal];
        [_xZBut addTarget:self action:@selector(selectTX) forControlEvents:UIControlEventTouchUpInside];
    }
    return _xZBut;
}

-(UITableView *)indexTableView
{
    if (!_indexTableView)
    {   /*
         *这里的实例化 既可以是用initWithFrame:style:
         *也可以直接init在直接用约束 设置位置
         */
        _indexTableView=[[UITableView alloc]init];
        //separator分隔  设置cell的分隔符
        _indexTableView.separatorStyle=UITableViewCellSeparatorStyleNone;
        //这句是 防止出现tableview底部 多条线
        _indexTableView.tableFooterView = [UIView new];
        _indexTableView.backgroundColor=[UIColor clearColor];
    }
    return _indexTableView;
}

#pragma mark-选择头像的点击事件
-(void)selectTX
{
    
}

#pragma mark - tableView的点击事件
- (void)cellSelectedWithObj:(id)obj
{
    NSIndexPath * path= (NSIndexPath*)obj;
   NSLog(@"点击了第%d行，第%d列",(int)path.section,(int)path.row);

}

#pragma mark-添加约束
-(void)creatLayout
{
    //头像
    [self.TXIamgeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(70*View_Radio);
        make.left.mas_equalTo(60*View_Radio);
        make.width.height.mas_equalTo(80*View_Radio);}];
    
    //选择头像按钮
    [self.xZBut mas_makeConstraints:^(MASConstraintMaker *make) {
        //特别注意：centerX和centerY
        make.centerX.mas_equalTo(_TXIamgeView.mas_centerX);
        make.top.mas_equalTo(_TXIamgeView.mas_bottom).offset(2*View_Radio);
        make.width.mas_equalTo(100*View_Radio);
        make.height.mas_equalTo(26*View_Radio);}];

    //tableView
    [self.indexTableView mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.mas_equalTo(self.xZBut.mas_bottom).offset(0*View_Radio);
        make.width.mas_equalTo(200*View_Radio);
        make.height.mas_equalTo(cellNormalHeight*4*View_Radio);
        make.left.mas_equalTo(0);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
