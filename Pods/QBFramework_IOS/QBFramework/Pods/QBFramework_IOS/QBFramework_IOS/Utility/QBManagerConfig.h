//
//  QBManagerConfig.h
//  Pods
//
//  Created by quentin on 2017/4/10.
//
//

#import <Foundation/Foundation.h>

@interface QBManagerConfig : NSObject

+ (QBManagerConfig *)sharedConfig;

// talkingData统计使用
@property (nonatomic, copy) NSString *analyticsAppKey;/**<统计appkey*/
@property (nonatomic, copy) NSString *channelId;/**<统计渠道号，默认nil为App Store*/

@end
