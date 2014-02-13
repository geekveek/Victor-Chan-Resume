//
//  MCStopSelectController.h
//  Arrived
//
//  Created by Matthew Cheok on 10/3/13.
//  Copyright (c) 2013 Matthew Cheok. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MCLineSelectController.h"

@interface MCStopSelectController : UITableViewController

@property (strong, nonatomic) NSDictionary *lineDictionary;

@property (weak, nonatomic) id <MCLineSelectControllerDelegate> delegate;

@end
