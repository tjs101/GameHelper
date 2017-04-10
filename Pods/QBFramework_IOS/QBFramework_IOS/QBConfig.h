//
//  QBConfig.h
//  QBFramework
//
//  Created by quentin on 16/7/11.
//  Copyright © 2016年 Quentin. All rights reserved.
//

#ifndef QBConfig
#define QBConfig

//Log
#if DEBUG
    #define NSLog(format, ...) NSLog(@"\n文件: %@ \n方法: %s \n内容: %@ \n行数: %d", [[[NSString stringWithFormat:@"%s",__FILE__] componentsSeparatedByString:@"/"] lastObject],  __FUNCTION__, [NSString stringWithFormat:format, ##__VA_ARGS__], __LINE__);
#else
    #define NSLog(format,...)
#endif

// debug time
#ifdef DEBUG

#define DO_DEBUG_TIME_END(file, line)     { NSTimeInterval __debug_time_end = [[NSDate date] timeIntervalSince1970];\
NSLog(@"%@:%d: DEBUG TIME: %f", file, line, __debug_time_end - __debug_time_begin);}

#define DEBUG_TIME_BEGIN      NSTimeInterval __debug_time_begin = [[NSDate date] timeIntervalSince1970];
#define DEBUG_TIME_END        DO_DEBUG_TIME_END([[NSString stringWithUTF8String:__FILE__] lastPathComponent], __LINE__)

#define DO_PRINT_TIME(file, line)   NSLog(@"%@:%d: nowtime %f", file, line, [[NSDate date] timeIntervalSince1970]);
#define PRINT_TIME      DO_PRINT_TIME([[NSString stringWithUTF8String:__FILE__] lastPathComponent], __LINE__)

#else

#define DEBUG_TIME_BEGIN      ;
#define DEBUG_TIME_END        ;
#define PRINT_TIME            ;

#endif

//NSLocalizedString
#define  LSTR(str)  NSLocalizedString(str, nil)

//color
#define colorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define colorFromRGBA(rgbValue,trans) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:trans]


#define SET_NAVIGATION_LIMIT_TITLE_SUBTITLE(title, subTitle, limit) do {\
    [self.navigationItem.titleView removeFromSuperview];\
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width - limit)/2, self.navigationItem.titleView.frame.origin.y, limit, 44)];\
    self.navigationItem.titleView = titleView;\
    UILabel *firstLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, titleView.frame.size.width, 16)];\
    firstLabel.backgroundColor = [UIColor clearColor];\
    firstLabel.text = title;\
    firstLabel.font = [UIFont systemFontOfSize:16];\
    firstLabel.textAlignment = NSTextAlignmentCenter;\
    firstLabel.adjustsFontSizeToFitWidth = YES;\
    firstLabel.textColor = [UIColor darkGrayColor];\
    [titleView addSubview:firstLabel];\
    \
    UILabel *secondLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, firstLabel.frame.origin.y + firstLabel.frame.size.height, titleView.frame.size.width, 12)];\
    secondLabel.backgroundColor = [UIColor clearColor];\
    secondLabel.font = [UIFont systemFontOfSize:10];\
    secondLabel.text = subTitle;\
    secondLabel.textAlignment = NSTextAlignmentCenter;\
    secondLabel.textColor = [UIColor darkGrayColor];\
    [titleView addSubview:secondLabel];\
} while(0)

#define SET_NAVIGATION_TITLE_SUBTITLE(title, subTitle) do {\
    SET_NAVIGATION_LIMIT_TITLE_SUBTITLE(title, subTitle, 150);\
} while(0)

#define SET_NAVIGATION_TITLE_SUBTITLE_SELECTOR(title, subTitle) do {\
    SET_NAVIGATION_LIMIT_TITLE_SUBTITLE(title, subTitle, 150);\
} while(0)

#define SET_NAVIGATION_LIMIT_TITLE(title ,limit, mode)     do {\
    [self.navigationItem.titleView removeFromSuperview];\
    UILabel  *titleLabel = [[UILabel alloc] init];\
    titleLabel.text = title;\
    titleLabel.textAlignment = NSTextAlignmentCenter;\
    titleLabel.backgroundColor = [UIColor clearColor];\
    titleLabel.font = [UIFont systemFontOfSize:16];\
    titleLabel.textColor = [UIColor darkGrayColor];\
    titleLabel.lineBreakMode = mode;\
    titleLabel.frame = CGRectMake(([UIScreen mainScreen].bounds.size.width - limit)/2, self.navigationItem.titleView.frame.origin.y, limit, 20);\
    self.navigationItem.titleView = titleLabel;\
} while(0)

#define SET_NAVIGATION_TITLE_LINEBREAKMODE(title ,mode) do {\
    SET_NAVIGATION_LIMIT_TITLE(title , 150, mode);\
} while(0)

#define SET_NAVIGATION_TITLE(title) do {\
    SET_NAVIGATION_TITLE_LINEBREAKMODE(title ,NSLineBreakByTruncatingTail);\
} while(0)


#define kLargeSize 45
#define kLargeWidth 60

#pragma mark - 导航栏左边按钮 RGBCOLOR(110.f,124.f, 141.f)
#define ADD_LEFT_BAR_TITLE(title, function)  do {\
    UIButton  *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];\
    leftButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;\
    [leftButton setTitle:title forState:UIControlStateNormal];\
    leftButton.titleLabel.font = [UIFont systemFontOfSize:15];\
    [leftButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];\
    [leftButton setTitleColor:[UIColor colorWithRed:(134)/255.0f green:(137)/255.0f blue:(141)/255.0f alpha:1] forState:UIControlStateHighlighted];\
    [leftButton addTarget:self action:@selector(function) forControlEvents:UIControlEventTouchUpInside];\
    [leftButton sizeToFit];\
    leftButton.frame = CGRectMake(0, 0, kLargeWidth, kLargeSize);\
    UIBarButtonItem  *leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];\
    self.navigationItem.leftBarButtonItem = leftItem;\
} while(0)

#define ADD_LEFT_BAR_IMAGENAME(fileName, function)  do {\
    UIButton  *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];\
    leftButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;\
    [leftButton setImage:[UIImage imageNamed:fileName] forState:UIControlStateNormal];\
    [leftButton addTarget:self action:@selector(function) forControlEvents:UIControlEventTouchUpInside];\
    [leftButton sizeToFit];\
    leftButton.frame = CGRectMake(0, 0, kLargeWidth, kLargeSize);\
    UIBarButtonItem  *leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];\
    self.navigationItem.leftBarButtonItem = leftItem;\
} while(0)


#define ADD_BACK(back)  do {\
    ADD_LEFT_BAR_IMAGENAME(@"back", back);\
} while (0)

#define ADD_BACK_HOME_BUTTON(backMethod, homeMethod)     do {\
    UIView *left_view = [[UIView alloc] init];\
    CGFloat space = 10;\
    UIButton *left_btn = [UIButton buttonWithType:UIButtonTypeCustom];\
    [left_btn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];\
    left_btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;\
    [left_btn sizeToFit];\
    left_btn.frame = CGRectMake(0, 0, left_btn.frame.size.width + 25, kLargeSize);\
    [left_btn addTarget:self action:@selector(backMethod) forControlEvents:UIControlEventTouchUpInside];\
    [left_view addSubview:left_btn];\
    \
    UIButton *home_btn = [UIButton buttonWithType:UIButtonTypeCustom];\
    home_btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;\
    [home_btn setTitle:@"关闭" forState:UIControlStateNormal];\
    home_btn.titleLabel.font = [UIFont systemFontOfSize:15];\
    [home_btn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];\
    [home_btn setTitleColor:[UIColor colorWithRed:(134)/255.0f green:(137)/255.0f blue:(141)/255.0f alpha:1] forState:UIControlStateHighlighted];\
    [home_btn sizeToFit];\
    home_btn.frame = CGRectMake(left_btn.frame.size.width + space, 0, home_btn.frame.size.width + 25, kLargeSize);\
    [home_btn addTarget:self action:@selector(homeMethod) forControlEvents:UIControlEventTouchUpInside];\
    \
    [left_view addSubview:home_btn];\
    left_view.frame = CGRectMake(0, 0, left_btn.frame.size.width + home_btn.frame.size.width + space, kLargeSize);\
    UIBarButtonItem *left_item = [[UIBarButtonItem alloc] initWithCustomView:left_view];\
    self.navigationItem.leftBarButtonItem = left_item;\
} while (0)

#pragma mark - 导航栏右边按钮
#define ADD_RIGHT_BAR_TITLE(title, function)  do {\
    UIButton  *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];\
    rightButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;\
    [rightButton setTitle:title forState:UIControlStateNormal];\
    rightButton.titleLabel.font = [UIFont systemFontOfSize:15];\
    [rightButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];\
    [rightButton setTitleColor:[UIColor colorWithRed:(134)/255.0f green:(137)/255.0f blue:(141)/255.0f alpha:1] forState:UIControlStateHighlighted];\
    [rightButton addTarget:self action:@selector(function) forControlEvents:UIControlEventTouchUpInside];\
    [rightButton sizeToFit];\
    rightButton.frame = CGRectMake(0, 0, kLargeWidth, kLargeSize);\
    UIBarButtonItem  *rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];\
    self.navigationItem.rightBarButtonItem = rightItem;\
} while(0)

#define ADD_RIGHT_BAR_TITLE_DISABLE(title)  do {\
    UIButton  *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];\
    rightButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;\
    [rightButton setTitle:title forState:UIControlStateNormal];\
    rightButton.titleLabel.font = [UIFont systemFontOfSize:15];\
    rightButton.enabled = NO;\
    [rightButton setTitleColor:colorFromRGB(0xbababa) forState:UIControlStateNormal];\
    [rightButton sizeToFit];\
    rightButton.frame = CGRectMake(0, 0, kLargeWidth, kLargeSize);\
    UIBarButtonItem  *rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];\
    self.navigationItem.rightBarButtonItem = rightItem;\
} while(0)

#define ADD_RIGHT_BAR_IMAGENAME(fileName, function)  do {\
    UIButton  *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];\
    rightButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;\
    [rightButton setImage:[UIImage imageNamed:fileName] forState:UIControlStateNormal];\
    [rightButton addTarget:self action:@selector(function) forControlEvents:UIControlEventTouchUpInside];\
    [rightButton sizeToFit];\
    rightButton.frame = CGRectMake(0, 0, kLargeWidth, kLargeSize);\
    UIBarButtonItem  *rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];\
    self.navigationItem.rightBarButtonItem = rightItem;\
} while(0)


#define kScreenWidth [[UIScreen mainScreen] bounds].size.width //屏幕宽
#define kScreenHeight [[UIScreen mainScreen] bounds].size.height //屏幕高


#pragma mark - plist

#define kItemKey @"itemKey"
#define kItemTitle @"itemTitle"
#define kItemImage @"itemImage"

#endif /* QTConfig_h */
