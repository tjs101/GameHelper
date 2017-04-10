//
//  GHVideoItem.h
//  GameHelper
//
//  Created by quentin on 2017/4/10.
//  Copyright © 2017年 Quentin. All rights reserved.
//

#import <Realm/Realm.h>

@interface GHVideoItem : RLMObject

@property (nonatomic, copy) NSString *videoLength;/**<时间*/
@property (nonatomic, copy) NSString *videoOnYouKuUrl;/**<视频地址*/
@property (nonatomic, copy) NSString *videoScreenShot;/**<图片*/
@property (nonatomic, copy) NSString *videoid;/**<id*/
@property (nonatomic, copy) NSString *videoName;/**<视频名字*/
@property (nonatomic, copy) NSString *videoUpdateDate;/**<更新时间*/

@end
