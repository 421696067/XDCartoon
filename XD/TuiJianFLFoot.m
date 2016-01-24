//
//  TuiJianFLFoot.m
//  XD
//
//  Created by 李攀祥 on 16/1/10.
//  Copyright © 2016年 李攀祥. All rights reserved.
//

#import "TuiJianFLFoot.h"
@interface TuiJianFLFoot ()
@property(nonatomic,strong)UIButton *but;
@end
@implementation TuiJianFLFoot

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
      
        [self addSubview:self.but];
        [self crearLayout];
    }
    return self;
}
-(void)crearLayout
{
    [self.but mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(10*View_Radio);
        make.bottom.mas_equalTo(-10*View_Radio);
        make.left.mas_equalTo(10*View_Radio);
        make.right.mas_equalTo(-10*View_Radio);
    }];
}

- (void)awakeFromNib {
}

-(UIButton *)but
{
    if (!_but)
    {
        _but=[UIButton buttonWithType:UIButtonTypeCustom];
        [_but setBackgroundImage:imageRender(@"butMore") forState:UIControlStateNormal];
        [_but addTarget:self action:@selector(butclick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _but;
}

-(void)butclick
{
    self.block();
}
@end
