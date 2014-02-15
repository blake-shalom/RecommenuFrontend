//
//  RMUOtherProfileScreen.m
//  RecommenuBeta
//
//  Created by Blake Ellingham on 1/16/14.
//  Copyright (c) 2014 Blake Ellingham. All rights reserved.
//

#import "RMUOtherProfileScreen.h"

#warning TODO, work out the damn black screen error

@interface RMUOtherProfileScreen ()

@property (weak, nonatomic) IBOutlet RMUButton *blogButton;
@property (weak, nonatomic) IBOutlet UIImageView *foodieBadge;
@property (weak, nonatomic) IBOutlet UITableView *profileTable;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *numRatingsLabel;
@property (weak, nonatomic) IBOutlet UIView *hideProfileView;
@property (weak, nonatomic) IBOutlet UIView *profilePicView;
@property (weak, nonatomic) IBOutlet UIView *topProfileView;
//@property (weak, nonatomic) IBOutlet UIView *loadView;
//@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *loadIndicator;
//@property (weak, nonatomic) IBOutlet UILabel *noRatingsLabel;

@end

@implementation RMUOtherProfileScreen

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
    self.blogButton.isBlue = YES;
    [self.blogButton setBackgroundColor:[UIColor RMULogoBlueColor]];
    
    //Handle foodie elements
    if (self.isFoodie)
        [self showFoodieElements];
    else
        [self hideFoodieElements];

    // Handle facebook elements
    if (self.facebookID)
        [self handleFacebookProfile];
    if (self.nameOfOtherUser)
        [self.nameLabel setText:self.nameOfOtherUser];
    
    // Load Recommendations
    [self loadRecommendations];
    
	// Do any additional setup after loading the view.
}

- (void)handleFacebookProfile
{
    [self.hideProfileView setHidden:NO];
    CGRect profPicFrame = self.profilePicView.frame;
    CGRect modifiedProf = CGRectMake(profPicFrame.origin.x, profPicFrame.origin.y, profPicFrame.size.width - 5.0f, profPicFrame.size.height);
    
    
    // Success! Include your code to handle the results here
    FBProfilePictureView *profileView = [[FBProfilePictureView alloc]initWithProfileID:self.facebookID pictureCropping:FBProfilePictureCroppingSquare];

    [profileView setFrame:modifiedProf];
    [self.topProfileView addSubview:profileView];
    UIImageView *circleView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"profile_circle_user"]];
    [circleView setFrame: profPicFrame];
    [self.topProfileView addSubview:circleView];
    [self.hideProfileView setHidden:YES];
}

- (void)viewDidAppear:(BOOL)animated
{
    self.screenName = @"Other Profile Screen";
    [super viewDidAppear:animated];
}

- (void)loadRecommendations
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:[NSString stringWithFormat:(@"http://glacial-ravine-3577.herokuapp.com/api/v1/rating/?user__username=%@"), self.RMUUsername]
      parameters:Nil
         success:^(AFHTTPRequestOperation *operation, id responseObject) {
             NSLog(@"SUCCESS GETTING RATINGS RESPONSE OBJECT: %@", responseObject);
         }
         failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             NSLog(@"ERROR: %@ with response string: %@", error, operation.responseString);
         }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 *  Pops VC on press of back button
 */

- (IBAction)backScreen:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

/*
 *  Hides elements of the foodie for other friend user
 */

- (void)hideFoodieElements
{
    [self.blogButton setHidden:YES];
    [self.foodieBadge setHidden:YES];
}

/*
 * Shows foodie elements for a foodie user
 */

- (void)showFoodieElements
{
    [self.blogButton setHidden:NO];
    [self.foodieBadge setHidden:NO];
}

@end
