//
//  UIImage+Utility.m
//  QBFramework
//
//  Created by quentin on 16/7/22.
//  Copyright © 2016年 Quentin. All rights reserved.
//

#import "UIImage+Utility.h"

@implementation UIImage (Utility)

- (UIImage *)stretchableImage
{
    return [self stretchableImageWithLeftCapWidth:self.size.width / 2 topCapHeight:self.size.height / 2];
}

@end
