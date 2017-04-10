//
//  UIView+Frame.h
//  QBFramework
//
//  Created by quentin on 16/7/22.
//  Copyright © 2016年 Quentin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Frame)

@property (nonatomic, assign) CGFloat x;/**<min x*/
@property (nonatomic, assign) CGFloat y;/**<min y*/
@property (nonatomic, assign) CGFloat width;/**<width*/
@property (nonatomic, assign) CGFloat height;/**<height*/
@property (nonatomic, assign) CGSize size;/**<size*/

@end
