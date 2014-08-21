//
//  SpPhotoCell.m
//  club
//
//  Created by leon on 14-2-24.
//  Copyright (c) 2014年 xdd. All rights reserved.
//

#import "PhotoCell.h"

@implementation PhotoCell
@synthesize ivSelectBg;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelectMode:(BOOL)bSelect
{
    if (bSelect)
        ivSelectBg.hidden = NO;
    else
        ivSelectBg.hidden = YES;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
