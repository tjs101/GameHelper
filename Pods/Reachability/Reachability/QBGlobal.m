//
//  QBGlobal.m
//  QBFramework
//
//  Created by quentin on 16/7/21.
//  Copyright © 2016年 Quentin. All rights reserved.
//

#import "QBGlobal.h"
#import "Reachability.h"

NSString  *const WifiAvailableNotification = @"WifiAvailableNotification";//使用wifi连接
NSString  *const WwanAavailableNotification = @"WwanAavailableNotification";//使用2g/3g 连接
NSString  *const NetworkUnavailableNotification = @"NetworkUnavailableNotification";//未有网络
@interface QBGlobal ()

@property (nonatomic, strong)  Reachability *reachability;
@end

@implementation QBGlobal
@synthesize reachability;
@synthesize wifiAvailable;
@synthesize networkAvailable;

+ (QBGlobal *)sharedInstance
{
    static QBGlobal  *sharedGlobal = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedGlobal = [[QBGlobal alloc] init];
    });
    return sharedGlobal;
}

- (void)startNetworkNotifer
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reachabilityChanged:) name:kReachabilityChangedNotification object:nil];
    
    self.reachability = [Reachability reachabilityForInternetConnection];
    [self.reachability startNotifier];
    
    [self updateNetworkWithReacchability:reachability];
}

- (void)stopNetworkNotifer
{
    if (self.reachability) {
        [self.reachability stopNotifier];
    }
}

- (void)reachabilityChanged:(NSNotification *)notification
{
    Reachability  *currentReachability = notification.object;
    
    [self updateNetworkWithReacchability:currentReachability];
}

- (void)updateNetworkWithReacchability:(Reachability *)currentReachility
{
    if (reachability == currentReachility) {
        
        NetworkStatus  status = [currentReachility currentReachabilityStatus];
        switch (status) {
            case ReachableViaWiFi:
                self.wifiAvailable = YES;
                self.networkAvailable = YES;
                [[NSNotificationCenter defaultCenter] postNotificationName:WifiAvailableNotification object:nil];
                break;
            case ReachableViaWWAN:
                self.wifiAvailable = NO;
                self.networkAvailable = YES;
                [[NSNotificationCenter defaultCenter] postNotificationName:WwanAavailableNotification object:nil];
                break;
            case NotReachable:
            default:
                self.wifiAvailable = NO;
                self.networkAvailable = NO;
                [[NSNotificationCenter defaultCenter] postNotificationName:NetworkUnavailableNotification object:nil];
                break;
        }
    }
}


@end
