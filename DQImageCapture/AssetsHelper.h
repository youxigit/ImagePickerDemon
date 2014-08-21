//
//  AssetsHelper.h
//  DQImagePicker
//
//  Created by leon on 14-8-19.
//  Copyright (c) 2014年 com.xdd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AssetsLibrary/AssetsLibrary.h>

typedef void(^ALAssetsEnumerationResultsBlock)(NSArray*result);

#define ASSET_PHOTO_THUMBNAIL           0
#define ASSET_PHOTO_SCREEN_SIZE         1
#define ASSET_PHOTO_FULL_RESOLUTION     2

@interface AssetsHelper : NSObject

@property (nonatomic, strong) ALAssetsLibrary * assetsLibrary;
@property (nonatomic, strong) NSMutableArray * assetPhotos;
@property (nonatomic, strong) NSMutableArray * assetGroups;

+(AssetsHelper*)shareAssetsHelper;
-(void)photosOfGroup:(ALAssetsGroup*)group results:(ALAssetsEnumerationResultsBlock)results;

-(void)groups:(void(^)(NSArray* groups))result;
-(void)photosOfAllGroup:(void(^)(NSArray* photos))results;
/**
 * @param resourceType 资源类型 缩略图、完全分辨率、全屏图
 */
-(UIImage*)imageAtIndex:(NSInteger)row type:(NSInteger)resourceType;


@end
