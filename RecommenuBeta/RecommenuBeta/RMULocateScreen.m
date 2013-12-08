//
//  RMULocateScreen.m
//  RecommenuBeta
//
//  Created by Blake Ellingham on 11/29/13.
//  Copyright (c) 2013 Blake Ellingham. All rights reserved.
//

#import "RMULocateScreen.h"

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
    self.location = locations[0];
    CLLocationCoordinate2D coord = self.location.coordinate;
    [self.mapView setCenterCoordinate:coord animated:YES];
    
    // Drop a pin
#warning - TODO customized user annotation
    RMPointAnnotation *userAnnotation = [[RMPointAnnotation alloc] initWithMapView:self.mapView
                                                                        coordinate:coord
                                                                          andTitle:@"YOU ARE HERE"];
    [self.mapView addAnnotation:userAnnotation];
    [self animateInGradient];
    [self.locationManager stopUpdatingLocation];
}

#pragma mark - Networking

/*
 *  Finds the current restaurant you are at
 */

- (void)findRestaurantWithRadius:(NSInteger)radius withCoordinate: (CLLocationCoordinate2D)coord
{
    NSString *latLongString = [NSString stringWithFormat:@"%f,%f", coord.latitude, coord.longitude];
    NSURL *foursquareURL = [[NSURL alloc]initWithString:[NSString
                                                         stringWithFormat: (@"https://api.foursquare.com/v2/venues/search?ll=%@&limit=15&intent=browse&radius=%i&categoryId=4d4b7105d754a06374d81259&client_id=%@&client_secret=%@&v=20130918"),
                                                         latLongString,
                                                         radius,
                                                         [[NSUserDefaults standardUserDefaults]stringForKey:@"foursquareID"],
                                                         [[NSUserDefaults standardUserDefaults] stringForKey:@"foursquareSecret"]]];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:<#(NSString *)#>
      parameters:<#(NSDictionary *)#>
         success:<#^(AFHTTPRequestOperation *operation, id responseObject)success#>
         failure:<#^(AFHTTPRequestOperation *operation, NSError *error)failure#>];
//    AFJSONRequestOperation *operation = [AFJSONRequestOperation
//                                         JSONRequestOperationWithRequest:request
//                                         success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
//                                             [self.findMenuButton setUserInteractionEnabled:YES];
//                                             NSDictionary *newDictionary = [JSON objectForKey:@"response"];
//                                             NSArray *newArray = [newDictionary objectForKey:@"venues"];
//                                             if (newArray.count == 0) {
//                                                 [self findRestaurantWithRadius:radius * 2];
//                                             }
//                                             else {
//                                                 self.restName = [newArray[0] objectForKey:@"name"];
//                                                 
//                                                 UIAlertView *restaurantCheckAlert = [[UIAlertView alloc] initWithTitle:@"Restaurant Found!"
//                                                                                                                message:[NSString stringWithFormat:(@"Are you at %@?"), self.restName]
//                                                                                                               delegate:self
//                                                                                                      cancelButtonTitle:@"NO"
//                                                                                                      otherButtonTitles:@"YES", nil];
//                                                 [restaurantCheckAlert show];
//                                             }
//                                             
//                                         }
//                                         failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
//                                             [self.findMenuButton setUserInteractionEnabled:YES];
//                                             NSLog(@"Request Failed with Error: %@, %@", error, error.userInfo);
//                                         }];
//    [operation start];

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
