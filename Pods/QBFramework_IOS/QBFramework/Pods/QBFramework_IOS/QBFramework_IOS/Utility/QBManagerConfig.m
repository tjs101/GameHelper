//
//  QBManagerConfig.m
//  Pods
//
//  Created by quentin on 2017/4/10.
//
//

#import "QBManagerConfig.h"

@implementation QBManagerConfig

+ (QBManagerConfig *)sharedConfig
{
    static QBManagerConfig *_sharedConfig = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedConfig = [[QBManagerConfig alloc] init];
    });
    
    return _sharedConfig;
}

@end
