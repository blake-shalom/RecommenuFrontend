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

	// Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.screenName = @"Other Profile Screen";

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
