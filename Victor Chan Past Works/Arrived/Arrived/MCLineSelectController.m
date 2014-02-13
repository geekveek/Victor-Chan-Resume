//
//  MCLineSelectController.m
//  Arrived
//
//  Created by Matthew Cheok on 10/3/13.
//  Copyright (c) 2013 Matthew Cheok. All rights reserved.
//

#import "MCLineSelectController.h"
#import "MCLineTableCell.h"

#import "UIColor+MWAdditions.h"
#import "UIStoryboard+MWAdditions.h"

#import "MCStopSelectController.h"

@interface MCLineSelectController ()

@property (strong, nonatomic) NSArray *lineArray;

@end

@implementation MCLineSelectController

- (void)actionCancel:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(actionCancel:)];
    
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"data" withExtension:@"plist"];
    self.lineArray = [NSArray arrayWithContentsOfURL:url];
    self.view.backgroundColor = [self.lineArray count] % 2 ? [UIColor niceBackgroundColor] : [UIColor niceDarkBackgroundColor];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.lineArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"MCTableCell";
    MCLineTableCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    cell.contentView.backgroundColor = (indexPath.row % 2) ? [UIColor niceBackgroundColor] : [UIColor niceDarkBackgroundColor];
    
    NSDictionary *lineDictionary = [self.lineArray objectAtIndex:indexPath.row];
    cell.badgeColor = [UIColor colorFromWebColorString:lineDictionary[@"Color"]];
    cell.badgeLabel.text = lineDictionary[@"ShortName"];
    cell.nameLabel.text = lineDictionary[@"FullName"];

    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MCStopSelectController *controller = (MCStopSelectController *) [UIStoryboard viewControllerWithIdentifier:@"MCStopSelectController"];
    controller.delegate = self.delegate;
    
    NSDictionary *lineDictionary = [self.lineArray objectAtIndex:indexPath.row];
    controller.lineDictionary = lineDictionary;
    [self.navigationController pushViewController:controller animated:YES];
    
}

@end
