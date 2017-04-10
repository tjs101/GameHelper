//
//  QBWebViewController.h
//  QBFramework
//
//  Created by quentin on 16/7/11.
//  Copyright © 2016年 Quentin. All rights reserved.
//

#import "QBViewController.h"

@interface QBWebViewController : QBViewController

- (instancetype)initWithURL:(NSURL *)url;


@property (nonatomic, assign) BOOL showSubTitle;/**<默认显示子标题>*/

@end
