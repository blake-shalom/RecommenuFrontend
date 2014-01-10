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

@property NSMutableArray *ratingsArray;

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
    
    // Set the tableview's properties
    self.profileTable.delegate = self;
    self.profileTable.dataSource = self;
    
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
        // Handle User details
        if (!user.facebookID) {
            [self.nameLabel setText:@"Anonymous User"];
            [self.facebookButton setImage:[UIImage imageNamed:@"facebook_off"] forState:UIControlStateNormal];
#warning need to do generic picture
        }
        else {
            [self.facebookButton setImage:[UIImage imageNamed:@"facebook_on"] forState:UIControlStateNormal];

#warning - TODO Facebook mapping for pic/name
        }
        
        // Handle rating storage
        if (user.ratingsForUser.count == 0) {
            [self.currentRatingsLabel setText:@"0 Ratings"];
        }
        else {
            // Sort ratings into containers
        }
    }
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableView Data source

/*
 *
 */

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [[UITableViewCell alloc]init];
}

/*
 *
 */

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

/*
 *
 */

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}



@end
