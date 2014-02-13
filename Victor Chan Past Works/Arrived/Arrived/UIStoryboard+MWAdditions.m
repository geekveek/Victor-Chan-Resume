//
//  UIStoryboard+MWAdditions.m
//  MobileLearning
//
//  Created by Matthew Cheok on 30/1/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "UIStoryboard+MWAdditions.h"

@implementation UIStoryboard (MWAdditions)

+ (UIViewController *)viewControllerWithIdentifier:(NSString *)identifer {
    return [[UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil] instantiateViewControllerWithIdentifier:identifer];
}

@end
