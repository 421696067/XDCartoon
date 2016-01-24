//
//  ParentViewController.m
//  XD
//
//  Created by 李攀祥 on 16/1/6.
//  Copyright © 2016年 李攀祥. All rights reserved.
//

#import "ParentViewController.h"
#import "AnimaDetailController.h"
@interface ParentViewController ()<UIGestureRecognizerDelegate>
@end

@implementation ParentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置背景
    [self creatBG];
    
   
}
#pragma mark- 设置导航栏的标题
-(void)setTitleView:(NSString *)title textColor:(UIColor *)color
{
    UILabel * label =[Factory creatLabelFont:14*View_Radio Alignment:NSTextAlignmentCenter textColor:color bgColor:[UIColor clearColor] autoLine:NO];
    label.frame=CGRectMake(0, 0,200*View_Radio, 40);
    label.text=title;
    self.navigationItem.titleView=label;
}
#pragma mark-左边的返回按钮
-(void)setHtBut
{
    UIBarButtonItem * item = [[UIBarButtonItem alloc]initWithImage:imageRender(@"ht") style:UIBarButtonItemStylePlain target:self   action:@selector(backBut)];
    self.navigationItem.leftBarButtonItem=item;
}
-(void)backBut
{
    [self.navigationController popViewControllerAnimated:YES];
}


-(void)setIsBckView:(BOOL)isBckView
{
//    if (isBckView ==YES)
//    {
//        UIView * back=[[UIView alloc] init];
//        back.backgroundColor=[UIColor blackColor];
//        back.alpha=0.3;
//        [self.view addSubview:back];
//        [back mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.left.bottom.right.equalTo(self.view).insets(UIEdgeInsetsMake(0, 0, 0, 0));
//        }];
//    }
}

-(void)creatBG
{
    UIImageView * bg= [[UIImageView alloc]initWithImage:imageRender(@"bgbg")];
    [self.view addSubview:bg];
    [bg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(self.view).insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    
    UIView * back=[[UIView alloc] init];
    back.backgroundColor=[UIColor blackColor];
    back.alpha=0.3;
    [self.view addSubview:back];
    [back mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(self.view).insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];

}

/*!
 * item Image
 */
#pragma mark-设置左右item
-(void)setLeft:(BOOL)isLeft ImageName:(NSString * )imageName target:(id)target select:(SEL)select
{  //设置左Item
    UIBarButtonItem * item = [[UIBarButtonItem alloc]initWithImage:imageRender(imageName) style:UIBarButtonItemStylePlain target:target action:select];
    if (isLeft)
    {
        self.navigationItem.leftBarButtonItem=item;
    }else
    {
        self.navigationItem.rightBarButtonItem=item;
    }
}

/*!
 * item Image+title
 */
-(void)setImageAndTitleLeft:(BOOL)isLeft ImageName:(NSString *)imageName andTitle:(NSString *)title target:(id)target select:(SEL)select
{
    //TODO: 自定义导航栏的item（有文字和图片）
    UIView * view=[[UIView alloc] init];
    
    //图像
    UIImageView * icon=[[UIImageView alloc] init];
    icon.image=imageRender(imageName);
    
    //文字
    UILabel * label=[[UILabel alloc] init];
    label.text=title;
    
    //背景的透明按钮
    UIButton * backBut=[UIButton buttonWithType:UIButtonTypeCustom];
    [backBut setTitle:@"" forState:UIControlStateNormal];
    [backBut addTarget:target action:select  forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:icon];
    [view addSubview:label];
    [view addSubview:backBut];
    
    [icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(0);
        //设置图像的高
        make.height.mas_equalTo(30);
    }];
    
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(0);
        //设置文字的高
        make.height.mas_equalTo(16);
    }];
    
    //整个视图的宽高
    view.frame=CGRectMake(0, 0,80*View_Radio,46);
    
    UIBarButtonItem * item =[[UIBarButtonItem alloc] initWithCustomView:view];
    
    if (isLeft)
    {
        self.navigationItem.leftBarButtonItem=item;
    }else
    {
        self.navigationItem.rightBarButtonItem=item;
    }
}



#pragma mark-动画详情界面的id 的set方法
-(void)setAnimeDetailId:(NSString *)animeDetailId
{
    AnimaDetailController   * avc=[[AnimaDetailController alloc] init];
    avc._id=animeDetailId;
    [self.navigationController pushViewController:avc animated:YES];
}
@end
