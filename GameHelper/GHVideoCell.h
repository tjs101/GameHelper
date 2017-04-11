//
//  GHVideoCell.h
//  GameHelper
//
//  Created by quentin on 2017/4/10.
//  Copyright © 2017年 Quentin. All rights reserved.
//


#import <UIKit/UIKit.h>
#import <QBFramework_IOS/QBTableViewCell.h>
#import "GHVideoView.h"

@interface GHVideoCell : QBTableViewCell

@property (nonatomic, strong) GHVideoView *leftView;/**<GHVideoView*/
@property (nonatomic, strong) GHVideoView *rightView;/**<GHVideoView*/

+ (CGFloat)height;

@end
