//
//  XDTuiJianController.m
//  XD
//
//  Created by 李攀祥 on 16/1/5.
//  Copyright © 2016年 李攀祥. All rights reserved.
//

#import "XDTuiJianController.h"
/*!
 *  测试专用 接口
 */
#import "SortZTController.h"


//标题titleView
#import "SegementView.h"
/*!
 *  下面三个视图控制器
 */
#import "XDFanZuController.h"
#import "XDTuiJianViewController.h"
#import "XDFenQvController.h"
/*!
 * 点击广告页 跳转的2中页面
 */
#import "AnimaDetailController.h"
#import "HTMLPlay.h"

//#import "TuiJianModel.h"

@interface XDTuiJianController ()<UIScrollViewDelegate>

//动画界面的 导航栏的选择segement
@property(nonatomic,strong) SegementView *sege;
@property (nonatomic,strong)UIScrollView * bgScrollerView;
/*!
 *  底部视图的分视图
 */
@property (nonatomic,strong) XDFanZuController *fanzu ;
@property (nonatomic,strong)XDTuiJianViewController * tuijian;
@property (nonatomic,strong)XDFenQvController * fenqv;

@end
@implementation XDTuiJianController
- (void)viewDidLoad {

    [super viewDidLoad];
    //设置导航栏和背景
    [self  creatNav];
    //添加底部滑动视图scroller
    [self.view addSubview:self.bgScrollerView];
}
#pragma mark-设置导航栏和背景颜色
-(void)creatNav
{
    //设置背景颜色
//    self.view.backgroundColor=[UIColor colorWithHexString:@"ECEFF3"];
    //添加导航栏标题视图
    self.navigationItem.titleView=self.sege;
    __weak typeof(self) wself = self;
    self.sege.selectBlock=^(int number)
    {
        [wself butToPage:number];
    };
    
    //设置右边搜索按钮item
    [self setLeft:NO ImageName:@"search_but" target:self select:@selector(searchClick)];
    //设置左边的头像按钮
    [self setLeft:YES ImageName:@"normalTX" target:self select:@selector(leftTouxiang)];
}

#pragma mark -点击导航栏的按钮的回调
-(void)butToPage:(int )page
{
    self.bgScrollerView.contentOffset=CGPointMake(Screen_Width *page , 0);
}

#pragma mark-scrollerView的代理方法
/*!
 * 滑动下面的视图上面按钮跟着动
*/
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSInteger count=scrollView.contentOffset.x/self.bgScrollerView.frame.size.width;
    self.sege.sliderBlock(count);
}

#pragma mark-右边搜索按钮的实现
-(void)searchClick
{
    
}

#pragma mark-左边头像按钮的实现
-(void)leftTouxiang
{

    
}


#pragma mark-懒加载
-(SegementView *)sege
{
    if (!_sege)
    {
        _sege=[[SegementView alloc] initWithFrame:CGRectMake(0, 0, 210*View_Radio, 40) TitleArr:@[@"新番",@"推荐",@"分区"]];
    }
    return _sege;
}

-(XDFanZuController *)fanzu
{
    if (!_fanzu)
    {    //新番
        _fanzu=[[XDFanZuController alloc] init];
        __weak typeof(self)Wslf=self;
        _fanzu.block=^(NSString *url,NSString *type)
        {//广告
            [Wslf AdUrl:url  type:type];
        };
        _fanzu.cellBlock=^(NSString * _id)
        {//cell的点击
            [Wslf animaDetail:_id];
        };
        _fanzu.fenLeiButBlock=^{
           //番组分类按钮
            [Wslf fenzuSort];
        };
        _fanzu.xfTimeBlock=^{
            //新番时间表
            [Wslf timeLabel];
        };
        
        _fanzu.view.frame=CGRectMake(0, 0, Screen_Width, _bgScrollerView.frame.size.height);
    }
    return _fanzu;
}

-(XDTuiJianViewController *)tuijian
{
    if (!_tuijian)
    {    //推荐
        __weak typeof(self)Wslf=self;
        _tuijian=[[XDTuiJianViewController alloc] init];
        _tuijian.block=^(NSString *url,NSString *type)
        { //推荐广告页
            [Wslf AdUrl:url  type:type];
        };
        _tuijian.allXF=^{
            //本季新番底下查看更多按钮 跳转到新番
            [Wslf tuijianAllXf];
        };
        _tuijian.bjButBlock=^(NSString * _id)
        {   //本季新番scrolleview中按钮
            [Wslf animaDetail:_id];
        };
        _tuijian.cellBlock=^(NSString * _id)
        {   //cell
            [Wslf didfenlei:_id];
        };
        _tuijian.footBLock=^(NSString * _id)
        {   //点击Section尾部视图按钮查看更多
           [Wslf didfootBut:_id];
        };
        _tuijian.view.frame=CGRectMake(Screen_Width,0 , Screen_Width,_bgScrollerView.frame.size.height);
    }
    return _tuijian;
}

-(XDFenQvController *)fenqv
{
    if (!_fenqv)
    {    __weak typeof(self)Wslf=self;
        _fenqv=[[XDFenQvController alloc] init];
        _fenqv.view.frame=CGRectMake(Screen_Width*2, 0, Screen_Width,_bgScrollerView.frame.size.height);
        _fenqv.cellButBlock=^(NSString *_id)
        {
            [Wslf didfootBut:_id];
        };
    }
    return _fenqv;
}
-(UIScrollView *)bgScrollerView
{
    if (!_bgScrollerView)
    {
        _bgScrollerView=[[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, Screen_Width, Screen_Height-Nav_Height-Tab_Height)];
        _bgScrollerView.backgroundColor=[UIColor clearColor];
        //特别主要contentSize 这个高度最好设置为0
        _bgScrollerView.bounces=NO;
        _bgScrollerView.contentOffset=CGPointMake(0, 0);
        _bgScrollerView.delegate=self;
        _bgScrollerView.pagingEnabled=YES;
        _bgScrollerView.showsVerticalScrollIndicator=NO;
        _bgScrollerView.showsHorizontalScrollIndicator=NO;
        _bgScrollerView.contentSize=CGSizeMake(Screen_Width*3, 0);
        //特别注意啊·~:是试图控制的属性 不是导航控制器的属性
        self.automaticallyAdjustsScrollViewInsets=NO;
        [_bgScrollerView addSubview:self.fanzu.view];
        [_bgScrollerView addSubview:self.tuijian.view];
        [_bgScrollerView addSubview:self.fenqv.view];
    }
    return _bgScrollerView;
}

#pragma mark-推荐和新番--广告回调
-(void)AdUrl:(NSString *)url type:(NSString *)type
{
    if ([type isEqualToString:@"1"])
    {  //点击的是 网页！！
        [self disHtml:url];
    }
    else
    {   //点击的动画
        [self animaDetail:url];
    }
}

#pragma mark-推荐-本季-查看更多-跳转到第一个全部新番界面
-(void)tuijianAllXf
{
    [UIView animateWithDuration:0.1 animations:^{
        [self butToPage:0];
    }];
}


#pragma mark--- 跳转到动画详情界面
//推荐-本季-SC-But 点击事件
-(void)animaDetail:(NSString * )_id
{
    self.animeDetailId=_id;
}

#pragma mark-点击跳转到网页
-(void)disHtml:(NSString *)url
{

    //    HTMLPlay * vc=[[HTMLPlay alloc] init];
    //    vc.url = url;
    //    [self.navigationController  pushViewController:vc animated:YES];
}

#pragma mark-新番-番组分类按钮
-(void)fenzuSort
{
SortZTController * svc=[[SortZTController alloc] init];
  [self.navigationController pushViewController:svc animated:YES];
}

#pragma mark-新番-新番时间表
-(void)timeLabel
{
    
}


#pragma mark- 点击进入MAD~AMV的详情界面
/*!
 * 推荐-cell的点击
 */
-(void)didfenlei:(NSString *)_id
{

    
}

#pragma mark-推荐-尾部视图 也就是 分区的按钮点击
-(void)didfootBut:(NSString *)_id
{
   

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
