//
//  UIFont+MWAdditions.m
//  GroupNotes
//
//  Created by Matthew Cheok on 20/8/12.
//  Copyright (c) 2012 Matthew Cheok. All rights reserved.
//

#import "UIFont+MWAdditions.h"

#define STANDARD_FONT @"MuseoSansRounded-300" // @"HelveticaNeue-Condensed"
#define BOLD_STANDARD_FONT @"MuseoSansRounded-700" // @"HelveticaNeue-CondensedBold"

@implementation UIFont (MWAdditions)

+ (UIFont *)standardFontOfSize:(CGFloat)size {
    return [UIFont fontWithName:STANDARD_FONT size:size];
}

+ (UIFont *)boldStandardFontOfSize:(CGFloat)size {
    return [UIFont fontWithName:BOLD_STANDARD_FONT size:size];
}

@end
