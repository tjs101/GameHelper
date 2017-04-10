//
//  GHVideoCell.m
//  GameHelper
//
//  Created by quentin on 2017/4/10.
//  Copyright © 2017年 Quentin. All rights reserved.
//

#import "GHVideoCell.h"

@implementation GHVideoCell

- (void)customInit
{
    [super customInit];
    
    // left
    _leftView = [[GHVideoView alloc] init];
    [self.contentView addSubview:_leftView];
    
    // right
    _rightView = [[GHVideoView alloc] init];
    [self.contentView addSubview:_rightView];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
}

@end
