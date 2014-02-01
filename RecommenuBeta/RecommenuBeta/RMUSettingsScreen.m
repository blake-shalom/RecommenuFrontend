//
//  RMUSettingsScreen.m
//  RecommenuBeta
//
//  Created by Blake Ellingham on 11/29/13.
//  Copyright (c) 2013 Blake Ellingham. All rights reserved.
//

#import "RMUSettingsScreen.h"

@interface RMUSettingsScreen ()

@property (weak, nonatomic) IBOutlet UITableView *settingsTable;
@property (weak, nonatomic) IBOutlet UILabel *foodieLoginLabel;
@property (weak, nonatomic) IBOutlet RMUButton *foodieSignInButton;
@property (weak, nonatomic) IBOutlet UIImageView *foodieOnImage;
@property (weak, nonatomic) IBOutlet UIView *overlaySignInView;
@property (weak, nonatomic) IBOutlet RMUButton *confirmSignInButton;
@property (weak, nonatomic) IBOutlet UITextField *enterCodeTextField;
@property (weak, nonatomic) IBOutlet UIImageView *gradientImage;
@property (weak, nonatomic) IBOutlet UIButton *dismissKeyButton;

@end

@implementation RMUSettingsScreen

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
    self.foodieSignInButton.isBlue = YES;
    self.confirmSignInButton.isBlue = YES;
    self.enterCodeTextField.delegate = self;
}

- (void)viewDidAppear:(BOOL)animated
{
    self.screenName = @"Settings Screen";
    [super viewDidAppear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - TableView Datasource methods

/*
 *  Cell for row, pretty lazy and non-adaptive
 */

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
//        case 0:
//            return [tableView dequeueReusableCellWithIdentifier:@"locationCell"];
//            break;
            
        default:
            return [[UITableViewCell alloc]init];
            break;
    }
}

/*
 *  Number of cells in section, again not very adaptive
 */

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

#pragma mark - Interactivity

- (IBAction)connectFoodie:(id)sender
{
    //Animate in gradient + popup
    [self animateInGradient];
}
- (IBAction)signInFoodie:(id)sender
{
    NSLog(@"EXECUTING....");
    RMUAppDelegate *delegate = (RMUAppDelegate*) [UIApplication sharedApplication].delegate;
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    NSString *userID = [delegate returnUserName];
    [manager GET:[NSString stringWithFormat:(@"http://glacial-ravine-3577.herokuapp.com/data/foodies/%@/%@"),userID, self.enterCodeTextField.text]
                                 parameters:nil
                                    success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                        NSLog(@"RESPONSE: %@", responseObject);
                                        
                                        
                                    }
                                    failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                        NSLog(@"RESPONSE STRING: %@", operation.responseString);
                                        NSLog(@"ERROR: %@", error);
                                    }];

}

/*
 *  Dismisses the foodie popup from the small X on the card
 */

- (IBAction)dismissFoodieSignin:(id)sender
{
    [self.overlaySignInView setHidden:YES];
    [self animateOutGradient];
}


- (IBAction)dismissKeyboard:(id)sender
{
    [self.enterCodeTextField resignFirstResponder];
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
                          delay:0.5f
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         [self.gradientImage setAlpha:1.0f];
                     } completion:^(BOOL finished) {
                         [self animatePopup];
                     }];
}

- (void)animateOutGradient
{
    [self.gradientImage setAlpha:1.0f];
    [self.gradientImage setHidden:NO];
    [UIView animateWithDuration:0.3f
                          delay:0.2f
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         [self.gradientImage setAlpha:0.0f];
                     } completion:^(BOOL finished) {
                         
                     }];
}

/*
 *  Animates in the popup to the right location
 */

- (void)animatePopup
{
    [self.overlaySignInView setHidden:NO];
    [RMUAnimationClass animateFlyInView:self.overlaySignInView
                           withDuration:0.1f
                              withDelay:0.0f
                          fromDirection:buttonAnimationDirectionTop
                         withCompletion:Nil
                             withBounce:YES];
}

#pragma mark - UITextView Delegate

/*
 *  Began editing, bring button to the front
 */

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [self.view bringSubviewToFront:self.dismissKeyButton];
}

/*
 *  Ended editing send button backwards
 */

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [self.view sendSubviewToBack:self.dismissKeyButton];
}


@end
