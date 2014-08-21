//
//  DQImagePickerController.m
//  DQImagePicker
//
//  Created by leon on 14-8-19.
//  Copyright (c) 2014年 com.xdd. All rights reserved.
//

#import "DQImagePickerController.h"
#import "AssetsHelper.h"
#import "PhotoCell.h"
#import <AssetsLibrary/AssetsLibrary.h>

@interface DQImagePickerController (){

    NSMutableArray * _displayPhotos;
}
@end

@implementation DQImagePickerController
@synthesize selectAlbumBtn;
@synthesize selectedCountLab;
@synthesize okBtn;
@synthesize cancleBtn;
@synthesize bottomMenuView;

#pragma mark - Dealloc
-(void)dealloc
{
    
}

#pragma mark - Init
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

#pragma mark - View LifeCircle
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _selectedPhotos = [[NSMutableDictionary alloc]init];
    UINib * nib = [UINib nibWithNibName:@"PhotoCell" bundle:nil];
    [_photosCollectionView registerNib:nib forCellWithReuseIdentifier:@"PhotoCell"];
    [_photosCollectionView setDelegate:self];
    [_photosCollectionView setDataSource:self];
    [[AssetsHelper shareAssetsHelper] photosOfAllGroup:^(NSArray *photos) {
        [_photosCollectionView reloadData];
    }];
}

#pragma mark - UICollection DataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [[AssetsHelper shareAssetsHelper] assetPhotos].count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    PhotoCell *cell = (PhotoCell *)[_photosCollectionView dequeueReusableCellWithReuseIdentifier:@"PhotoCell" forIndexPath:indexPath];
    cell.ivPhoto.image = [[AssetsHelper shareAssetsHelper]imageAtIndex:indexPath.row type:ASSET_PHOTO_THUMBNAIL];//此处是生产缩略图，否则开销很大卡顿明显。
    if (_selectedPhotos[@(indexPath.row)] == nil) {
        [cell setSelectMode:NO];
    }else{
        [cell setSelectMode:YES];
    }
    return cell;
}

#pragma mark - UICollectionView Delegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    PhotoCell *cell = (PhotoCell *)[collectionView cellForItemAtIndexPath:indexPath];
    if ((_selectedPhotos[@(indexPath.row)] == nil))
    {
        // select
        _selectedPhotos[@(indexPath.row)] = @(_selectedPhotos.count);
        [cell setSelectMode:YES];
    }
    else
    {
        // unselect
        [_selectedPhotos removeObjectForKey:@(indexPath.row)];
        [cell setSelectMode:NO];
    }
}

#pragma mark - BottomMenu Action
-(IBAction)buttonClick:(id)sender
{
    if (sender == cancleBtn) {
        [self.delegate imagePickerControllerDidCancel:self];
    }
    if (sender == okBtn) {
        NSMutableArray * results = [[NSMutableArray alloc]init];
        NSArray * keys = [_selectedPhotos keysSortedByValueUsingSelector:@selector(compare:)];
        
        for (int i = 0 ; i < _selectedPhotos.count; i++) {
            UIImage * image = [[AssetsHelper shareAssetsHelper]imageAtIndex:[keys[i] integerValue] type:ASSET_PHOTO_SCREEN_SIZE];
            [results addObject:image];
        }
        [self.delegate imagePickerController:self didFinishPickingWithImages:results];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
