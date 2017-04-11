//
//  QBPageViewController.m
//  QBFramework
//
//  Created by quentin on 2016/12/20.
//  Copyright © 2016年 quentin. All rights reserved.
//

#import "QBPageViewController.h"
#import "QBConfig.h"

#define kTitleFont  [UIFont systemFontOfSize:14]

typedef void(^QBPageNavigationDidClickAtIndex)(NSInteger clickAtIndex);

@interface QBPageNavigation : UIView

{
    NSArray  *_titles;
    
    UIButton *_selectedBtn;
    
    NSMutableArray  *_titleSizes;
}

- (instancetype)initWithTitles:(NSArray <NSString *>*)titles;

@property (nonatomic, copy) QBPageNavigationDidClickAtIndex clickAtIndex;

- (void)scrollToIndex:(NSInteger)index;

@end

@implementation QBPageNavigation

- (instancetype)initWithTitles:(NSArray<NSString *> *)titles
{
    _titleSizes = [NSMutableArray arrayWithCapacity:[titles count]];
    
    __block CGFloat totalWidth = 0;// 总宽度
    
    [titles enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        CGSize size = [obj sizeWithAttributes:@{NSFontAttributeName : kTitleFont}];
        CGFloat width = size.width + 16;
        
        [_titleSizes addObject:@(width)];
        
        totalWidth += width;
    }];
    
    if (self = [super initWithFrame:CGRectMake(0, 0, totalWidth, 44)]) {
        _titles = [NSArray arrayWithArray:titles];
        
        [self customInit];
    }
    return self;
}

- (void)customInit
{
    NSInteger index = 0;
    CGFloat offsetX = 0;
    
    for (NSString *title in _titles) {
        
        CGFloat width = [[_titleSizes objectAtIndex:index] floatValue];
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.tag = index;
        [btn setTitle:title forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        btn.titleLabel.font = kTitleFont;
        btn.titleLabel.textAlignment = NSTextAlignmentCenter;
        [btn addTarget:self action:@selector(onTitleClick:) forControlEvents:UIControlEventTouchUpInside];
        [btn sizeToFit];
        btn.frame = CGRectMake(offsetX, 0, width, CGRectGetHeight(self.frame));
        [self addSubview:btn];
        
        index ++;
        offsetX += width;
    }
}

#pragma mark - on click

- (void)onTitleClick:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    
    _selectedBtn = btn;
    
    if (self.clickAtIndex) {
        self.clickAtIndex(btn.tag);
    }
}

- (void)scrollToIndex:(NSInteger)index
{
    
}

@end

@interface QBPageViewController () <UIPageViewControllerDelegate, UIPageViewControllerDataSource>

{
    NSInteger   _selectedIndex;
}

@property (nonatomic, strong) NSArray<UIViewController *> *subViewControllers;/**<子视图数组*/
@property (nonatomic, strong) NSArray<NSString *> *titles;/**<标题数组*/

@property (nonatomic, strong) QBPageNavigation *pageNavigation;
@end

@implementation QBPageViewController

- (instancetype)init
{
    if (self = [super initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil]) {
        
    }
    return self;
}

- (instancetype)initWithSubViewControllers:(NSArray<UIViewController *> *)aSubViewControllers titles:(NSArray<NSString *> *)aTitles selectedIndex:(NSInteger)selectedIndex
{
    if (self = [super initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil]) {
        self.subViewControllers = [NSArray arrayWithArray:aSubViewControllers];
        self.titles = [NSArray arrayWithArray:aTitles];
        _selectedIndex = selectedIndex;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    self.navigationItem.titleView = self.pageNavigation;
    
    self.delegate = self;
    self.dataSource = self;
    
    NSAssert([self.subViewControllers count] == [self.titles count], @"视图数组和标题数组大小不一致");
    
    UIViewController *viewCtrl = [self.subViewControllers objectAtIndex:_selectedIndex >= [self.subViewControllers count] ? 0 : _selectedIndex];
    
    [self setViewControllers:@[viewCtrl]
                   direction:UIPageViewControllerNavigationDirectionForward
                    animated:YES
                  completion:nil];
}

- (QBPageNavigation *)pageNavigation
{
    if (_pageNavigation == nil) {
        
        _pageNavigation = [[QBPageNavigation alloc] initWithTitles:_titles];
        
        __weak typeof (self) weakSelf = self;
        
        _pageNavigation.clickAtIndex = ^(NSInteger clickAtIndex) {
            [weakSelf navigationTitleClickAtIndex:clickAtIndex];
        };
        
    }
    return _pageNavigation;
}

#pragma mark - UIPageViewControllerDelegate

- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    NSInteger index = [self.subViewControllers indexOfObject:viewController];
    if(index == 0 || index == NSNotFound) {
        return [self.subViewControllers objectAtIndex:[self.subViewControllers count] - 1];
    }
    
    return [self.subViewControllers objectAtIndex:index - 1];
}

- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    NSInteger index = [self.subViewControllers indexOfObject:viewController];
    if(index == NSNotFound || index == self.subViewControllers.count - 1) {
        return [self.subViewControllers objectAtIndex:0];
    }
    return [self.subViewControllers objectAtIndex:index + 1];
}

- (void)pageViewController:(UIPageViewController *)pageViewController
        didFinishAnimating:(BOOL)finished
   previousViewControllers:(NSArray *)previousViewControllers
       transitionCompleted:(BOOL)completed {
    
    UIViewController *viewCtrl = [self.viewControllers firstObject];
    NSUInteger index = [self.subViewControllers indexOfObject:viewCtrl];
    [_pageNavigation scrollToIndex:index];
}

#pragma mark - click at index

- (void)navigationTitleClickAtIndex:(NSInteger)clickAtIndex
{
    if (_selectedIndex == clickAtIndex) {// 点击当前所选项
        id subViewCtrl = [self.subViewControllers objectAtIndex:clickAtIndex];
        if ([subViewCtrl isKindOfClass:[UIViewController class]]) {
            
            UIViewController *viewCtrl = (UIViewController *)subViewCtrl;
            
            if ([viewCtrl respondsToSelector:@selector(refreshView)]) {
                [viewCtrl performSelector:@selector(refreshView)];
            }
        }
        
    }
    else {
        UIPageViewControllerNavigationDirection direction = _selectedIndex < clickAtIndex ? UIPageViewControllerNavigationDirectionForward : UIPageViewControllerNavigationDirectionReverse;
        
        [self setViewControllers:@[[self.subViewControllers objectAtIndex:clickAtIndex]] direction:direction animated:YES completion:nil];
    }
    
    _selectedIndex = clickAtIndex;
    
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
