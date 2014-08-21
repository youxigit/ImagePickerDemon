//
//  AssetsHelper.m
//  DQImagePicker
//
//  Created by leon on 14-8-19.
//  Copyright (c) 2014年 com.xdd. All rights reserved.
//

#import "AssetsHelper.h"
static AssetsHelper * assetsHelper = nil;

@implementation AssetsHelper

#pragma mark - Dealloc
-(void)dealloc
{
    assetsHelper = nil;
    _assetsLibrary = nil;
}

#pragma mark - Singleton
+(AssetsHelper*)shareAssetsHelper
{
    @synchronized(self){
        if (assetsHelper == nil) {
            assetsHelper = [[AssetsHelper alloc]init];
        }
        return assetsHelper;
    }
}

#pragma mark - Init
-(id)init
{
    self = [super init];
    if (self) {
        _assetsLibrary = [[ALAssetsLibrary alloc]init];
    }
    return self;
}

#pragma mark - Getter

#pragma mark - Method
-(void)groups:(void(^)(NSArray* groups))result
{
    _assetGroups = [[NSMutableArray alloc]init];
    [_assetsLibrary enumerateGroupsWithTypes:ALAssetsGroupAll usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
        if (*stop == NO && group != nil) {
            [_assetGroups addObject:group];
        }else{
            result(_assetGroups);
        }
    } failureBlock:^(NSError *error) {
        result(nil);
    }];
}

-(void)photosOfAllGroup:(void(^)(NSArray* photos))results
{
      _assetPhotos = [[NSMutableArray alloc]init];
    [self groups:^(NSArray *groups) {
        [groups enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            ALAssetsGroup * group = (ALAssetsGroup*)obj;
            if (*stop == YES) {
                 results(_assetPhotos);
            }
            [group setAssetsFilter:[ALAssetsFilter allPhotos]];
            [group enumerateAssetsUsingBlock:^(ALAsset *result, NSUInteger index, BOOL *stop) {
                if (result == nil) {
                    
                }else{
                    [_assetPhotos addObject:result];
                }
            }];
        }];
    }];
}

-(UIImage*)imageAtIndex:(NSInteger)row type:(NSInteger)resourceType;
{
    CGImageRef imageRef = nil;
    ALAsset * asset = [_assetPhotos objectAtIndex:row];
    switch (resourceType) {
        case ASSET_PHOTO_THUMBNAIL:
            imageRef = [asset thumbnail];
            break;
        case ASSET_PHOTO_SCREEN_SIZE:
            imageRef = [asset.defaultRepresentation fullScreenImage];
            break;
        case ASSET_PHOTO_FULL_RESOLUTION://此处省略
        default:
            break;
    }
    return [UIImage imageWithCGImage:imageRef];
}

-(void)photosOfGroup:(ALAssetsGroup *)group results:(ALAssetsEnumerationResultsBlock)results
{
    
}

@end
