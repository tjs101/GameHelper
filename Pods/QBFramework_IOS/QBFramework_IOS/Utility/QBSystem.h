//
//  QBSystem.h
//  QBFramework
//
//  Created by quentin on 16/7/21.
//  Copyright © 2016年 Quentin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface QBSystem : NSObject

#pragma mark - 设备信息相关
+ (NSString *)model;//返回如 "iPhone", "iPod touch" 的字符串
+ (NSString *)spec;// 返回型号，行如 "iPhone3,1" 的字符串
+ (NSString *)systemName;// 返回行如 "iOS" 的字符串
+ (NSString *)deviceName;// 返回行如 "My Iphone" 的字符串
+ (NSString *)systemVersion;
+ (NSString *)bundleBuildVersion;//build version
+ (NSString *)bundleVersion;//
+ (NSString *)appName;

#pragma mark - 相机、相册权限

+ (BOOL)photoAuthorizationStatus;

+ (BOOL)cameraAuthorizationStatus;

#pragma mark - 时间格式

+ (NSDateFormatter *)dateFormatter;

#pragma mark - 设备的唯一标记
+ (NSString *)idfa;

#pragma mark - track(需要继承)
+ (void)startAnalytics;
+ (void)beginLogPageView:(NSString *)viewName;
+ (void)endLogPageView:(NSString *)viewName;
+ (void)trackEvent:(NSString *)event;

#pragma mark - 评论
+ (void)appReviewAppId:(NSString *)appId;

#pragma mark - 检测最新版本
+ (void)checkAppId:(NSString *)appId completionHandler:(void (^) (NSString *updateAppId))handler;

#pragma mark - Progress
+ (void)showProgressText:(NSString *)progress;
+ (void)showProgressText:(NSString *)progress afterDelay:(NSTimeInterval)delay;

#pragma mark - alert view
+ (UIViewController *)topViewController;

+ (void)showAlertMessage:(NSString *)message;
+ (void)showAlertTitle:(NSString *)title message:(NSString *)message;

+ (void)showAlertTitle:(NSString *)title message:(NSString *)message singleButtonTitle:(NSString *)singleButtonTitle;
+ (void)showAlertTitle:(NSString *)title message:(NSString *)message singleButtonTitle:(NSString *)singleButtonTitle confirm:(void (^)())confirm;
+ (void)showAlertMessage:(NSString *)message confirm:(void (^)(BOOL confirm))confirm;
+ (void)showAlertTitle:(NSString *)title message:(NSString *)message confirm:(void (^)(BOOL confirm))confirm;
+ (void)showAlertTitle:(NSString *)title message:(NSString *)message confirmTitle:(NSString *)confirmTitle confirm:(void (^)(BOOL confirm))confirm;

#pragma mark - registerForRemoteNotifications
+ (void)registerForRemoteNotifications;

@end
