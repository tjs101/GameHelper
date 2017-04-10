//
//  QBTableViewController.h
//  QBFramework
//
//  Created by quentin on 16/7/11.
//  Copyright © 2016年 Quentin. All rights reserved.
//

#import "QBViewController.h"
#import "QBLoadMoreCell.h"
#import <SVPullToRefresh/SVPullToRefresh.h>

@interface QBTableViewController : QBViewController <UITableViewDataSource, UITableViewDelegate, QBLoadMoreCellDelegate>

- (id)initWithStyle:(UITableViewStyle)style;

@property (nonatomic, strong)  UITableView *tableView;

@property (nonatomic, assign, readwrite) BOOL hasPullRefresh;
@property (nonatomic, assign, readwrite) BOOL hasLoadMoreView;
@property (nonatomic, strong) QBLoadMoreCell  *loadMoreCell;

- (void)reloadView;//刷新数据
- (void)pullToRefresh;//下拉数据

- (void)triggerPullToRefresh;
- (void)triggerLoadMore;

- (BOOL)isLoadMoreViewNeeded;//是否还有更多数据

- (BOOL)nullData;//网络获取数据成功，但数据为空

@end
