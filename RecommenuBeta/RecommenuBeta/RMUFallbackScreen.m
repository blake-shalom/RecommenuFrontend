//
//  RMUFallbackScreen.m
//  RecommenuBeta
//
//  Created by Blake Ellingham on 12/9/13.
//  Copyright (c) 2013 Blake Ellingham. All rights reserved.
//

#import "RMUFallbackScreen.h"

@interface RMUFallbackScreen ()

@property (nonatomic)  NSMutableArray *fallbackRestaurants;
@property NSDictionary *selectedFallback;
@end

@implementation RMUFallbackScreen

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.fallbackRestaurants = [[NSMutableArray alloc]init];
    }
    return self;
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

#pragma mark - Setters

/*
 *  A setter for the fallbacks
 */

- (void) pushFallbackRestaurants:(NSMutableArray *)fallbacks
{
    self.fallbackRestaurants = fallbacks;
}

#pragma mark - UITableview Delegate

/*
 *  returns number of rows
 */

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.fallbackRestaurants.count;
}

/*
 *  Accessses specific cell at an index path
 */

- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    [cell.textLabel setText:[self.fallbackRestaurants[[indexPath row]] objectForKey:@"name"]];
    [cell.detailTextLabel setText:[[self.fallbackRestaurants[[indexPath row]] objectForKey:@"location"]objectForKey:@"address"]];
    return cell;
}

/*
 *  Return one section fo the table
 */

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

/*
 *  selects a row and sets an instance variable to the selected dictionary
 */

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%@", [self.fallbackRestaurants[[indexPath row]] objectForKey:@"id"]);
    self.selectedFallback = self.fallbackRestaurants[indexPath.row];
    [self performSegueWithIdentifier:@"fallbackToMenu" sender:self];
}

/*
 *  Sets up menu screen upon activation of segue
 */

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"fallbackToMenu"]){
        RMUMenuScreen *menuScreen = (RMUMenuScreen*)segue.destinationViewController;
        [menuScreen getRestaurantWithFoursquareID:[self.selectedFallback objectForKey:@"id"] andName:[self.selectedFallback objectForKey:@"name"]];
    }
}

@end
