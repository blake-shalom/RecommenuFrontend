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
    self.settingsTable.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];

}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.screenName = @"Settings Screen";
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
    RMUAppDelegate *delegate = (RMUAppDelegate*) [UIApplication sharedApplication].delegate;
    RMUSavedUser *currentUser = [delegate fetchCurrentUser];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//    [manager GET:[NSString stringWithFormat:(@"http://glacial-ravine-3577.herokuapp.com/%@/foodiesvip"),
//      parameters:nil
//         success:^(AFHTTPRequestOperation *operation, id responseObject) {
//            
//         }
//         failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//             
//         }];
}


@end
