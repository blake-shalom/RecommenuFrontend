//
//  RMURevealViewController.m
//  RecommenuBeta
//
//  Created by Blake Ellingham on 12/27/13.
//  Copyright (c) 2013 Blake Ellingham. All rights reserved.
//

#import "RMURevealViewController.h"

@interface RMURevealViewController ()


@end

@implementation RMURevealViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    // If the front VC is a rating screen then the menu was already loaded, go ahead and set the menu properties
    if ([self.frontViewController isKindOfClass:[RMURatingScreen class]]) {
        // Rating screen gets current menu
        RMURatingScreen *ratingScreen = (RMURatingScreen*) self.frontViewController;
        [ratingScreen setupMenuElementsWithRestaurant:self.currentRestaurant];
        [ratingScreen setupViews];
        
        // So does side menu
        RMUSideMenuScreen *sideMenu = (RMUSideMenuScreen*)self.rearViewController;
        [sideMenu loadCurrentRestaurant:self.currentRestaurant];
        sideMenu.delegate = self;
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 *  Sets a property that the children VC's of the reveal controller use to fill their data structures
 */

- (void)getRestaurantWithFoursquareID:(NSString *)foursquareID andName:(NSString *)name
{
    AFHTTPRequestOperationManager* manager = [AFHTTPRequestOperationManager manager];
    [manager GET:[NSString stringWithFormat:@"https://api.foursquare.com/v2/venues/%@/menu", foursquareID]
      parameters:@{@"VENUE_ID": [NSString stringWithFormat:@"%@", foursquareID],
                   @"client_id" : [[NSUserDefaults standardUserDefaults] stringForKey:@"foursquareID"],
                   @"client_secret" : [[NSUserDefaults standardUserDefaults]stringForKey:@"foursquareSecret"],
                   @"v" : @20131017}
         success:^(AFHTTPRequestOperation *operation, id responseObject) {
             // TODO reveal the table
             [self.view setHidden:NO];
             self.currentRestaurant = [[RMURestaurant alloc]initWithDictionary:[responseObject objectForKey:@"response"]
                                                             andRestaurantName:name];
             self.currentRestaurant.restFoursquareID = foursquareID;
             
             // Handles menu "front" screen
             RMUMenuScreen *menuScreen = (RMUMenuScreen*) self.frontViewController;
             [menuScreen setupMenuElementsWithRestaurant:self.currentRestaurant];
             [menuScreen setupViews];
             
             // Handles side menu "rear" screen
             RMUSideMenuScreen *sideMenu = (RMUSideMenuScreen*)self.rearViewController;
             [sideMenu loadCurrentRestaurant:self.currentRestaurant];
             sideMenu.delegate = self;
         }
         failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             NSLog(@"error : %@", error);
         }];
}

/*
 *  Loads Menu Screen with a different menu selection, used as an intermediary between side menu and menu screen
 */

- (void)loadMenuScreenWithMenu:(RMUMenu *)menu
{
    RMUMenuScreen *menuScreen = (RMUMenuScreen*) self.frontViewController;
    [menuScreen loadMenu:menu];
}

@end
