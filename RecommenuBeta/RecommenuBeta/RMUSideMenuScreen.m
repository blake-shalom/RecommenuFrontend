//
//  RMUSideMenuScreen.m
//  RecommenuBeta
//
//  Created by Blake Ellingham on 12/27/13.
//  Copyright (c) 2013 Blake Ellingham. All rights reserved.
//

#import "RMUSideMenuScreen.h"

@interface RMUSideMenuScreen ()

@property (weak,nonatomic) RMURestaurant *currentRestaurant;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation RMUSideMenuScreen


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 *  Loads in current Restaurant
 */

- (void)loadCurrentRestaurant: (RMURestaurant*)restaurant
{
    self.currentRestaurant = restaurant;
    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return self.currentRestaurant.menus.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"menuCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    RMUMenu *menu = self.currentRestaurant.menus[indexPath.row];
    [cell.textLabel setText:menu.menuName];
    // Configure the cell...
    
    return cell;
}

/*
 *  Upon selection of an index tell delegate to swap out current menu for the selected one
 */

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    RMUMenu *changedMenu = self.currentRestaurant.menus[indexPath.row];
    [self.delegate loadMenuScreenWithMenu:changedMenu];
    [self.revealViewController performSelectorOnMainThread:@selector(revealToggle:) withObject:self waitUntilDone:NO];
}

/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */

@end
