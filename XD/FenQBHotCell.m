//
//  FenQBHotCell.m
//  XD
//
//  Created by 李攀祥 on 16/1/29.
//  Copyright © 2016年 李攀祥. All rights reserved.
//

#import "FenQBHotCell.h"
#import "FenQBHotView.h"
#define FQViewWidth 145*View_Radio
#define FQViewHeight 150*View_Radio
@interface FenQBHotCell()
@end

@implementation FenQBHotCell

- (void)awakeFromNib {
    for (int i=0; i<4; i++)
    {
        FenQBHotView * fqView=[FenQBHotView  fenQBView];
        fqView.frame=CGRectMake(10*View_Radio+(10+145)*View_Radio * (i%2), 5*View_Radio+(150+10)*View_Radio,FQViewWidth , FQViewHeight);
        fqView.block=^(NSString * _id){
            self.block(_id);
        };
        [self.contentView addSubview:fqView];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
