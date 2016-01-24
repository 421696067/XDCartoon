//
//  FenQHeadSection.m
//  XD
//
//  Created by 李攀祥 on 16/1/12.
//  Copyright © 2016年 李攀祥. All rights reserved.
//

#import "FenQHeadSection.h"
@interface FenQHeadSection ()
@property(nonatomic,strong)UILabel * label;
@end

@implementation FenQHeadSection
-(void)setModel:(FenQvZu *)model
{
    _model=model;
    self.label.text=model.name;
}
-(id)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame])
    {
        [self addSubview:self.label];
        [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.mas_centerY).offset(0);
            make.left.mas_equalTo(10*View_Radio);
            make.top.mas_equalTo(5*View_Radio);
        }];
        
    }
    return self;
}

-(UILabel *)label
{
    if (!_label)
    {
        _label=[[UILabel alloc] init];
        _label.textColor=[UIColor blackColor ];
        _label.font=Font(14*View_Radio);
        _label.textAlignment=NSTextAlignmentCenter;
    }
    return _label;
}
@end
