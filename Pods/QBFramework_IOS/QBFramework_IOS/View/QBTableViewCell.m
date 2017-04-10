//
//  QBTableViewCell.m
//  Pods
//
//  Created by quentin on 2017/4/10.
//
//

#import "QBTableViewCell.h"

@implementation QBTableViewCell

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        
        [self customInit];
        
    }
    return self;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self customInit];
    }
    return self;
}

- (void)customInit
{
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    if (_edgeInsets.left == kDefaultEdgeInsets.left && _edgeInsets.right == kDefaultEdgeInsets.right && _edgeInsets.top == kDefaultEdgeInsets.top && _edgeInsets.bottom == kDefaultEdgeInsets.bottom) {
        return;
    }
    
    CGRect rect = CGRectMake(_edgeInsets.left,
                             _edgeInsets.top,
                             self.frame.size.width - _edgeInsets.left - _edgeInsets.right,
                             self.frame.size.height - _edgeInsets.top - _edgeInsets.bottom);
    
    self.contentView.frame = rect;
    self.backgroundView.frame = rect;
    self.selectedBackgroundView.frame = rect;
    
    if (self.editing) {
        for (UIView *subview in self.subviews) {
            if ([NSStringFromClass([subview class]) isEqualToString:@"UITableViewCellDeleteConfirmationControl"]) {
                [UIView beginAnimations:nil context:NULL];
                [UIView setAnimationBeginsFromCurrentState:YES];
                [UIView setAnimationDuration:0.0f];
                
                CGRect f = subview.frame;
                f.origin.x -= 8;
                subview.frame = f;
                
                [UIView commitAnimations];
                break;
            }
        }
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
