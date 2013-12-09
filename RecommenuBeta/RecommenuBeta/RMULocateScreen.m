//
//  RMULocateScreen.m
//  RecommenuBeta
//
//  Created by Blake Ellingham on 11/29/13.
//  Copyright (c) 2013 Blake Ellingham. All rights reserved.
//
#define NUMBER_OF_FALLBACK 15

#import "RMULocateScreen.h"
#import "RMUFallbackScreen.h"

@interface RMULocateScreen ()
@property (weak, nonatomic) IBOutlet UIView *mapFrameView;
@property (strong, nonatomic) RMMapView *mapView;
@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) CLLocation *location;
@property (weak, nonatomic) IBOutlet RMUButton *yesButton;
@property (weak, nonatomic) IBOutlet RMUButton *noButton;
@property (weak, nonatomic) IBOutlet UIImageView *gradientImage;
@property (weak, nonatomic) IBOutlet UIView *popupView;
@property (weak, nonatomic) IBOutlet UILabel *restaurantLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (strong,nonatomic) NSMutableArray *fallbackRest;

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
    
    self.fallbackRest = [[NSMutableArray alloc]init];
    
    // Hide yo wife
    [self.popupView setHidden:YES];
    [self.gradientImage setHidden:YES];
    
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

    // Connfigure the buttons
    self.yesButton.isBlue = YES;
    self.noButton.isBlue = NO;
    [self.yesButton setBackgroundColor:[UIColor RMULogoBlueColor]];
    [self.noButton setBackgroundColor:[UIColor whiteColor]];
    
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
    [self.locationManager stopUpdatingLocation];
    self.location = locations[0];
    CLLocationCoordinate2D coord = self.location.coordinate;
    [self.mapView setCenterCoordinate:coord animated:YES];
    
    // Drop a pin
#warning - TODO customized user annotation
    RMPointAnnotation *userAnnotation = [[RMPointAnnotation alloc] initWithMapView:self.mapView
                                                                        coordinate:coord
                                                                          andTitle:@"YOU ARE HERE"];
    [self.mapView addAnnotation:userAnnotation];
    [self findRestaurantWithRadius:10.0f];
}

#pragma mark - Networking

/*
 *  Finds the current restaurant you are at
 */

- (void)findRestaurantWithRadius:(NSInteger)radius
{
    NSLog(@"%d", radius);
    CLLocationCoordinate2D coord = self.location.coordinate;
    NSString *latLongString = [NSString stringWithFormat:@"%f,%f", coord.latitude, coord.longitude];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSDictionary *paramDic = @{@"ll" : latLongString,
                               @"limit": @15,
                               @"intent" : @"browse",
                               @"radius" : [NSString stringWithFormat:@"%d", radius],
                               @"categoryId" : @"4d4b7105d754a06374d81259",
                               @"client_id" : [[NSUserDefaults standardUserDefaults]stringForKey:@"foursquareID"],
                               @"client_secret" : [[NSUserDefaults standardUserDefaults]stringForKey:@"foursquareSecret"],
                               @"v" : @20131017
                               };
    [manager GET:@"https://api.foursquare.com/v2/venues/search"
      parameters:paramDic
         success:^(AFHTTPRequestOperation *operation, id responseObject) {
             NSArray *respArray = [[responseObject objectForKey:@"response"] objectForKey:@"venues"];
             if (respArray.count ==0)
                 [self findRestaurantWithRadius:radius * 3 / 2];
             else {
                 [self.restaurantLabel setText:[respArray[0] objectForKey:@"name"]];
                 [self.addressLabel setText:[[respArray[0] objectForKey:@"location"] objectForKey:@"address"]];
                 [self animateInGradient];
            }
         }
         failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             NSLog(@"error: %@", error);
         }];
}

/*
 *  Finds a list of restaurants that the user could be at
 */

- (void)findFallbacksWithRadius:(NSInteger)radius
{
    CLLocationCoordinate2D coord = self.location.coordinate;
    NSString *latLongString = [NSString stringWithFormat:@"%f,%f", coord.latitude, coord.longitude];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSDictionary *paramDic = @{@"ll" : latLongString,
                               @"limit": @15,
                               @"intent" : @"browse",
                               @"radius" : [NSString stringWithFormat:@"%d", radius],
                               @"categoryId" : @"4d4b7105d754a06374d81259",
                               @"client_id" : [[NSUserDefaults standardUserDefaults]stringForKey:@"foursquareID"],
                               @"client_secret" : [[NSUserDefaults standardUserDefaults]stringForKey:@"foursquareSecret"],
                               @"v" : @20131017
                               };
    [manager GET:@"https://api.foursquare.com/v2/venues/search"
      parameters:paramDic
         success:^(AFHTTPRequestOperation *operation, id responseObject) {
             NSArray *respArray = [[responseObject objectForKey:@"response"] objectForKey:@"venues"];
             if (respArray.count < 15)
                 [self findFallbacksWithRadius:radius * 3 / 2];
             else {
                 NSLog(@"");
                 for (int i = 0; i < NUMBER_OF_FALLBACK; i++) {
                     [self.fallbackRest addObject:@{@"name": [respArray[i] objectForKey:@"name"],
                                                    @"address" : [[respArray[0] objectForKey:@"location"] objectForKey:@"address"]}];
                     [self performSegueWithIdentifier:@"locateToFallback" sender:self];
                 }
             }
         }
         failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             NSLog(@"error: %@", error);
         }];
}


#pragma mark - Interactivity Methods

/*
 *  Finds a list of other fallback options for the location of the user
 */

- (IBAction)findFallbackLocations:(id)sender
{
    [self findFallbacksWithRadius:25];
}

#pragma mark - segue methods

/*
 *  Readies the VC's for a segue
 */

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"locateToFallback"]) {
        RMUFallbackScreen *nextScreen = (RMUFallbackScreen*) segue.destinationViewController;
        [nextScreen setFallbackRestaurants:self.fallbackRest];
    }
    else {
        NSLog(@"ERROR: UNKNOWN SEGUE %@", segue.identifier);
    }
        
        
}

#pragma mark - Animation Methods

/*
 *  Animates in the gradient and then calls animate popup
 */

- (void)animateInGradient
{
    [self.gradientImage setAlpha:0.0f];
    [self.gradientImage setHidden:NO];
    [UIView animateWithDuration:0.3f
                          delay:1.0f
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         [self.gradientImage setAlpha:1.0f];
                         [self.popupView setAlpha:1.0f];
                     } completion:^(BOOL finished) {
                         [self.popupView setHidden:NO];
                         [self animatePopup];
                     }];
}

/*
 *  Animates in the popup to the right location
 */

- (void)animatePopup
{
    [RMUAnimationClass animateFlyInView:self.popupView
                           withDuration:0.1f
                              withDelay:0.0f
                          fromDirection:buttonAnimationDirectionTop
                         withCompletion:Nil
                             withBounce:YES];
}

@end


//[manager GET:[NSString stringWithFormat:@"https://api.foursquare.com/v2/venues/%@/menu", [respArray[0] objectForKey:@"id"]]
//  parameters: @{@"VENUE_ID": [respArray[0] objectForKey:@"id"],
//                @"client_id" : [[NSUserDefaults standardUserDefaults]stringForKey:@"foursquareID"],
//                @"client_secret" : [[NSUserDefaults standardUserDefaults]stringForKey:@"foursquareSecret"],
//                @"v" : @20131017}
//     success:^(AFHTTPRequestOperation *operation, id responseObject) {
//         NSLog(@"%@", responseObject);
//     }
//     failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//         NSLog(@"fail %@", error);
//     }];

