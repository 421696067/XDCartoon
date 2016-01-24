//
//  ZhuTiCell.m
//  XD
//
//  Created by 李攀祥 on 16/1/19.
//  Copyright © 2016年 李攀祥. All rights reserved.
//

#import "ZhuTiCell.h"
#import "ZhuTiModel.h"
@interface ZhuTiCell()
@property (weak, nonatomic) IBOutlet UIView *bG;
@property (weak, nonatomic) IBOutlet UIImageView *iconImage;
@property (weak, nonatomic) IBOutlet UILabel *gxLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *titleLabelHeight;

@end
@implementation ZhuTiCell
-(void)setModel:(ZhuTiOne *)model
{
    _model=model;
    [self.iconImage sd_setImageWithURL:[NSURL URLWithString:model.url]];
    
    if ([model.onairEpNumber isEqualToString:model.totalEpCount] )
    {
        self.gxLabel.text = [NSString stringWithFormat:@"%@话全",model.totalEpCount];
    }else
    {
     self.gxLabel.text = [NSString stringWithFormat:@"更新至第%@话",model.onairEpNumber];}
    self.nameLabel.text = model.name;
}

- (void)awakeFromNib {
    
    self.bG.layer.masksToBounds=YES;
    self.bG.layer.cornerRadius=5.0f;
    self.bG.clipsToBounds=YES;
    
    self.titleLabelHeight.constant*=View_Radio;
    self.nameLabel.font=Font(12*View_Radio);
    self.gxLabel.font=Font(12*View_Radio);
}

@end
