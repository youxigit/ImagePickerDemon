//
//  ViewController.m
//  DQImagePicker
//
//  Created by leon on 14-8-18.
//  Copyright (c) 2014年 com.xdd. All rights reserved.
//

#import "ViewController.h"


@interface ViewController ()

@end

@implementation ViewController
@synthesize pictureCapture;
@synthesize videoCapture;

@synthesize image;

#pragma mark - Dealloc
-(void)dealloc
{
    image = nil;
}

#pragma mark - View LifeCircle
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

#pragma mark - UIButton Action
-(IBAction)buttonAction:(id)sender
{
    if (sender == pictureCapture) {
        if ([self checkPhotoLibraryAuthorization]) {
            DQImagePickerController * imagePicker = [[DQImagePickerController alloc]initWithNibName:@"DQImagePickerController" bundle:nil];
            imagePicker.delegate = self;
            [self presentViewController:imagePicker animated:YES completion:^{
                
            }];
        }
    }
    
    if (sender == videoCapture) {
        [self checkCameraAuthorization];
    }
}

#pragma mark Private Method
-(BOOL)checkCameraAuthorization
{
    __block BOOL isAvalible = YES;
    //ios 7.0以上的系统新增加摄像头权限检测
    if ([[[UIDevice currentDevice]systemVersion]floatValue] >= 7.0) {
        //获取对摄像头的访问权限。
        AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
        switch (authStatus) {
            case AVAuthorizationStatusRestricted://此应用程序没有被授权访问的照片数据。可能是家长控制权限。
                NSLog(@"Restricted");
                break;
            case AVAuthorizationStatusDenied://用户已经明确否认了这一照片数据的应用程序访问.
                NSLog(@"Denied");
                isAvalible = NO;
                break;
            case AVAuthorizationStatusAuthorized://用户已授权应用访问照片数据.
                NSLog(@"Authorized");
                break;
            case AVAuthorizationStatusNotDetermined://用户尚未做出了选择这个应用程序的问候,向用户发起请求。
                [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
                    if(granted){
                        NSLog(@"Granted access to %@", AVMediaTypeVideo);
                    }
                    else {
                        isAvalible = NO;
                    }
                }];
                break;
            default:
                break;
        }
    }
    if (!isAvalible) {
        UIAlertView *errorAlert = [[UIAlertView alloc] initWithTitle:@"" message:@"您关闭了搜狐社区的相机权限，无法进行拍照。可以在手机 > 设置 > 隐私 > 相机中开启权限。" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [errorAlert show];
        errorAlert = nil;
    }
    
    return isAvalible;
}

-(BOOL)checkPhotoLibraryAuthorization
{
    BOOL isAvalible = YES;

    //获取对图库的访问权限。
    ALAuthorizationStatus authStatus = [ALAssetsLibrary authorizationStatus];
    switch (authStatus) {
        case ALAuthorizationStatusRestricted:
            NSLog(@"Restricted");
            break;
        case ALAuthorizationStatusDenied:
            NSLog(@"Denied");
            isAvalible = NO;
            break;
        case ALAuthorizationStatusAuthorized:
            NSLog(@"Authorized");
            break;
        case ALAuthorizationStatusNotDetermined:{
            isAvalible =[UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];
        }break;
            
        default:
            break;
    }

    if (!isAvalible) {
        UIAlertView *errorAlert = [[UIAlertView alloc] initWithTitle:@"" message:@"您关闭了搜狐社区的相机权限，无法进行拍照。可以在手机 > 设置 > 隐私 > 相机中开启权限。" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [errorAlert show];
        errorAlert = nil;
    }
    
    return isAvalible;
}

#pragma mark - DQImagePickerController Delegate
-(void)imagePickerController:(DQImagePickerController*)picker didFinishPickingWithImages:(NSArray*)results
{
    [results enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        UIImage * image = (UIImage*)obj;
        NSLog(@"the %d image is :%@",idx,[image description]);
    }];
    [picker dismissViewControllerAnimated:YES completion:^{
        
    }];
}

-(void)imagePickerControllerDidCancel:(DQImagePickerController*)picker
{
    [picker dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
