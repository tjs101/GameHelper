//
//  QBSystem.m
//  QBFramework
//
//  Created by quentin on 16/7/21.
//  Copyright © 2016年 Quentin. All rights reserved.
//

#import "QBSystem.h"
#import <MBProgressHUD/MBProgressHUD.h>
#include <sys/types.h>
#include <sys/sysctl.h>
#import <Photos/Photos.h>
#import <CoreLocation/CoreLocation.h>
#import <FCUUID/FCUUID.h>
#import "TalkingData.h"
#import "QBManagerConfig.h"
#import "QBSettings.h"

@implementation QBSystem

#pragma mark - 设备相关

+ (NSString *)model
{
    return [[UIDevice currentDevice] model];
}

+ (NSString *)spec
{
    size_t size;
    sysctlbyname("hw.machine", NULL, &size, NULL, 0);
    char *machine = (char*)malloc(size);
    sysctlbyname("hw.machine", machine, &size, NULL, 0);
    NSString *platform = [NSString stringWithCString:machine encoding:NSUTF8StringEncoding];
    free(machine);
    
    return platform;
}

+ (NSString *)systemName
{
    return [[UIDevice currentDevice] systemName];
}

+ (NSString *)deviceName
{
    return [[UIDevice currentDevice] name];
}

+ (NSString *)systemVersion
{
    return [[UIDevice currentDevice] systemVersion];
}

+ (NSString *)bundleBuildVersion
{
    return [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleVersion"];
}

+ (NSString *)bundleVersion
{
    return [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
}

+ (NSString *)appName
{
    return [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleDisplayName"];
}

#pragma mark - 相机、相册权限

+ (BOOL)photoAuthorizationStatus
{
    PHAuthorizationStatus author = [PHPhotoLibrary authorizationStatus];
    if (author == kCLAuthorizationStatusRestricted ||
        author == kCLAuthorizationStatusDenied) {
        
        [QBSystem showAlertTitle:@"提示" message:@"查看相册权限被禁止，请前往[设置]-[隐私]-[照片]中，允许每市APP使用相册服务"];
        return NO;
    }
    return YES;
}

+ (BOOL)cameraAuthorizationStatus
{
#if TARGET_IPHONE_SIMULATOR
    [QBSystem showAlertMessage:@"模拟器不支持"];
    return NO;
#else
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if (authStatus == AVAuthorizationStatusRestricted ||
        authStatus == AVAuthorizationStatusDenied) {
        
        [QBSystem showAlertTitle:@"提示" message:@"使用相机权限被禁止，请前往[设置]-[隐私]-[相机]中，允许每市APP使用相机服务"];
        return NO;
    }
    return YES;
#endif
}

#pragma mark - 时间格式

+ (NSDateFormatter *)dateFormatter
{
    static NSDateFormatter *_dateFormatter = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _dateFormatter = [[NSDateFormatter alloc] init];
    });
    
    return _dateFormatter;
}

#pragma mark - 设备的唯一标记
+ (NSString *)idfa
{
    return [FCUUID uuidForDevice];
}

#pragma mark - track

+ (void)analyticsAssert
{
    QBManagerConfig *config = [QBManagerConfig sharedConfig];
    
    NSString *appKey = config.analyticsAppKey;
    
    NSAssert(appKey != nil, @"使用统计前需要设置appkey");
}

+ (void)startAnalytics
{
    [QBSystem analyticsAssert];
    
    [TalkingData setSignalReportEnabled:YES];
    [TalkingData setExceptionReportEnabled:YES];
    
#if DEBUG
    [TalkingData sessionStarted:[QBManagerConfig sharedConfig].analyticsAppKey withChannelId:@"DEBUG"];
#else
    [TalkingData sessionStarted:[QBManagerConfig sharedConfig].analyticsAppKey withChannelId:nil];
#endif
}

+ (void)beginLogPageView:(NSString *)viewName
{
    [QBSystem analyticsAssert];
    
    [TalkingData trackPageBegin:viewName];
}

+ (void)endLogPageView:(NSString *)viewName
{
    [QBSystem analyticsAssert];
    
    [TalkingData trackPageEnd:viewName];
}

+ (void)trackEvent:(NSString *)event
{
    [QBSystem analyticsAssert];
    
    [TalkingData trackEvent:event];
}

#pragma mark - 评论
+ (void)appReviewAppId:(NSString *)appId
{
    NSAssert(appId == nil, @"评论id不能为空");
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"itms-apps://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=%@", appId]]];
}

+ (void)checkAppId:(NSString *)appId completionHandler:(void (^)(NSString *))handler
{
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSString *urlStr = [NSString stringWithFormat:@"http://itunes.apple.com/lookup?id=%@", appId];
    
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (error == nil) {
            
            id value = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:NULL];
            if ([value isKindOfClass:[NSDictionary class]]) {
                
                NSDictionary *dict = (NSDictionary *)value;
                
                value = [dict objectForKey:@"results"];
                if ([value isKindOfClass:[NSArray class]]) {
                    
                    dict = [value firstObject];
                    
                    NSString *version = [dict objectForKey:@"version"];
                    
                    [QBSettings sharedInstance].appUpdateVersion = version;
                    
                    if (handler) {
                        handler(version);
                    }
                }
                
            }
        }
        
    }];
    [dataTask resume];
}

#pragma mark - Progress

+ (void)showProgressText:(NSString *)progress
{
    [self showProgressText:progress afterDelay:1];
}

+ (void)showProgressText:(NSString *)progress afterDelay:(NSTimeInterval)delay
{
    if ([UIApplication sharedApplication].keyWindow == nil) {
        return;
    }
    
    MBProgressHUD *progressHud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
    progressHud.mode = MBProgressHUDModeText;
    progressHud.detailsLabel.text = progress;
    [progressHud hideAnimated:YES afterDelay:delay];
}

#pragma mark - alert view
+ (UIViewController *)topViewController
{
    UIWindow *window = [[UIApplication sharedApplication] keyWindow] ? : [[[UIApplication sharedApplication] windows] lastObject];
    UIViewController *rootViewController = window.rootViewController;
    UIViewController *topViewController = rootViewController;
    while (topViewController != nil) {
        
        if (topViewController.navigationController)
        {
            topViewController = topViewController.navigationController.topViewController;
        }
        
        if (topViewController.presentedViewController == nil)
        {
            break;
        }
        
        topViewController = topViewController.presentedViewController;
    }
    
    return topViewController;
}

+ (void)showAlertMessage:(NSString *)message
{
    if ([QBSystem topViewController]) {
        [self showAlertTitle:@"提示" message:message];
    }
}

+ (void)showAlertTitle:(NSString *)title message:(NSString *)message
{
    if ([QBSystem topViewController]) {
        [self showAlertTitle:title message:message singleButtonTitle:@"确定"];
    }
}

+ (void)showAlertTitle:(NSString *)title message:(NSString *)message singleButtonTitle:(NSString *)singleButtonTitle confirm:(void (^)())confirm
{
    if ([message isKindOfClass:[NSString class]]) {
        
        if (message.length != 0) {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                UIAlertController *alertCtrl = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
                
                UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:singleButtonTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    
                    if (confirm) {
                        confirm();
                    }
                    
                }];
                
                [alertCtrl addAction:confirmAction];
                
                [[QBSystem topViewController] presentViewController:alertCtrl animated:YES completion:NULL];
            });
            
            
        }
        
    }
    
    
}

+ (void)showAlertTitle:(NSString *)title message:(NSString *)message singleButtonTitle:(NSString *)singleButtonTitle
{
    [QBSystem showAlertTitle:title message:message singleButtonTitle:singleButtonTitle confirm:NULL];
    
}

+ (void)showAlertTitle:(NSString *)title message:(NSString *)message confirm:(void (^)(BOOL))confirm
{
    if ([QBSystem topViewController]) {
        [self showAlertTitle:title message:message confirmTitle:@"确定" confirm:confirm];
    }
}

+ (void)showAlertTitle:(NSString *)title message:(NSString *)message confirmTitle:(NSString *)confirmTitle confirm:(void (^)(BOOL confirm))confirm
{
    if ([QBSystem topViewController]) {
        [self showAlertTitle:title message:message cancelTitle:@"取消" confirmTitle:confirmTitle confirm:confirm];
    }
}

+ (void)showAlertMessage:(NSString *)message confirm:(void (^)(BOOL confirm))confirm
{
    if ([QBSystem topViewController]) {
        [self showAlertTitle:@"提示" message:message confirm:confirm];
    }
}

+ (void)showAlertTitle:(NSString *)title message:(NSString *)message cancelTitle:(NSString *)cancelTitle confirmTitle:(NSString *)confirmTitle confirm:(void (^)(BOOL))confirm
{
    
    if ([message isKindOfClass:[NSString class]]) {
        
        if (message.length != 0) {
            dispatch_async(dispatch_get_main_queue(), ^{
                UIAlertController *alertCtrl = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
                
                UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancelTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                    if (confirm) {
                        confirm(NO);
                    }
                }];
                UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:confirmTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    if (confirm) {
                        confirm(YES);
                    }
                }];
                
                [alertCtrl addAction:cancelAction];
                [alertCtrl addAction:confirmAction];
                
                [[QBSystem topViewController] presentViewController:alertCtrl animated:YES completion:NULL];
            });
        }
        
    }
    
}

#pragma mark - registerForRemoteNotifications

+ (void)registerForRemoteNotifications
{
#if !TARGET_IPHONE_SIMULATOR
    
    UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:
                                            (
                                             UIUserNotificationTypeAlert |
                                             UIUserNotificationTypeBadge |
                                             UIUserNotificationTypeSound
                                             ) categories:nil];
    
    [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
    [[UIApplication sharedApplication] registerForRemoteNotifications];
    
#endif
}

@end
