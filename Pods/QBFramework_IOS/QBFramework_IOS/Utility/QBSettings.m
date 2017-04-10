//
//  QBSettings.m
//  QBFramework
//
//  Created by quentin on 16/7/21.
//  Copyright © 2016年 Quentin. All rights reserved.
//

#import "QBSettings.h"

@implementation QBSettings

+ (QBSettings *)sharedInstance
{
    static QBSettings *_settings = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _settings = [[QBSettings alloc] init];
    });
    return _settings;
}

- (void)saveValue:(id)value
{
    if (value) {
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject:value forKey:[NSString stringWithFormat:@"QBFramework.%@", value]];
        [defaults synchronize];
    }
    
}

- (id)valueForQBKey:(NSString *)QBkey
{
    if (QBkey) {
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        return [defaults objectForKey:[NSString stringWithFormat:@"QBFramework.%@", QBkey]];
    }
    return nil;
}

@end
