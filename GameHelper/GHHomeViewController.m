//
//  GHHomeViewController.m
//  GameHelper
//
//  Created by quentin on 2017/4/10.
//  Copyright © 2017年 Quentin. All rights reserved.
//

#import "GHHomeViewController.h"
#import <BmobSDK/Bmob.h>

@interface GHHomeViewController ()

@end

@implementation GHHomeViewController

- (void)viewDidLoad {
    
    self.hasPullRefresh = YES;
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.

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
    }];
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
