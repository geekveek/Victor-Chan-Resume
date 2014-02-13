//
//  MCLineTableCell.h
//  Arrived
//
//  Created by Matthew Cheok on 10/3/13.
//  Copyright (c) 2013 Matthew Cheok. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MCLineTableCell : UITableViewCell

@property (strong, nonatomic) UIColor *badgeColor;
@property (strong, nonatomic) IBOutlet UILabel *badgeLabel;
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
- (void)updateUI;

@end
