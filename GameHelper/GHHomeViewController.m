//
//  GHHomeViewController.m
//  GameHelper
//  不使用UICollectionViewController的原因大家猜
//  Created by quentin on 2017/4/10.
//  Copyright © 2017年 Quentin. All rights reserved.
//

#import "GHHomeViewController.h"
#import <BmobSDK/Bmob.h>
#import "GHVideoCell.h"

@interface GHHomeViewController ()

@property (nonatomic, strong)  NSMutableArray *latestItems;
@property (nonatomic, strong)  NSMutableArray *randomItems;
@property (nonatomic, strong)  NSMutableArray *recommodItems;

@end

@implementation GHHomeViewController

- (void)viewDidLoad {
    
    self.hasPullRefresh = YES;
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    // data items
    self.latestItems = [NSMutableArray array];
    self.randomItems = [NSMutableArray array];
    self.recommodItems = [NSMutableArray array];
    
    [self pullToRefresh];
}

#pragma mark - pull

- (void)triggerPullToRefresh
{
    [self requestVideoLatestData];
    [self requestVideoRandomData];
    [self requestVideoRecommodData];
}

#pragma mark - request video recommod

- (void)requestVideoRecommodData
{
    BmobQuery *query = [BmobQuery queryWithClassName:@"VideoRecommod"];
    query.limit = 6;
    [query findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
        NSLog(@"array %@", array);
        
        
    }];
}

- (void)requestVideoRandomData
{
    BmobQuery *query = [BmobQuery queryWithClassName:@"VideoRandom"];
    query.limit = 6;
    [query findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
        NSLog(@"array %@", array);
    }];
}

- (void)requestVideoLatestData
{
    BmobQuery *query = [BmobQuery queryWithClassName:@"VideoLatest"];
    query.limit = 6;
    [query findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
        NSLog(@"array %@", array);
        
        if (error == nil) {
            
            for (BmobObject *object in array) {
                
                GHVideoItem *item = [[GHVideoItem alloc] init];
                item.videoid = [object objectForKey:@"videoid"];
                item.videoName = [object objectForKey:@"videoName"];
                item.videoLength = [object objectForKey:@"videoLength"];
                item.videoOnYouKuUrl = [object objectForKey:@"videoOnYouKuUrl"];
                item.videoScreenShot = [object objectForKey:@"videoScreenShot"];
                item.videoUpdateDate = [object objectForKey:@"videoUpdateDate"];
                [self.latestItems addObject:item];
                
            }
            
        }
        
        [self reloadView];
    }];
}

#pragma mark - UITableView

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *reuseIdentifier = @"cell";
    
    GHVideoCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (cell == nil) {
        cell = [[GHVideoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    }
    
    
    
    NSInteger index = indexPath.row;
    
    if (index < [self.latestItems count]) {

        GHVideoItem *item = [self.latestItems objectAtIndex:index];
        cell.leftView.item = item;
    }
    
    index ++;
    if (index < [self.latestItems count]) {
        
        GHVideoItem *item = [self.latestItems objectAtIndex:index];
        cell.rightView.item = item;
    }
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return ([self.latestItems count] + 1) / 2;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
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
