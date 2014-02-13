//
//  MCMainViewController.h
//  Arrived
//
//  Created by Matthew Cheok on 10/3/13.
//  Copyright (c) 2013 Matthew Cheok. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MCLineTableCell.h"

@interface MCMainViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIImageView *logoImage;
@property (strong, nonatomic) IBOutlet UILabel *destinationLabel;
@property (strong, nonatomic) IBOutlet MCLineTableCell *destinationCell;
@property (strong, nonatomic) IBOutlet UILabel *notifyLabel;


@property (strong, nonatomic) IBOutlet UIButton *selectButton;
@property (strong, nonatomic) IBOutlet UIButton *cancelButton;

- (IBAction)actionSelect:(id)sender;
- (IBAction)actionCancel:(id)sender;

@end
