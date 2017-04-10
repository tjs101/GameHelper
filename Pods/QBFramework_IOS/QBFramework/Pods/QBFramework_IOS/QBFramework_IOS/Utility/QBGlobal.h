//
//  QBGlobal.h
//  QBFramework
//
//  Created by quentin on 16/7/21.
//  Copyright © 2016年 Quentin. All rights reserved.
//

#import <Foundation/Foundation.h>

extern  NSString  *const WifiAvailableNotification;/**<使用wifi连接*/
extern  NSString  *const WwanAavailableNotification;/**<使用2g/3g 连接*/
extern  NSString  *const NetworkUnavailableNotification;/**<未有网络*/


@interface QBGlobal : NSObject

@property (nonatomic, assign)  BOOL  wifiAvailable;
@property (nonatomic, assign)  BOOL  networkAvailable;

+ (QBGlobal *)sharedInstance;

- (void)startNetworkNotifer;//开始监听
- (void)stopNetworkNotifer;//停止监听


@end
