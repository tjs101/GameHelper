//
//  QBSettings.h
//  QBFramework
//
//  Created by quentin on 16/7/21.
//  Copyright © 2016年 Quentin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QBSettings : NSObject

// override
- (void)saveValue:(id)value;
- (id)valueForQBKey:(NSString *)QBkey;

@end
