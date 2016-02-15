//
//  NoAdressView.m
//  XD
//
//  Created by 李攀祥 on 16/1/28.
//  Copyright © 2016年 李攀祥. All rights reserved.
//

#import "NoAdressView.h"

@implementation NoAdressView

-(id)init
{
    if (self=[super init])
    {
        self=[[[NSBundle mainBundle] loadNibNamed:@"NoAdressView" owner:nil options:nil] lastObject];
    }
    return self;
}
@end
