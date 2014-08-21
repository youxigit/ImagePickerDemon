//
//  PhotoCell.h
//  club
//
//  Created by leon on 14-2-24.
//  Copyright (c) 2014年 xdd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhotoCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView    *ivPhoto;
@property (weak, nonatomic) IBOutlet UIImageView    *ivSelectBg;

- (void)setSelectMode:(BOOL)bSelect;

@end
