//
//  RMUHomeScreen.m
//  RecommenuBeta
//
//  Created by Blake Ellingham on 11/23/13.
//  Copyright (c) 2013 Blake Ellingham. All rights reserved.
//

#import "RMUHomeScreen.h"

@interface RMUHomeScreen ()

@end

@implementation RMUHomeScreen

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
    
    
//    NSString *mapID = ([[UIScreen mainScreen] scale] > 1.0 ? @"examples.map-zq0f1vuc" : @"examples.map-zgrqqx0w");
//    RMMapBoxSource *tileSource = [[RMMapBoxSource alloc] initWithMapID:mapID];
//    RMMapView *mapView = [[RMMapView alloc] initWithFrame:self.view.bounds andTilesource:tileSource];
//
//    [self.view addSubview:mapView];
//
//    RMPointAnnotation *annotation = [[RMPointAnnotation alloc] initWithMapView:mapView
//                                                                    coordinate:mapView.centerCoordinate
//                                                                      andTitle:@"Hello, world!"];
//    
//    [mapView addAnnotation:annotation];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
