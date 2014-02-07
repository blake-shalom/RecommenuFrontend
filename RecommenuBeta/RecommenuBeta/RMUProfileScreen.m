//
//  RMUProfileScreen.m
//  RecommenuBeta
//
//  Created by Blake Ellingham on 11/29/13.
//  Copyright (c) 2013 Blake Ellingham. All rights reserved.
//


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
@property (weak, nonatomic) IBOutlet UIView *hideNameView;
@property (weak, nonatomic) IBOutlet UIImageView *foodieImage;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *loadingActivity;

@property NSMutableArray *ratingsArray;
@property NSArray *friendsArray;
@property BOOL isOnPastRatings;
@property BOOL isUserOnFacebook;

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
    
    [self.loadingActivity setHidden:YES];
    
    self.ratingsArray = [[NSMutableArray alloc]init];
    self.friendsArray = [[NSArray alloc]init];
    
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
    RMUAppDelegate *delegate = (RMUAppDelegate*) [UIApplication sharedApplication].delegate;
    RMUSavedUser *user = [delegate fetchCurrentUser];
    [self sortUserRatingsIntoRatingsArray:user];
    
    [self loadUserElements];
    [self.emptyView setBackgroundColor:[UIColor RMUSelectGrayColor]];
    
    if (user.isFoodie)
        [self.foodieImage setHidden:NO];
    else
        [self.foodieImage setHidden:YES];
    
    // Customize the Appearance of the TabBar
    UITabBarController *tabBarVC = self.tabBarController;
    UITabBar *tabBar = tabBarVC.tabBar;
    [tabBar setTintColor:[UIColor RMULogoBlueColor]];

    // If user has signed in with facebook start the loading screen
    if (user.facebookID){
        self.isUserOnFacebook = YES;
        [self fetchFriendsOfUser:user];
    }
}

/*
 *  Queries the DB for friends of the current user
 */

- (void)fetchFriendsOfUser:(RMUSavedUser*)user
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    NSRange range;
    range.length = 1;
    range.location = 6;
    NSString *trimString = [user.userURI stringByReplacingCharactersInRange:range withString:@""];
    NSCharacterSet* nonDigits = [[NSCharacterSet decimalDigitCharacterSet] invertedSet];
    int value = [[trimString stringByTrimmingCharactersInSet:nonDigits] intValue];
    
    [manager GET:[NSString stringWithFormat:(@"http://glacial-ravine-3577.herokuapp.com/data/friend_list/%i"), value]
      parameters:nil
         success:^(AFHTTPRequestOperation *operation, id responseObject) {
             NSLog(@"RESPONSE: %@", responseObject);
             if (!self.isOnPastRatings) {
                 [self.profileTable setHidden:NO];
                 [self.emptyView setHidden:YES];
                 [self.profileTable reloadData];
             }
             self.friendsArray = [responseObject objectForKey:@"response"];
         }
         failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             NSLog(@"ERROR: %@, WITH RESPONSE STRING: %@",error, operation.responseString);
         }];
}


- (void)viewDidAppear:(BOOL)animated
{
    // SET the profile screen name for Google analytics
    self.screenName = @"Profile Screen";
    [super viewDidAppear:animated];
}

- (void)sortUserRatingsIntoRatingsArray: (RMUSavedUser*) user
{
    // Handle rating storage
    if (user.ratingsForUser.count == 0) {
        [self.currentRatingsLabel setText:@"0 Ratings"];
        [self showPastRatings:self];
    }
    else {
        // Set UI
        [self.profileTable setHidden:NO];
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
 *  Set Up User elements
 */

- (void)loadUserElements
{
    RMUAppDelegate* appDelegate = [UIApplication sharedApplication].delegate;
    if (appDelegate.shouldUserLoginFacebook) {
        [self.nameLabel setText:@"Anonymous User"];
        [self.facebookButton setImage:[UIImage imageNamed:@"facebook_off"] forState:UIControlStateNormal];
    }
    else {
        [self.facebookButton setImage:[UIImage imageNamed:@"facebook_on"] forState:UIControlStateNormal];
        [self.facebookButton setUserInteractionEnabled:NO];
        [self.hideNameView setHidden:NO];
        
        // check if we need to go grab info from facebook
        // if we do that start connection, otherwise use cached data
        RMUSavedUser *user = [appDelegate fetchCurrentUser];
        
        // Set some frames
        CGRect profPicFrame = self.profilePic.frame;
        CGRect modifiedProf = CGRectMake(profPicFrame.origin.x, profPicFrame.origin.y, profPicFrame.size.width - 5.0f, profPicFrame.size.height);
        
        if (NO) {
            
        }
        else {
            [FBRequestConnection startForMeWithCompletionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
                if (!error) {
                    // Success! Include your code to handle the results here
                    NSLog(@"user info: %@", result);
                    user.firstName = [result objectForKey:@"first_name"];
                    user.lastName = [result objectForKey:@"last_name"];
                    [self.nameLabel setText:[result objectForKey:@"name"]];
                    FBProfilePictureView *profileView = [[FBProfilePictureView alloc]initWithProfileID:[result objectForKey:@"id"] pictureCropping:FBProfilePictureCroppingSquare];
                    
                    [profileView setFrame:modifiedProf];
                    [self.profilePicView addSubview:profileView];
                }
                else {
                    NSLog(@"error: %@", error);
                    // An error occurred, we need to handle the error
                }
            }];
        }
        UIImageView *circleView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"profile_circle_user"]];
        [circleView setFrame: profPicFrame];
        [self.profilePicView addSubview:circleView];
        [self.hideNameView setHidden:YES];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableView Data source

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.isOnPastRatings)
        return 80.0;
    else
        return 67.0;
}

/*
 *  Cell for row uses Rating cells
 */

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    if (self.isOnPastRatings) {
        static NSString *CellIdentifier = @"ratingCell";
        RMUProfileRatingCell *rateCell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
        NSArray *recArray = [self.ratingsArray[indexPath.section] objectForKey:@"recArray"];
        RMUSavedRecommendation *rec = recArray[indexPath.row];
        [rateCell.entreeLabel setText:rec.entreeName];
        [rateCell.descriptionLabel setText:rec.entreeDesc];
        if (rec.isRecommendPositive.boolValue)
            [rateCell.likeDislikeImage setImage:[UIImage imageNamed:@"thumbs_up_profile"]];
        else
            [rateCell.likeDislikeImage setImage:[UIImage imageNamed:@"thumbs_down_profile"]];
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
        [formatter setDateFormat:@"MM/dd/yyy"];
        [rateCell.dateLabel setText:[formatter stringFromDate:rec.timeRated]];
        cell = rateCell;
    }
    else {
        static NSString *CellIdentifier = @"friendCell";
        RMUProfileFriendCell *friendCell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        NSDictionary *friendDict = self.friendsArray[indexPath.row];
        NSString *nameOfFriend = [NSString stringWithFormat:(@"%@ %@"), [friendDict objectForKey:@"first_name"], [friendDict objectForKey:@"last_name"]];
        [friendCell.friendnNameLabel setText:nameOfFriend];
        FBProfilePictureView *profileView = [[FBProfilePictureView alloc]initWithProfileID:[friendDict objectForKey:@"facebook_id"] pictureCropping:FBProfilePictureCroppingSquare];
        [friendCell.numRatingsLabel setText:@""];
        [profileView setFrame:friendCell.friendImage.frame];
        [friendCell addSubview:profileView];
        cell = friendCell;
    }
    return cell;
}

/*
 *
 */

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.isOnPastRatings) {
        NSArray *rowArray = [self.ratingsArray[section] objectForKey:@"recArray"];
        return rowArray.count;
    }
    else
        return self.friendsArray.count;
}

/*
 *
 */

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (self.isOnPastRatings)
        return self.ratingsArray.count;
    else
        return 1;
}

/*
 *
 */

- (NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (self.isOnPastRatings)
        return [self.ratingsArray[section] objectForKey:@"restName"];
    else
        return @"FRIENDS";
}


#pragma mark - segue methods

/*
 *  Currently three segues is supported, profile to menu, that redirects a user to the menu of an item
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
         [self loadUserElements];
     }];
}


// State switchn
- (IBAction)showFriendsRatings:(id)sender
{
    [self.friendsButton setTintColor:[UIColor RMULogoBlueColor]];
    [self.pastRatingsButton setTintColor:[UIColor RMUDividingGrayColor]];
    self.isOnPastRatings = NO;
    if (self.friendsArray.count > 0) {
        // TODO make the conditional checkunderlying storage and reload the table and make another conditional check on if friends are on
        [self.profileTable setHidden:NO];
        [self.emptyView setHidden:YES];
        [self.profileTable reloadData];
    }
    else {
        if (self.isUserOnFacebook) {
            [self.topEmptyLabel setHidden:YES];
            [self.bottomEmptyLabel setHidden:YES];
            [self.loadingActivity setHidden:NO];
        }
        // Else hide the Table and show the empty view
        else {
            [self.profileTable setHidden:YES];
            [self.emptyView setHidden:NO];
            [self.topEmptyLabel setText:@"You don't have any friends yet!"];
            [self.bottomEmptyLabel setText:@"Connect through Facebook to search for friends and view their ratings."];
        }
    }
}

// State switcherz
- (IBAction)showPastRatings:(id)sender
{
    [self.topEmptyLabel setHidden:NO];
    [self.bottomEmptyLabel setHidden:NO];
    [self.loadingActivity setHidden:YES];
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
