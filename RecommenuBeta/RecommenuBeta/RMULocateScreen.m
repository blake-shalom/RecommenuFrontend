//
//  RMULocateScreen.m
//  RecommenuBeta
//
//  Created by Blake Ellingham on 11/29/13.
//  Copyright (c) 2013 Blake Ellingham. All rights reserved.
//

#import "RMULocateScreen.h"
#import "MapBox/MapBox.h"

@interface RMULocateScreen ()
@property (weak, nonatomic) IBOutlet UIView *mapFrameView;
@property (strong, nonatomic) RMMapView *mapView;
@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) CLLocation *location;

@end

@implementation RMULocateScreen

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Make the mapBox View
    RMMapBoxSource *tileSource = [[RMMapBoxSource alloc]initWithMapID:@"recommenu.gd0lbham"];
    self.mapView = [[RMMapView alloc]initWithFrame:self.mapFrameView.bounds andTilesource:tileSource];
    [self.view addSubview:self.mapView];
    [self.view sendSubviewToBack:self.mapView];
    self.mapView.draggingEnabled = NO;
    
    
    // Center the view around your location
    self.locationManager = [[CLLocationManager alloc]init];
    self.locationManager.delegate = self;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    self.location = [[CLLocation alloc]init];
    [self.locationManager startUpdatingLocation];

    
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Location manager delegate

// Handles when location manager updates
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    // Find Your Location
    self.location = locations[0];
    CLLocationCoordinate2D coord = self.location.coordinate;
    [self.mapView setCenterCoordinate:coord animated:YES];
    
    // Drop a pin
#warning - TODO customized user annotation and queue popup
    RMPointAnnotation *userAnnotation = [[RMPointAnnotation alloc] initWithMapView:self.mapView
                                                                        coordinate:coord
                                                                          andTitle:@"YOU ARE HERE"];
    [self.mapView addAnnotation:userAnnotation];
    [self.locationManager stopUpdatingLocation];
}
@end
