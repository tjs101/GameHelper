//
//  GHTaskHomeViewController.m
//  GameHelper
//
//  Created by quentin on 2017/4/10.
//  Copyright © 2017年 Quentin. All rights reserved.
//

#import "GHTaskHomeViewController.h"
#import <QBFramework_IOS/QBTableViewCell.h>
#import <BmobSDK/Bmob.h>
#import <Realm/Realm.h>
#import <QBFramework_IOS/UILabel+Font.h>
#import <QBFrameworkLib.h>

@interface GHTaskItem : RLMObject

@property (nonatomic, copy) NSString *title;/**<标题*/
@property (nonatomic, copy) NSString *date;/**<时间*/
@property (nonatomic, assign) double taskId;/**<id*/

@property (nonatomic, copy) NSString *url;/**<web地址*/

@end

@implementation GHTaskItem

- (NSString *)url
{
    return @"http://www.baidu.com";
}

@end

#define kTitleFont  [UIFont systemFontOfSize:14]
#define kLeftGap    15
#define kTopGap     10

@interface GHTaskViewCell : QBTableViewCell

{
    UILabel   *_titleLabel;
    UILabel   *_dateLabel;
}

@property (nonatomic, strong) GHTaskItem *item;
@end

@implementation GHTaskViewCell


- (void)customInit
{
    // title
    _titleLabel = [UILabel initWithFont:kTitleFont textColor:colorFromRGB(0x131313)];
    _titleLabel.numberOfLines = 0;
    [self.contentView addSubview:_titleLabel];
    
    // date
    _dateLabel = [UILabel initWithFont:kTitleFont textColor:colorFromRGB(0x838383)];
    [self.contentView addSubview:_dateLabel];
}

- (void)setItem:(GHTaskItem *)item
{
    _item = item;
    
    [self setNeedsLayout];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    _titleLabel.text = _item.title;
    _dateLabel.text = _item.date;
    
    [_titleLabel sizeToFit];
    [_dateLabel sizeToFit];
    
    CGFloat x = 0, y = 0;
    
    // title
    x = kLeftGap;
    y = kTopGap;
    
    CGSize size = [GHTaskViewCell sizeWithTitle:_titleLabel.text];
    
    _titleLabel.frame = CGRectMake(x, y, size.width, size.height);
    
    // date
    y = CGRectGetMaxY(_titleLabel.frame) + 5;
    _dateLabel.frame = CGRectMake(x, y, CGRectGetWidth(_dateLabel.frame), CGRectGetHeight(_dateLabel.frame));
}

+ (CGSize)sizeWithTitle:(NSString *)title
{
    if (title.length == 0) {
        return CGSizeZero;
    }
    
    CGSize size = [title boundingRectWithSize:CGSizeMake(kScreenWidth - kLeftGap * 2, MAXFLOAT) options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : kTitleFont} context:NULL].size;
    return size;
}

+ (CGFloat)heightWithItem:(GHTaskItem *)item
{
    CGFloat height = 0;
    
    height += kTopGap;
    
    // title
    height += [GHTaskViewCell sizeWithTitle:item.title].height;
    height += 5;
    
    // date
    height += [GHTaskViewCell sizeWithTitle:item.date].height;
    height += kTopGap;
    
    return height;
}

@end

@interface GHTaskHomeViewController ()

@property (nonatomic, strong)  NSMutableArray *items;
@end

@implementation GHTaskHomeViewController

- (void)viewDidLoad {
    
    self.hasPullRefresh = YES;
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.items = [NSMutableArray array];
    
    [self pullToRefresh];
}

#pragma mark - pull

- (void)triggerPullToRefresh
{
    [self requestTaskDataWithPage:0];
}

#pragma mark - request

- (void)requestTaskDataWithPage:(NSInteger)page
{
    BmobQuery *query = [BmobQuery queryWithClassName:@"StrategyList"];
    query.skip = page;
    [query findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
        NSLog(@"array ====%@", array);
        if (error == nil) {
            
            if (page == 0) {
                
                [self.items removeAllObjects];
            }
            
            for (BmobObject *object in array) {
                
                GHTaskItem *item = [[GHTaskItem alloc] init];
                item.title = [object objectForKey:@"title"];
                item.date = [object objectForKey:@"date"];
                item.taskId = [[object objectForKey:@"id"] doubleValue];
                [self.items addObject:item];
            }
            
        }
        
        [self reloadView];
        
    }];
}

#pragma mark - null data

- (BOOL)nullData
{
    return [self.items count] == 0;
}

#pragma mark - UITableView

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *reuseIdentifier = @"cell";
    
    GHTaskViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (cell == nil) {
        cell = [[GHTaskViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    }
    
    GHTaskItem *item = [self.items objectAtIndex:indexPath.row];
    cell.item = item;
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.items count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    GHTaskItem *item = [self.items objectAtIndex:indexPath.row];
    return [GHTaskViewCell heightWithItem:item];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if ([self nullData]) {
        return;
    }
    
    GHTaskItem *item = [self.items objectAtIndex:indexPath.row];
    
    QBWebViewController *viewCtrl = [[QBWebViewController alloc] initWithURL:[NSURL URLWithString:item.url]];
    viewCtrl.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:viewCtrl animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
