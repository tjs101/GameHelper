//
//  QBLoadMoreCell.h
//  QBFramework
//
//  Created by quentin on 15/3/12.
//  Copyright (c) 2015年 Quentin. All rights reserved.
//

#import <UIKit/UIKit.h>
@class QBLoadMoreCell;
@protocol  QBLoadMoreCellDelegate<NSObject>

- (void)loadMoreViewCellDidTriggerLoad:(QBLoadMoreCell *)cell;
- (BOOL)loadMoreViewCellDataSourceIsLoading:(QBLoadMoreCell *)cell;
@end

@interface QBLoadMoreCell : UITableViewCell

@property   (nonatomic, weak) id<QBLoadMoreCellDelegate>  delegate;

//@property (nonatomic,copy)NSString *loadingTitle;

- (void)loadMoreScrollViewDidEndDragging:(UIScrollView *)scrollView;

// Tell load more view to end
- (void)loadMoreScrollViewDataSourceDidFinishedLoading:(UIScrollView *)scrollView;

+ (CGFloat)height;

@end
