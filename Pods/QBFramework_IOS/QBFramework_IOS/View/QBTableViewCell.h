//
//  QBTableViewCell.h
//  Pods
//
//  Created by quentin on 2017/4/10.
//
//

#import <UIKit/UIKit.h>

#define kDefaultEdgeInsets UIEdgeInsetsMake(0, 0, 0, 0)

@interface QBTableViewCell : UITableViewCell

@property (nonatomic, assign)  UIEdgeInsets edgeInsets;/**<边界,此参数现在在xib中不能使用，故如果edgeInsets为默认值，则此参数无用*/

- (void)customInit;

@end
