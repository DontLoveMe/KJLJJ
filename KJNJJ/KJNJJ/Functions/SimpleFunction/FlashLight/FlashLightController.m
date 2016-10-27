//
//  FlashLightController.m
//  KJNJJ
//
//  Created by coco船长 on 2016/10/27.
//  Copyright © 2016年 nevermore. All rights reserved.
//

#import "FlashLightController.h"

@interface FlashLightController ()

@end

@implementation FlashLightController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.translucent = NO;
    //创建子视图
    [self initViews];

    
}

- (void)initViews{

    //手电筒开关
    UIButton *switchButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    switchButton.frame = CGRectMake(0, 40.f, KScreenWidth, 40.f);
    [switchButton setTitle:@"开启" forState:UIControlStateNormal];
    [switchButton setTitle:@"关闭" forState:UIControlStateSelected];
    [switchButton addTarget:self
                     action:@selector(switchAction:)
           forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:switchButton];
    
    //自适应开关
    UIButton *autoSwitch = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    autoSwitch.frame = CGRectMake(0, 120.f, KScreenWidth, 40.f);
    [autoSwitch setTitle:@"开启自动(根据环境亮度判断)" forState:UIControlStateNormal];
    [autoSwitch setTitle:@"关闭自动" forState:UIControlStateSelected];
    [autoSwitch addTarget:self
                     action:@selector(autoSwitchAction:)
           forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:autoSwitch];
    
}

//开启/关闭闪光灯
- (void)switchAction:(UIButton *)button{

    Class captureDeviceClass = NSClassFromString(@"AVCaptureDevice");
    if (captureDeviceClass != nil) {
        AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
        if ([device hasTorch] && [device hasFlash]){

            [device lockForConfiguration:nil];
            if (button.selected == 0) {
                [device setTorchMode:AVCaptureTorchModeOn];
                [device setFlashMode:AVCaptureFlashModeOn];
                button.selected = 1;
            } else {
                [device setTorchMode:AVCaptureTorchModeOff];
                [device setFlashMode:AVCaptureFlashModeOff];
                button.selected = 0;
            }
            [device unlockForConfiguration];
        }else{
            
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"温馨提示"
                                                  
                                                                                     message:@"当前闪光灯不可用" preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"好"
                                                                   style:UIAlertActionStyleDefault
                                                                 handler:^(UIAlertAction * _Nonnull action)
                                           
                                           {
                                               [alertController dismissViewControllerAnimated:YES
                                                                                   completion:nil];
                                           }];
            
            [alertController addAction:cancelAction];
            [self presentViewController:alertController
                               animated:YES
                             completion:nil];
        
        }
        
    }

}

//开启/关闭自动
- (void)autoSwitchAction:(UIButton *)button{
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"温馨提示"
                                          
                                                                             message:@"该功能尚在研究"
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"好"
                                                           style:UIAlertActionStyleDefault
                                                         handler:^(UIAlertAction * _Nonnull action)
                                   
                                   {
                                       [alertController dismissViewControllerAnimated:YES
                                                                           completion:nil];
                                   }];
    
    [alertController addAction:cancelAction];
    [self presentViewController:alertController
                       animated:YES
                     completion:nil];

}

- (void)captureOutput:(AVCaptureOutput *)captureOutput
didOutputSampleBuffer:(CMSampleBufferRef)sampleBuffer
       fromConnection:(AVCaptureConnection *)connection
{
    CFDictionaryRef metadataDict = CMCopyDictionaryOfAttachments(NULL,
                                                                 sampleBuffer, kCMAttachmentMode_ShouldPropagate);
    NSDictionary *metadata = [[NSMutableDictionary alloc]
                              initWithDictionary:(__bridge NSDictionary*)metadataDict];
    CFRelease(metadataDict);
    NSDictionary *exifMetadata = [[metadata
                                   objectForKey:(NSString *)kCGImagePropertyExifDictionary] mutableCopy];
    float brightnessValue = [[exifMetadata
                              objectForKey:(NSString *)kCGImagePropertyExifBrightnessValue] floatValue];
    
    //    Class captureDeviceClass = NSClassFromString(@"AVCaptureDevice");
    //    if (captureDeviceClass != nil) {
    //        AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    //        if ([device hasTorch] && [device hasFlash]){
    //
    //            [device lockForConfiguration:nil];
    //            if (isSuccess) {
    //                [device setTorchMode:AVCaptureTorchModeOn];
    //                [device setFlashMode:AVCaptureFlashModeOn];
    //                isSuccess = YES;
    //            } else {
    //                [device setTorchMode:AVCaptureTorchModeOff];
    //                [device setFlashMode:AVCaptureFlashModeOff];
    //                isSuccess = NO;
    //            }
    //            [device unlockForConfiguration];
    //        }
    //    }
    
}

@end
