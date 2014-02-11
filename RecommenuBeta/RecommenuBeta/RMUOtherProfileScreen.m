//
//  RMUOtherProfileScreen.m
//  RecommenuBeta
//
//  Created by Blake Ellingham on 1/16/14.
//  Copyright (c) 2014 Blake Ellingham. All rights reserved.
//

#import "RMUOtherProfileScreen.h"

@interface RMUOtherProfileScreen ()

@property (weak, nonatomic) IBOutlet RMUButton *blogButton;
@property (weak, nonatomic) IBOutlet UIImageView *foodieBadge;
@property (weak, nonatomic) IBOutlet UITableView *profileTable;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *numRatingsLabel;
@property (weak, nonatomic) IBOutlet UIView *hideProfileView;
@property (weak, nonatomic) IBOutlet UIView *profilePicView;
@property (weak, nonatomic) IBOutlet UIView *topProfileView;

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
    if (self.isFoodie)
        [self showFoodieElements];
    else
        [self hideFoodieElements];

    if (self.facebookID)
        [self handleFacebookProfile];
    if (self.nameOfOtherUser)
        [self.nameLabel setText:self.nameOfOtherUser];
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
