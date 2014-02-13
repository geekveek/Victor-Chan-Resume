//
//  MCMainViewController.m
//  Arrived
//
//  Created by Matthew Cheok on 10/3/13.
//  Copyright (c) 2013 Matthew Cheok. All rights reserved.
//

#import "MCMainViewController.h"
#import "MCLineSelectController.h"

#import "UIColor+MWAdditions.h"
#import "UIFont+MWAdditions.h"
#import "UIImage+MWAdditions.h"
#import "UIStoryboard+MWAdditions.h"

#import "SVPulsingAnnotationView.h"

#import <QuartzCore/QuartzCore.h>
#import <CoreLocation/CoreLocation.h>

@interface MCMainViewController () <CLLocationManagerDelegate, MCLineSelectControllerDelegate>

@end

@implementation MCMainViewController {
    CLLocationManager *_locationManager;
    NSDictionary *_stopDictionary;
    UIColor *_lineColor;
    
    CLRegion *_region;
    SVPulsingAnnotationView *_pulsingView;
}

- (void)setup {
    _locationManager = [[CLLocationManager alloc] init]; /* don't leak memeory! */
    _locationManager.delegate = self;
    _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
//    [_locationManager startUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    //NSLog(@"locations %@", locations);
}

-(void)locationManager:(CLLocationManager *)manager didEnterRegion:(CLRegion *)region
{
    
    UILocalNotification *notification = [[UILocalNotification alloc] init];
    notification.fireDate = [NSDate date];
    NSTimeZone* timezone = [NSTimeZone defaultTimeZone];
    notification.timeZone = timezone;
    notification.alertBody = [NSString stringWithFormat:@"You have arrived at %@.", _stopDictionary[@"StationName"]];
    notification.alertAction = @"OK";
    notification.soundName = UILocalNotificationDefaultSoundName;
    [[UIApplication sharedApplication] scheduleLocalNotification:notification];
    
    if (_stopDictionary) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Arrived" message:[NSString stringWithFormat:@"You have arrived at %@.", _stopDictionary[@"StationName"]] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertView show];        
    }

    [_locationManager stopMonitoringForRegion:region];
    _region = nil;
    _stopDictionary = nil;
    _lineColor = nil;
    [self updateUI];
}

-(void)locationManager:(CLLocationManager *)manager didExitRegion:(CLRegion *)region
{
    
}

-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    
}

- (void)updateUI {
    if (_stopDictionary) {
        self.destinationCell.badgeColor = _lineColor;
        self.destinationCell.badgeLabel.text = _stopDictionary[@"StationID"];
        self.destinationCell.nameLabel.text = _stopDictionary[@"StationName"];
        
        _pulsingView.hidden = NO;
        _pulsingView.annotationColor = _lineColor;
        self.notifyLabel.hidden = NO;
    }
    else {
        self.destinationCell.badgeColor = [UIColor clearColor];
        self.destinationCell.badgeLabel.text = nil;
        self.destinationCell.nameLabel.text = @"Not selected";
        _pulsingView.hidden = YES;
        self.notifyLabel.hidden = YES;
    }
    
    [self.destinationCell updateUI];
}

- (void)controllerShouldUpdateWithStopDictionary:(NSDictionary *)stopDictionary withColor:(UIColor *)color {
    _stopDictionary = stopDictionary;
    _lineColor = color;

    if (_region) [_locationManager stopMonitoringForRegion:_region];
    CLLocationDegrees latitude = [_stopDictionary[@"Lat"] doubleValue];
    CLLocationDegrees longitude = [_stopDictionary[@"Long"] doubleValue];

    CLLocationCoordinate2D location2D = CLLocationCoordinate2DMake(latitude, longitude);
    _region = [[CLRegion alloc] initCircularRegionWithCenter:location2D radius:1000 identifier:@"StopRegion"];
    [_locationManager startMonitoringForRegion:_region];
    
    [self updateUI];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    self.logoImage.image = [[UIImage imageNamed:@"train-logo.png"] imageTintedWithColor:[UIColor niceDarkColor]];
    
    self.view.backgroundColor = [UIColor niceBackgroundColor];
    self.destinationLabel.font = [UIFont boldStandardFontOfSize:15.f];
    self.notifyLabel.font = [UIFont standardFontOfSize:15.f];
    
    [self updateUI];
    [self setup];
    
    _pulsingView = [[SVPulsingAnnotationView alloc] initWithAnnotation:nil reuseIdentifier:nil];
    _pulsingView.center = CGPointMake(43, 255);
    _pulsingView.hidden = YES;
    
    [self.view insertSubview:_pulsingView belowSubview:self.destinationCell];
}

- (void)viewWillAppear:(BOOL)animated {
    [self updateUI];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)actionSelect:(id)sender {
    MCLineSelectController *controller = (MCLineSelectController *) [UIStoryboard viewControllerWithIdentifier:@"MCLineSelectController"];
    controller.delegate = self;
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:controller];
    
    [self presentViewController:navController animated:YES completion:nil];
}

- (IBAction)actionCancel:(id)sender {
    if (_region) {
        [_locationManager stopMonitoringForRegion:_region];
        _region = nil;
    }
    _stopDictionary = nil;
    _lineColor = nil;
    [self updateUI];
}

@end
