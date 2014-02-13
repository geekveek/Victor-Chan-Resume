//
//  MCLineSelectController.h
//  Arrived
//
//  Created by Matthew Cheok on 10/3/13.
//  Copyright (c) 2013 Matthew Cheok. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MCLineSelectControllerDelegate <NSObject>

- (void)controllerShouldUpdateWithStopDictionary:(NSDictionary *)stopDictionary withColor:(UIColor *)color;

@end

@interface MCLineSelectController : UITableViewController

@property (weak, nonatomic) id <MCLineSelectControllerDelegate> delegate;

@end
