//
//  ViewController.h
//  DQImagePicker
//
//  Created by leon on 14-8-18.
//  Copyright (c) 2014年 com.xdd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import <AVFoundation/AVFoundation.h>
#import "DQImagePickerController.h"

@interface ViewController : UIViewController<UIImagePickerControllerDelegate,UINavigationControllerDelegate,DQImagePickerControllerDelegate>

@property (nonatomic, strong) IBOutlet UIButton * pictureCapture;
@property (nonatomic, strong) IBOutlet UIButton * videoCapture;
@property (nonatomic, strong) IBOutlet UIImageView * image;

-(IBAction)buttonAction:(id)sender;

@end
