#import "SumSortHead.h"
#import "ZhuTiModel.h"

#define iconHeadHeight 150*View_Radio
@interface SumSortHead ()
{
    float _HeadViewheight;//头部视图的高度
}
@property (nonatomic,strong)UIImageView * iconImage;//头部图片
@property(nonatomic,strong)UILabel * introLabel;//详情介绍
@property (nonatomic,strong)UIView* line;//下划分割线
@property (nonatomic,strong)UIView * backView;//下面文字的背景图片
@end

@implementation SumSortHead
-(void)jSheight
{
    self.jsBlock(_HeadViewheight);
}

-(void)setModel:(ZhuTiZu *)model
{
    _model=model;
    [self.iconImage sd_setImageWithURL:[NSURL URLWithString:model.url]];
     self.introLabel.text = model.intro;
    //TODO: 怎么让系统通过约束自动算出headView的高度啊
    //计算headView的高度
    CGSize size=[self.introLabel.text sizeWithFont:Font(14*View_Radio) maxSize:CGSizeMake(Screen_Width-2*10*View_Radio, MAXFLOAT)];
    _HeadViewheight =iconHeadHeight +2*View_Radio+size.height+2*View_Radio+11*View_Radio;
}

-(id)init
{
    if (self=[super init])
    {
        //self.backgroundColor=[UIColor redColor];
        [self addSubview:self.backView];

        [self addSubview:self.iconImage];
        [self addSubview:self.introLabel];
        [self addSubview:self.line];
        
        [self.iconImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.mas_equalTo(0);
            make.height.mas_equalTo(iconHeadHeight);
        }];
        
        [self.introLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10*View_Radio);
            make.right.mas_equalTo(-10*View_Radio);
            make.top.mas_equalTo(self.iconImage.mas_bottom).offset(2*View_Radio);
         }];
        
        [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.left.right.mas_equalTo(0);
            
        }];
        
        [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.self.introLabel.mas_bottom).offset(5*View_Radio);
            make.height.mas_equalTo(1*View_Radio);
            make.left.mas_equalTo(10*View_Radio);
            make.right.mas_equalTo(-10*View_Radio);
        }];
        
        

    }
    return self;
}


-(UIImageView *)iconImage
{
    if (!_iconImage)
    {
        _iconImage=[[UIImageView alloc] init];
    }
    return _iconImage;
}

-(UILabel *)introLabel
{
    if (!_introLabel) {
        _introLabel=[UILabel new];
        _introLabel.textColor=[UIColor colorWithHexString:@"FFFFFF"];
        _introLabel.numberOfLines = 0;
        _introLabel.textAlignment = NSTextAlignmentCenter;
        _introLabel.font=Font(14*View_Radio);
    }
    return _introLabel;
}

-(UIView *)line
{
    if (!_line) {
        _line=[[UIView alloc] init];
        _line.backgroundColor =[UIColor colorWithHexString:@"D4D4D4" ];
    }
    return _line;
}

-(UIView *)backView
{
    if (!_backView) {
        _backView=[[UIView alloc] init];
        _backView.backgroundColor=[UIColor colorWithHexString:@"D4D4D4"];
        _backView.alpha=0.5;
    }
    return _backView;
}

@end
