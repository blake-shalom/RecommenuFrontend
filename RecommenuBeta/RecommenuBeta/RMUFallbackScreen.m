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

@end

@implementation RMUFallbackScreen

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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Setters

/*
 *  A setter for the fallbacks
 */

- (void) setFallbackRestaurants:(NSMutableArray *)fallbacks
{
    self.fallbackRestaurants = [[NSMutableArray alloc]init];
    self.fallbackRestaurants = fallbacks;
}

#pragma mark - UITableview Delegate

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.fallbackRestaurants.count;
}

- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    [cell.textLabel setText:[self.fallbackRestaurants[[indexPath row]] objectForKey:@"name"]];
    [cell.detailTextLabel setText:[self.fallbackRestaurants[[indexPath row]] objectForKey:@"name"]];
    return cell;
}

@end
