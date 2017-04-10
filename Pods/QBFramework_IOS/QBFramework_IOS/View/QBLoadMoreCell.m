//
//  QBLoadMoreCell.m
//  QBFramework
//
//  Created by quentin on 15/3/12.
//  Copyright (c) 2015年 Quentin. All rights reserved.
//

#import "QBLoadMoreCell.h"

@interface QBLoadMoreCell ()

{
    UIActivityIndicatorView         *_indicatorView;
}

@end

@implementation QBLoadMoreCell
@synthesize delegate;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        [self customInit];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (void)customInit
{
    self.backgroundColor = [UIColor clearColor];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = self.contentView.bounds;
    button.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [button addTarget:self action:@selector(onTapped) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:button];
    
    UIActivityIndicatorView *indicator_view = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    _indicatorView = indicator_view;
    [self addSubview:indicator_view];
    self.textLabel.textAlignment = NSTextAlignmentCenter;
    self.textLabel.text = NSLocalizedString(@"更多", nil);
    self.textLabel.font = [UIFont systemFontOfSize:14];

}


- (void)layoutSubviews
{
    [super layoutSubviews];
    
    _indicatorView.frame = CGRectMake((self.frame.size.width - _indicatorView.frame.size.width)/2, (self.frame.size.height - _indicatorView.frame.size.height)/2, _indicatorView.frame.size.width, _indicatorView.frame.size.height);
}

- (void)onTapped
{
    BOOL _loading = NO;

    if ([delegate respondsToSelector:@selector(loadMoreViewCellDataSourceIsLoading:)]) {
        
        _loading = [delegate loadMoreViewCellDataSourceIsLoading:self];
    }
    
    if (!_loading) {
        
        [self doLoad];
    }
}

- (void)doLoad
{
    if ([delegate respondsToSelector:@selector(loadMoreViewCellDidTriggerLoad:)]) {
        
        self.textLabel.hidden = YES;
        [_indicatorView startAnimating];
        [delegate loadMoreViewCellDidTriggerLoad:self];
    }
}

- (void)loadMoreScrollViewDataSourceDidFinishedLoading:(UIScrollView *)scrollView
{
    self.textLabel.hidden = NO;
    [_indicatorView stopAnimating];
}

- (void)loadMoreScrollViewDidEndDragging:(UIScrollView *)scrollView
{
    BOOL _loading = NO;
    if ([delegate respondsToSelector:@selector(loadMoreViewCellDataSourceIsLoading:)]) {
        
        _loading = [delegate loadMoreViewCellDataSourceIsLoading:self];
    }
    
    if (scrollView.contentOffset.y >= scrollView.contentSize.height - scrollView.bounds.size.height - self.frame.size.height && !_loading) {
        
        [self doLoad];
    }
}

+ (CGFloat)height
{
    return 40;
}

@end
