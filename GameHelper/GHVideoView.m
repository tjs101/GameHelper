//
//  GHVideoView.m
//  GameHelper
//
//  Created by quentin on 2017/4/10.
//  Copyright © 2017年 Quentin. All rights reserved.
//

#import "GHVideoView.h"
#import <QBFramework_IOS/UILabel+Font.h>
#import <QBFramework_IOS/QBConfig.h>
#import <SDWebImage/UIImageView+WebCache.h>

@interface GHVideoView ()

{
    UIImageView  *_imageView;
    UILabel      *_titleLabel;
}

@end

@implementation GHVideoView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self customInit];
    }
    return self;
}

- (void)customInit
{
    // imageview
    _imageView = [[UIImageView alloc] init];
    [self addSubview:_imageView];
    
    // title
    _titleLabel = [UILabel initWithFont:[UIFont systemFontOfSize:14] textColor:[UIColor whiteColor]];
    [self addSubview:_titleLabel];
}

- (void)setItem:(GHVideoItem *)item
{
    _item = item;
    
    [self setNeedsLayout];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [_imageView sd_setImageWithURL:[NSURL URLWithString:_item.videoScreenShot] placeholderImage:nil];
    _titleLabel.text = _item.videoName;
    
    [_imageView sizeToFit];
    [_titleLabel sizeToFit];
    
    CGFloat x = 0, y = 0;
    
    // imageview
    _imageView.frame = CGRectMake(x, y, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame));
    
    // title
    y = CGRectGetMaxY(_imageView.frame);
    _titleLabel.frame = CGRectMake(x, y, CGRectGetWidth(_imageView.frame), 0);
}

@end
