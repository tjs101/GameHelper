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
    _imageView.layer.cornerRadius = 4;
    _imageView.layer.masksToBounds = YES;
    _imageView.layer.borderColor = colorFromRGB(0xacacac).CGColor;
    _imageView.layer.borderWidth = 1;
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
    _imageView.frame = CGRectMake(x, y, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame) - CGRectGetHeight(_titleLabel.frame) - 10);
    
    // title
    y = CGRectGetMaxY(_imageView.frame) + 5;
    _titleLabel.frame = CGRectMake(x, y, CGRectGetWidth(_imageView.frame), CGRectGetHeight(_titleLabel.frame));
}

+ (CGSize)videoSize
{
    CGFloat width = (kScreenWidth - 40) / 2;
    
    return CGSizeMake(width, width * 2 / 3);
}

@end
