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
    
    CGSize size = [GHVideoView videoSize];
    
    // left
    _leftView = [[GHVideoView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    [self.contentView addSubview:_leftView];
    
    // right
    _rightView = [[GHVideoView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    [self.contentView addSubview:_rightView];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat x = 0, y = 0;
    
    // left view
    x = (CGRectGetWidth(self.frame) - [GHVideoView videoSize].width * 2) / 4;
    
    CGRect rect = _leftView.frame;
    rect.origin.x = x;
    rect.origin.y = y;
    _leftView.frame = rect;
    
    // right
    x = CGRectGetMaxX(rect) + x * 2;
    
    rect = _rightView.frame;
    rect.origin.x = x;
    rect.origin.y = y;
    _rightView.frame = rect;
}

+ (CGFloat)height
{
    return [GHVideoView videoSize].height;
}

@end
