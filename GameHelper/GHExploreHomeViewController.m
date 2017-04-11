//
//  GHExploreHomeViewController.m
//  GameHelper
//
//  Created by quentin on 2017/4/10.
//  Copyright © 2017年 Quentin. All rights reserved.
//

#import "GHExploreHomeViewController.h"
#import "GHExploreListViewController.h"

@interface GHExploreHomeViewController ()

@end

@implementation GHExploreHomeViewController

- (instancetype)init
{
    NSArray *titles = @[@"头条" ,@"网游" ,@"手游" ,@"主机" ,
                        @"电竞" ,@"科技" ,@"动漫" ,@"影视" ,
                        @"产业" ,@"点评"];
    
    NSMutableArray *viewCtrls = [NSMutableArray array];
    
    for (NSString *title in titles) {
        
        GHExploreListViewController *viewCtrl = [[GHExploreListViewController alloc] initWithTitle:title];
        [viewCtrls addObject:viewCtrl];
    }
    
    if (self = [super initWithSubViewControllers:viewCtrls titles:titles selectedIndex:0]) {
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
