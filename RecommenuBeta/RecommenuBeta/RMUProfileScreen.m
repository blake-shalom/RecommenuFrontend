//
//  RMUProfileScreen.m
//  RecommenuBeta
//
//  Created by Blake Ellingham on 11/29/13.
//  Copyright (c) 2013 Blake Ellingham. All rights reserved.
//

#import <FacebookSDK/FacebookSDK.h>
#import "RMUProfileScreen.h"

@interface RMUProfileScreen ()
@property (weak, nonatomic) IBOutlet UIButton *pastRatingsButton;
@property (weak, nonatomic) IBOutlet UILabel *currentRatingsLabel;
@property (weak, nonatomic) IBOutlet UIButton *friendsButton;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UITableView *profileTable;
@property (weak, nonatomic) IBOutlet UIButton *facebookButton;
@property (weak, nonatomic) IBOutlet UIView *emptyView;
@property (weak, nonatomic) IBOutlet UILabel *topEmptyLabel;
@property (weak, nonatomic) IBOutlet UILabel *bottomEmptyLabel;
@property (weak, nonatomic) IBOutlet UIImageView *profilePic;
@property (weak, nonatomic) IBOutlet UIView *profilePicView;

@property NSMutableArray *ratingsArray;
@property BOOL isOnPastRatings;

@end

@implementation RMUProfileScreen

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
    
    self.ratingsArray = [[NSMutableArray alloc]init];
    // Set the tableview's properties
    self.profileTable.delegate = self;
    self.profileTable.dataSource = self;
    
    [self.pastRatingsButton setTintColor:[UIColor RMULogoBlueColor]];
    [self.friendsButton setTintColor:[UIColor RMUDividingGrayColor]];
    self.isOnPastRatings = YES;
    
    // Do some general setup
    [self.nameLabel setTextColor:[UIColor RMUTitleColor]];
    [self.currentRatingsLabel setTextColor:[UIColor RMUNumRatingGray]];
    
    // Pull a user and sort his/her ratings
    NSFetchRequest *request = [[NSFetchRequest alloc]init];
    RMUAppDelegate *delegate = (RMUAppDelegate*) [UIApplication sharedApplication].delegate;
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"RMUSavedUser" inManagedObjectContext:delegate.managedObjectContext];
    [request setEntity:entity];
    NSError *error;
    NSArray *fetchedArray = [delegate.managedObjectContext executeFetchRequest:request error:&error];
    if (fetchedArray.count == 0){
        NSLog(@"User was not created properly");
        abort();
    }
    else {
        RMUSavedUser *user = fetchedArray[0];
        [self sortUserRatingsIntoRatingsArray:user];
        [self loadFacebookElements];
    }
    [self.emptyView setBackgroundColor:[UIColor RMUSelectGrayColor]];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.screenName = @"Profile Screen";

}

- (void)sortUserRatingsIntoRatingsArray: (RMUSavedUser*) user
{
    // Handle rating storage
    if (user.ratingsForUser.count == 0) {
        [self.currentRatingsLabel setText:@"0 Ratings"];
    }
    else {
        // Set UI
        [self.currentRatingsLabel setText:[NSString stringWithFormat:@"%i Ratings", user.ratingsForUser.count]];
        
        // Sort ratings into containers
        for (RMUSavedRecommendation *recommendation in user.ratingsForUser) {
            BOOL doesRestExist = NO;
            for (NSMutableDictionary *recDict in self.ratingsArray) {
                if ([[recDict objectForKey:@"restName"] isEqualToString:recommendation.restaurantName]) {
                    doesRestExist = YES;
                    [[recDict objectForKey:@"recArray"] addObject:recommendation];
                }
            }
            if (!doesRestExist) {
                NSMutableDictionary *newDictionary = [[NSMutableDictionary alloc]initWithDictionary:@{@"restName": recommendation.restaurantName}];
                NSMutableArray *recArray = [[NSMutableArray alloc]initWithObjects:recommendation, nil];
                [newDictionary setObject:recArray forKey:@"recArray"];
                [self.ratingsArray addObject:newDictionary];
            }
        }
    }
}

/*
 *  Set Up facebook elements
 */

- (void)loadFacebookElements
{
    RMUAppDelegate* appDelegate = [UIApplication sharedApplication].delegate;
    if (appDelegate.shouldUserLoginFacebook) {
        [self.nameLabel setText:@"Anonymous User"];
        [self.facebookButton setImage:[UIImage imageNamed:@"facebook_off"] forState:UIControlStateNormal];
    }
    else {
        [self.facebookButton setImage:[UIImage imageNamed:@"facebook_on"] forState:UIControlStateNormal];
        [self.facebookButton setUserInteractionEnabled:NO];
        [FBRequestConnection startForMeWithCompletionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
            if (!error) {
                // Success! Include your code to handle the results here
                NSLog(@"user info: %@", result);
                [self.nameLabel setText:[result objectForKey:@"name"]];
                FBProfilePictureView *profileView = [[FBProfilePictureView alloc]initWithProfileID:[result objectForKey:@"id"] pictureCropping:FBProfilePictureCroppingSquare];
                CGRect profPicFrame = self.profilePic.frame;
                CGRect modifiedProf = CGRectMake(profPicFrame.origin.x, profPicFrame.origin.y, profPicFrame.size.width - 5.0f, profPicFrame.size.height);
                [profileView setFrame:modifiedProf];
                UIImageView *circleView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"profile_circle"]];
                [circleView setFrame: profPicFrame];
                [self.profilePicView addSubview:profileView];
                [self.profilePicView addSubview:circleView];
            } else {
                NSLog(@"error: %@", error);
                // An error occurred, we need to handle the error
            }
        }];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableView Data source

/*
 *  Cell for row uses Rating cells
 */

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"ratingCell";
    RMUProfileRatingCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    NSArray *recArray = [self.ratingsArray[indexPath.section] objectForKey:@"recArray"];
    RMUSavedRecommendation *rec = recArray[indexPath.row];
    [cell.entreeLabel setText:rec.entreeName];
    [cell.descriptionLabel setText:rec.entreeDesc];
    if (rec.isRecommendPositive.boolValue)
        [cell.likeDislikeImage setImage:[UIImage imageNamed:@"thumbs_up_profile"]];
    else
        [cell.likeDislikeImage setImage:[UIImage imageNamed:@"thumbs_down_profile"]];

    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"MM/dd/yyy"];
    [cell.dateLabel setText:[formatter stringFromDate:rec.timeRated]];
    
    return cell;
}

/*
 *
 */

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *rowArray = [self.ratingsArray[section] objectForKey:@"recArray"];
    return rowArray.count;
}

/*
 *
 */

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.ratingsArray.count;
}

/*
 *
 */

- (NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [self.ratingsArray[section] objectForKey:@"restName"];
}

#pragma mark - segue methods

/*
 *  Currently one segue is supported, profile to menu, that redirects a user to the menu of an item
 */

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"profileToMenu"]) {
        RMURevealViewController *nextScreen = (RMURevealViewController*) segue.destinationViewController;
        NSIndexPath *indexPath = [self.profileTable indexPathForSelectedRow];
        NSArray *recArray = [self.ratingsArray[indexPath.section] objectForKey:@"recArray"];
        RMUSavedRecommendation *rec = recArray[indexPath.row];
        NSLog(@"%@", rec.restFoursquareID);
        [nextScreen getRestaurantWithFoursquareID:rec.restFoursquareID andName:rec.restaurantName];
    }
    else if ([segue.identifier isEqualToString:@"profToFoodie"]) {
        RMUOtherProfileScreen *foodieProf = (RMUOtherProfileScreen*) segue.destinationViewController;
        foodieProf.isFoodie = YES;
    }
    else if ([segue.identifier isEqualToString:@"profToFriend"]) {
        RMUOtherProfileScreen *foodieProf = (RMUOtherProfileScreen*) segue.destinationViewController;
        foodieProf.isFoodie = NO;
    }
    else {
        NSLog(@"Unknown ID: %@", segue.identifier);
    }
}

#pragma mark - interactivity

/*
 *  Logs in on Facebook
 */

- (IBAction)loginOnFaceBook:(id)sender
{
    [FBSession openActiveSessionWithReadPermissions:@[@"basic_info"]
                                       allowLoginUI:YES
                                  completionHandler:
     ^(FBSession *session, FBSessionState state, NSError *error) {
         
         // Retrieve the app delegate
         RMUAppDelegate* appDelegate = [UIApplication sharedApplication].delegate;
         // Call the app delegate's sessionStateChanged:state:error method to handle session state changes
         [appDelegate sessionStateChanged:session state:state error:error];
         [self loadFacebookElements];
     }];
}

- (IBAction)showFriendsRatings:(id)sender
{
    [self.friendsButton setTintColor:[UIColor RMULogoBlueColor]];
    [self.pastRatingsButton setTintColor:[UIColor RMUDividingGrayColor]];
    self.isOnPastRatings = NO;
    if (NO) {
        // TODO make the conditional checkunderlying storage and reload the table and make another conditional check on if friends are on
        [self.profileTable setHidden:NO];
        [self.emptyView setHidden:YES];
        [self.profileTable reloadData];
    }
    else {
        // Else hide the Table and show the empty view
        [self.profileTable setHidden:YES];
        [self.emptyView setHidden:NO];
        [self.topEmptyLabel setText:@"You don't have any friends yet!"];
        [self.bottomEmptyLabel setText:@"Connect through Facebook to search for friends and view their ratings."];
    }
}

- (IBAction)showPastRatings:(id)sender
{
    [self.pastRatingsButton setTintColor:[UIColor RMULogoBlueColor]];
    [self.friendsButton setTintColor:[UIColor RMUDividingGrayColor]];
    self.isOnPastRatings = YES;
    if (self.ratingsArray.count > 0) {
        [self.profileTable setHidden:NO];
        [self.emptyView setHidden:YES];
        [self.profileTable reloadData];
    }
    else {
        [self.profileTable setHidden:YES];
        [self.emptyView setHidden:NO];
        [self.topEmptyLabel setText:@"Rate more items to see them on your profile!"];
        [self.bottomEmptyLabel setText:@""];
        // Show the correct headers on the missing view
    }
}


@end
