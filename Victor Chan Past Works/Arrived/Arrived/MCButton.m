//
//  MCButton.m
//  Arrived
//
//  Created by Matthew Cheok on 10/3/13.
//  Copyright (c) 2013 Matthew Cheok. All rights reserved.
//

#import "MCButton.h"
#import "MCSoundManager.h"
#import "UIFont+MWAdditions.h"
#import "UIColor+MWAdditions.h"


#import <QuartzCore/QuartzCore.h>

@implementation MCButton {
    UIView *_innerView;
}

- (void)commonInit {
    self.titleLabel.font = [UIFont boldStandardFontOfSize:20];
    self.titleLabel.textColor = [UIColor niceDarkColor];
    
    self.layer.cornerRadius = 22.f;
    self.layer.borderWidth = 3.f;
    self.layer.borderColor = [UIColor niceDarkColor].CGColor;
    
    _innerView = [[UIView alloc] initWithFrame:CGRectZero];
    _innerView.backgroundColor = [UIColor clearColor];
    _innerView.userInteractionEnabled = NO;
    [self insertSubview:_innerView belowSubview:self.titleLabel];
    
    [self setup];
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self commonInit];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    _innerView.frame = CGRectInset(self.bounds, 5, 5);
    _innerView.layer.cornerRadius = 22.f - 5.f;
}

- (void)setup {
    BOOL active = ([self isHighlighted] || [self isSelected]);
    _innerView.backgroundColor = active ? [UIColor niceDarkColor] : [UIColor clearColor];
    self.titleLabel.textColor = active ? [UIColor whiteColor] : [UIColor niceDarkColor];
}

- (void)setHighlighted:(BOOL)highlighted {
    [super setHighlighted:highlighted];
    [self setup];
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

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
