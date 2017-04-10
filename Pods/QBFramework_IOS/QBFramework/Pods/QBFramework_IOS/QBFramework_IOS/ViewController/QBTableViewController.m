//
//  QBTableViewController.m
//  QBFramework
//
//  Created by quentin on 16/7/11.
//  Copyright © 2016年 Quentin. All rights reserved.
//

#import "QBTableViewController.h"


@interface QBTableViewController ()

{
    BOOL  _loading;
    UITableViewStyle _style;
    
    UIButton *_touchButton;
}

@end

@implementation QBTableViewController

@synthesize hasPullRefresh;
@synthesize loadMoreCell;
@synthesize hasLoadMoreView;
@synthesize tableView;

- (id)initWithStyle:(UITableViewStyle)style
{
    if (self = [super init]) {
        _style = style;
    }
    return self;
}

- (id)init
{
    if (self = [super init]) {
        _style = UITableViewStylePlain;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view.
    
    CGFloat tabbar = 0;
    
    if (!self.hidesBottomBarWhenPushed) {
        tabbar = 49;
    }
    

    CGFloat topOff = 0;
#ifdef __IPHONE_7_0
    topOff = 64;
#endif
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - tabbar - topOff) style:_style];
    tableView.backgroundColor = [UIColor clearColor];
    tableView.backgroundView = nil;
    tableView.separatorColor = [UIColor clearColor];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    tableView.tableFooterView = [[UIView alloc] init];
    
    if (hasPullRefresh) {
        __block __weak  QBTableViewController  *unsafeSelf = self;
        [self.tableView addPullToRefreshWithActionHandler:^{
            [unsafeSelf triggerPullToRefresh];
        }];
    }
    
    if (hasLoadMoreView) {
        QBLoadMoreCell  *moreCell = [[QBLoadMoreCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"QBLoadMoreCell"];
        moreCell.delegate = self;
        self.loadMoreCell = moreCell;
    }

}

#pragma mark -  UIScrollView delegate

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if ([self isLoadMoreViewNeeded]) {
        
        [self.loadMoreCell loadMoreScrollViewDidEndDragging:scrollView];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if ([self isLoadMoreViewNeeded]) {
        
        [self.loadMoreCell loadMoreScrollViewDidEndDragging:scrollView];
    }
}

#pragma mark -   QBLoadMoreCell delegate

- (void)loadMoreViewCellDidTriggerLoad:(QBLoadMoreCell *)cell
{
    [self triggerLoadMore];
}

- (BOOL)loadMoreViewCellDataSourceIsLoading:(QBLoadMoreCell *)cell
{
    return _loading;
}

#pragma mark - override

- (void)pullToRefresh
{
    if (!self.hasPullRefresh) {
        
        return;
    }
    
    [self.tableView reloadData];
    
    [self.tableView triggerPullToRefresh];
}

- (void)reloadView
{
    _loading = NO;
    
    [self.tableView.pullToRefreshView stopAnimating];
    
    if ([self isLoadMoreViewNeeded]) {
        
        [self.loadMoreCell loadMoreScrollViewDataSourceDidFinishedLoading:self.tableView];
    }
    
    [self.tableView reloadData];
}

- (BOOL)isLoadMoreViewNeeded
{
    return NO;
}

- (void)triggerLoadMore
{
    
}

- (void)triggerPullToRefresh
{
    
}

- (BOOL)nullData
{
    return NO;
}

#pragma mark - UITableView

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}

@end
