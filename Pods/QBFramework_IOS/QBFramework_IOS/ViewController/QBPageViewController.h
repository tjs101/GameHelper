//
//  QBPageViewController.h
//  QBFramework
//  
//  Created by quentin on 2016/12/20.
//  Copyright © 2016年 quentin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QBPageViewController : UIPageViewController

- (instancetype)initWithSubViewControllers:(NSArray<UIViewController *>*)subViewControllers titles:(NSArray <NSString *>*)titles selectedIndex:(NSInteger)selectedIndex;//subViewControllers为子视图数组，selectedIndex为默认首选项

@property (nonatomic, assign) BOOL tabRootViewController;/**<是否为tab根视图,默认为NO>*/

@end
