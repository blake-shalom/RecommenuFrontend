//
//  RMUSearchScreen.m
//  RecommenuBeta
//
//  Created by Blake Ellingham on 11/29/13.
//  Copyright (c) 2013 Blake Ellingham. All rights reserved.
//

#import "RMUSearchScreen.h"

@interface RMUSearchScreen ()

@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UIButton *stopEditingButton;

@end

@implementation RMUSearchScreen

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

#pragma mark - Search Bar Delegate

/*
 *  Began editing, bring button to the front
 */

-(void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    [self.view bringSubviewToFront:self.stopEditingButton];
}

#pragma mark - Interactivity

/*
 *  Stop editing button clicked, stop editing
 */

- (IBAction)stopEditing:(id)sender
{
    NSLog(@"STOP EDITING FOOL!");
}

@end
