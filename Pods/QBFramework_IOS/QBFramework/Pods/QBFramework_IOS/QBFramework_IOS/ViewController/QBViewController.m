//
//  QBViewController.m
//  QBFramework
//
//  Created by quentin on 16/7/21.
//  Copyright © 2016年 Quentin. All rights reserved.
//

#import "QBViewController.h"
#import "QBConfig.h"
#import "QBSystem.h"

@interface QBViewController ()

@end

@implementation QBViewController
@synthesize navigationTitle;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
        [self setEdgesForExtendedLayout:UIRectEdgeNone];
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (self.viewName) {
        [QBSystem beginLogPageView:self.viewName];
    }
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    if (self.viewName) {
        [QBSystem endLogPageView:self.viewName];
    }
}

- (void)setNavigationTitle:(NSString *)aNavigationTitle
{
    navigationTitle = aNavigationTitle;
    
    SET_NAVIGATION_TITLE(navigationTitle);
}

- (void)dealloc
{
    NSLog(@"viewController dealloc %@", NSStringFromClass([self class]));
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
