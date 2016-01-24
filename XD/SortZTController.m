//
//  SortZTController.m
//  XD
//
//  Created by 李攀祥 on 16/1/18.
//  Copyright © 2016年 李攀祥. All rights reserved.
//

#import "SortZTController.h"
#import "SegementView.h"
#import "SortViewController.h"
#import "ZhuanTiController.h"
#import "XFSortDetailController.h"

#import "SumSortController.h"
@interface SortZTController ()<UIScrollViewDelegate>
@property(nonatomic,strong) SegementView *sege;
@property(nonatomic,strong) UIScrollView * bgScrollerView;
@property (nonatomic,strong)SortViewController * sortController;
@property (nonatomic,strong) ZhuanTiController * zhuanTiController;
@end

@implementation SortZTController

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置导航栏和背景颜色
    [self creatNavAndBg];
    [self.view addSubview:self.bgScrollerView];

}

#pragma mark-设置导航栏
-(void)creatNavAndBg
{    //标题按钮
    self.navigationItem.titleView=self.sege;
    //点击标题按钮的回调
    __weak typeof(self) wself = self;
    self.sege.selectBlock=^(int number)
    {
        [wself butToPage:number];
    };
    //左边返回按钮
    [self setHtBut];
    
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

#pragma mark-懒加载
-(SegementView *)sege
{
    if (!_sege)
    {
        _sege=[[SegementView alloc] initWithFrame:CGRectMake(0, 0, 140*View_Radio,40) TitleArr:@[@"分类",@"专题"]];
    }
    return _sege;
}

-(UIScrollView *)bgScrollerView
{
    if (!_bgScrollerView)
    {
        _bgScrollerView =[[UIScrollView alloc] initWithFrame:CGRectMake(0, Nav_Height, Screen_Width, Screen_Height-Nav_Height)];
        _bgScrollerView.showsVerticalScrollIndicator=NO;
        _bgScrollerView.showsHorizontalScrollIndicator=NO;
        self.automaticallyAdjustsScrollViewInsets=NO;
        _bgScrollerView.pagingEnabled=YES;
        _bgScrollerView.bounces=NO;
        _bgScrollerView.delegate=self;
        _bgScrollerView.backgroundColor=[UIColor clearColor];
        _bgScrollerView.contentOffset=CGPointMake(0, 0);
        [_bgScrollerView addSubview:self.sortController.view];
        [_bgScrollerView addSubview:self.zhuanTiController.view];
        _bgScrollerView.contentSize=CGSizeMake(Screen_Width*2,0);
    }
    return _bgScrollerView;
}

-(SortViewController *)sortController
{
    if (!_sortController)
    {
        _sortController=[[SortViewController alloc] init];
        __weak typeof(self)Wself=self;
        _sortController.cellBlock=^(NSString * _id,NSString * name)
        {
            [Wself didFLCell:_id title:name];
        };
        _sortController.view.frame = CGRectMake(0, 0, _bgScrollerView.frame.size.width, _bgScrollerView.frame.size.height);
    }
    return _sortController;
}

-(ZhuanTiController *)zhuanTiController
{
    if (!_zhuanTiController)
    {
        _zhuanTiController=[[ZhuanTiController alloc] init];
        _zhuanTiController.view.frame=CGRectMake(Screen_Width, 0, _bgScrollerView.frame.size.width, _bgScrollerView.frame.size.height);
        __weak typeof (self)Wself=self;
        _zhuanTiController.sectionHeadBlock=^(ZhuTiZu * model)
        {
            //sectionHead 共8部 点击事件
            [Wself didSectionHead:model];
        };
        _zhuanTiController.didCellBlock=^(NSString * _id)
        {
            [Wself didZTCellID:_id];
        };
    }
    return _zhuanTiController;
}
#pragma mark - 点击 分类界面的cell
/*!
 *  一月新番等 分类cell的点击事件
 */
-(void)didFLCell:(NSString *)_id title:(NSString *)title
{
    XFSortDetailController * svc=[[XFSortDetailController alloc] init];
    svc.name=title;
    svc._id=_id;
    [self.navigationController pushViewController:svc animated:YES];
}

#pragma mark-专题--cell
-(void)didZTCellID:(NSString *)_id
{
    NSLog(@"点击专题界面cell");
    self.animeDetailId=_id;
}

#pragma mark-点击专题界面section头部的 点击事件
/*!
 * 共多少部分动漫
 */
-(void)didSectionHead:(ZhuTiZu *)model
{
    SumSortController * ssc=[[SumSortController alloc] init];
    ssc.ZTModel=model;
    [self.navigationController pushViewController:ssc animated:YES];
};

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
