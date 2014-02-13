//
//  MCLineTableCell.m
//  Arrived
//
//  Created by Matthew Cheok on 10/3/13.
//  Copyright (c) 2013 Matthew Cheok. All rights reserved.
//

#import "MCLineTableCell.h"
#import "MCSoundManager.h"
#import "UIFont+MWAdditions.h"
#import "UIColor+MWAdditions.h"

#import <QuartzCore/QuartzCore.h>

@implementation MCLineTableCell

- (void)commonInit {
    UIView *myBackView = [[UIView alloc] initWithFrame:CGRectZero];
    myBackView.backgroundColor = [UIColor niceDarkBlueColor];
    self.selectedBackgroundView = myBackView;
    
    self.badgeColor = [UIColor eastWestLineColor];
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (void)updateUI {
    self.badgeLabel.backgroundColor = ([self isHighlighted] || [self isSelected]) ? [UIColor whiteColor] : self.badgeColor;
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated {
    [super setHighlighted:highlighted animated:animated];
    [self updateUI];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    [self updateUI];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.badgeLabel.font = [UIFont boldStandardFontOfSize:15.f];
    self.badgeLabel.backgroundColor = ([self isHighlighted] || [self isSelected]) ? [UIColor whiteColor] : self.badgeColor;
    self.badgeLabel.textColor = [UIColor whiteColor];
    self.badgeLabel.highlightedTextColor = [UIColor niceDarkBlueColor];
    self.badgeLabel.layer.cornerRadius = 5.f;
    
    
    self.nameLabel.font = [UIFont boldStandardFontOfSize:20.f];
    self.nameLabel.textColor = [UIColor niceDarkColor];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    [[MCSoundManager sharedManager] playClickOnSound];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesEnded:touches withEvent:event];
    [[MCSoundManager sharedManager] playClickOffSound];
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesCancelled:touches withEvent:event];
    [[MCSoundManager sharedManager] playClickOffSound];
}

@end
