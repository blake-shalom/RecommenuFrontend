//
//  RMUMenuScreen.m
//  RecommenuBeta
//
//  Created by Blake Ellingham on 12/18/13.
//  Copyright (c) 2013 Blake Ellingham. All rights reserved.
//

#import "RMUMenuScreen.h"

@interface RMUMenuScreen ()

@property RMURestaurant *currentRestaurant;
@property (weak, nonatomic) IBOutlet UILabel *restName;
@property (weak, nonatomic) IBOutlet UILabel *currMenu;
@property (weak, nonatomic) IBOutlet UILabel *leftSection;
@property (weak, nonatomic) IBOutlet UILabel *currSection;
@property (weak, nonatomic) IBOutlet UILabel *rightSection;


@end

@implementation RMUMenuScreen

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
    
	// Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 *  Gets Restaurant from foursquare and sets the underlying data structure up. also hides the table view until the load finishes
 */

- (void)getRestaurantWithFoursquareID:(NSNumber *)foursquareID andName:(NSString *)name
{
    // TODO hide the table view
    [self.view setHidden:YES];
    AFHTTPRequestOperationManager* manager = [AFHTTPRequestOperationManager manager];
    [manager GET:[NSString stringWithFormat:@"https://api.foursquare.com/v2/venues/%@/menu", foursquareID]
      parameters:@{@"VENUE_ID": [NSString stringWithFormat:@"%@", foursquareID],
                   @"client_id" : [[NSUserDefaults standardUserDefaults] stringForKey:@"foursquareID"],
                   @"client_secret" : [[NSUserDefaults standardUserDefaults]stringForKey:@"foursquareSecret"],
                   @"v" : @20131017}
         success:^(AFHTTPRequestOperation *operation, id responseObject) {
             // TODO reveal the table
             [self.view setHidden:NO];
             self.currentRestaurant = [[RMURestaurant alloc]initWithDictionary:responseObject
                                                             andRestaurantName:name];
             [self.restName setText:self.currentRestaurant.restName];
         }
         failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             NSLog(@"error : %@", error);
         }];
}

#pragma mark - interactivity

/*
 *  Views other avalable menus at the restaurant
 */

- (IBAction)viewMenus:(id)sender
{

}

/*
 *  Sees the ratings for all dishes, toggle-able
 */

- (IBAction)seeRatings:(id)sender
{

}

@end
