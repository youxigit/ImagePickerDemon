//
//  DQImgePickerController.h
//  DQImagePicker
//
//  Created by leon on 14-8-19.
//  Copyright (c) 2014年 com.xdd. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol DQImagePickerControllerDelegate;

@interface DQImagePickerController : UIViewController<UICollectionViewDataSource,UICollectionViewDelegate>

@property (nonatomic, assign) id<DQImagePickerControllerDelegate> delegate;

@property (nonatomic, strong) IBOutlet UICollectionView * photosCollectionView;

@property (nonatomic, strong) NSMutableDictionary * selectedPhotos;

//bottom
@property (weak, nonatomic) IBOutlet UIView             *bottomMenuView;
@property (weak, nonatomic) IBOutlet UIButton           *selectAlbumBtn;
@property (weak, nonatomic) IBOutlet UIButton           *okBtn;
@property (weak, nonatomic) IBOutlet UIButton           *cancleBtn;

@property (weak, nonatomic) IBOutlet UILabel            *selectedCountLab;
@property (weak, nonatomic) IBOutlet UIImageView        *selectedMarkImageView;

-(IBAction)buttonClick:(id)sender;

@end

@protocol DQImagePickerControllerDelegate <NSObject>
@optional
-(void)imagePickerController:(DQImagePickerController*)picker didFinishPickingWithImages:(NSArray*)results;
-(void)imagePickerControllerDidCancel:(DQImagePickerController*)picker;

@end
