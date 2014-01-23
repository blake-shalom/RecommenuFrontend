//
//  RMUMenuScreen.m
//  RecommenuBeta
//
//  Created by Blake Ellingham on 12/18/13.
//  Copyright (c) 2013 Blake Ellingham. All rights reserved.
//

#import "RMUMenuScreen.h"

@interface RMUMenuScreen ()

// Regular properties
@property (weak,nonatomic) RMURestaurant *currentRestaurant;
@property (weak,nonatomic) RMUMenu *currentMenu;
@property (weak,nonatomic) RMUCourse *currentCourse;
@property BOOL isRatingVisible;
@property BOOL isMenuVisible;

// IBOutlets
@property (weak, nonatomic) IBOutlet UILabel *restNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *currMenuLabel;
@property (weak, nonatomic) IBOutlet UILabel *leftSectionLabel;
@property (weak, nonatomic) IBOutlet UILabel *currSectionLabel;
@property (weak, nonatomic) IBOutlet UILabel *rightSectionLabel;
@property (weak, nonatomic) IBOutlet iCarousel *carousel;
@property (weak, nonatomic) IBOutlet UIButton *menuButton;
@property (weak, nonatomic) IBOutlet UIView *missingMenuView;
@property (weak, nonatomic) IBOutlet RMUButton *reportMenuButton;


@end

@implementation RMUMenuScreen

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
    [self.restNameLabel setTextColor:[UIColor RMUTitleColor]];
    [self.currMenuLabel setTextColor:[UIColor RMUTitleColor]];
    [self.leftSectionLabel setTextColor:[UIColor RMUDividingGrayColor]];
    [self.rightSectionLabel setTextColor:[UIColor RMUDividingGrayColor]];
    [self.currSectionLabel setTextColor:[UIColor RMULogoBlueColor]];
    self.carousel.type = iCarouselTypeLinear;
    self.carousel.delegate = self;
    self.carousel.dataSource = self;
    self.carousel.decelerationRate = 0.5;
    [self.revealViewController panGestureRecognizer];
    [self.revealViewController tapGestureRecognizer];
    self.revealViewController.delegate = self;
    self.carousel.clipsToBounds = YES;
    self.carousel.pagingEnabled = YES;
    
    // Set up button UI
    [self.reportMenuButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.reportMenuButton setBackgroundColor:[UIColor RMULogoBlueColor]];
    self.reportMenuButton.isBlue = YES;
    self.reportMenuButton.layer.borderColor = [UIColor blackColor].CGColor;
    self.reportMenuButton.layer.borderWidth = 1.0f;
    [self.missingMenuView setHidden:YES];
    
	// Do any additional setup after loading the view.
    
}


- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupViews
{
    [self.restNameLabel setText:[self.currentRestaurant.restName uppercaseString]];
    [self.currMenuLabel setText:self.currentMenu.menuName];
    [self.currSectionLabel setText:self.currentCourse.courseName];
    // If there are more than one course set the label to each of the two courses to the left and right
    if (self.currentMenu.courses.count > 1) {
        RMUCourse *course = self.currentMenu.courses[self.currentMenu.courses.count -1 ];
        [self.leftSectionLabel setText:@""];
        course = self.currentMenu.courses[1];
        [self.rightSectionLabel setText:course.courseName];
    }
    else {
        [self.leftSectionLabel setText:@""];
        [self.rightSectionLabel setText:@""];
    }
    if (self.currentRestaurant.menus.count < 1)
        [self.missingMenuView setHidden:NO];
    [self.carousel reloadData];
    
    // Menu visited, set notifications
    if (self.currentRestaurant.menus.count > 0){
        RMUAppDelegate *delegate = (RMUAppDelegate*) [UIApplication sharedApplication].delegate;
        delegate.savedRestaurant = self.currentRestaurant;
        delegate.shouldDelegateNotifyUser = YES;
    }

}

- (void)setupMenuElementsWithRestaurant:(RMURestaurant*)restaurant
{
    self.currentRestaurant = restaurant;
    if (self.currentRestaurant.menus.count > 0) {
        self.currentMenu = self.currentRestaurant.menus[0];
        self.currentCourse = self.currentMenu.courses[0];
    }
}

- (void)loadMenu: (RMUMenu*)menu
{
    self.currentMenu = menu;
    self.currentCourse = self.currentMenu.courses[0];
    [self setupViews];
    [self.carousel scrollToItemAtIndex:0 animated:NO];
    [self.carousel reloadData];
}

#pragma mark - UIAlertView Delegate

/*
 *  Returns home to the main menu
 */

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [self performSegueWithIdentifier:@"menuToHome" sender:self];
}

#pragma mark - interactivity

/*
 *  Reports the menu as invalid baddy bad bad
 */


- (IBAction)reportMenu:(id)sender
{
    NSLog(@"You is sooooo reported");
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Menu Reported!" message:@"Thanks for reporting this menu!" delegate:self cancelButtonTitle:@"Return Home" otherButtonTitles:nil];
    
    [alert show];
}

/*
 *  Views other avalable menus at the restaurant
 */

- (IBAction)viewMenus:(id)sender
{
    [self.revealViewController performSelectorOnMainThread:@selector(revealToggle:) withObject:self waitUntilDone:NO];
}

/*
 *  Sees the ratings for all dishes, toggle-able
 */

- (IBAction)seeRatings:(id)sender
{
    UIButton *button = (UIButton*)sender;
    if (self.isRatingVisible) {
        self.isRatingVisible = NO;
        [button setImage:[UIImage imageNamed:@"icon_graph"] forState:UIControlStateNormal];
    }
    else {
        self.isRatingVisible = YES;
        [button setImage:[UIImage imageNamed:@"icon_graph_select"] forState:UIControlStateNormal];
    }    
//    UITableView *tableView = (UITableView*) self.carousel.currentItemView;
//    [tableView reloadData];
    [self.carousel reloadData];
}

/*
 *  Upon click, moves the section forward, unless at the last index
 */

- (IBAction)moveSectionBackward:(id)sender
{
    NSInteger index = self.carousel.currentItemIndex;
    if (index > 0){
        [self.carousel scrollToItemAtIndex:index - 1  animated:YES];
    }
}

/*
 *  Upon click moves the section backward, unless at first section index
 */


- (IBAction)moveSectionForward:(id)sender
{
    NSInteger index = self.carousel.currentItemIndex;
    if (index < self.currentMenu.courses.count -1){
        [self.carousel scrollToItemAtIndex:index + 1 animated:YES];
    }
}


#pragma mark - UITableViewDelagate

/*
 *  Returns appropriate height for individual rows, depdning on text etc
 */

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 72.0f;
}

/*
 *  Manages Selection of cells by checkbox
 */

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

}

/*
 *  Deselection of cells by unchecking checkbox
 */

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

#pragma mark - UITableViewDataSource

/*
 *  Cell for row at index path, oh shizz
 */

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    NSInteger index = tableView.tag;
    RMUCourse *course = self.currentMenu.courses[index];
    [tableView registerNib:[UINib nibWithNibName:@"menuTableCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:CellIdentifier];
    RMUMenuCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[RMUMenuCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    RMUMeal *currentMeal = course.meals[indexPath.row];
    [cell.mealLabel setText:currentMeal.mealName];
    [cell.descriptionLabel setText:currentMeal.mealDescription];
    [cell.priceLabel setText:currentMeal.mealPrice];
    
    [cell.crowdLikeLabel setText:[currentMeal.crowdLikes stringValue]];
    [cell.friendLikeLabel setText:[currentMeal.friendLikes stringValue]];
    [cell.expertLikeLabel setText:[currentMeal.expertLikes stringValue]];
    [cell.donutGraph displayLikes:[currentMeal.crowdLikes integerValue] dislikes:[currentMeal.crowdDislikes integerValue]];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (self.isRatingVisible) {
        [cell.descView setHidden:YES];
        [cell.likeView setHidden:NO];
    }
    else {
        [cell.descView setHidden:NO];
        [cell.likeView setHidden:YES];
    }
    return cell;
}

/*
 *  Returns the number of rows in each section of the table
 */

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger index = tableView.tag;
    RMUCourse *indexedCourse = self.currentMenu.courses[index];
    return indexedCourse.meals.count;
}

#pragma mark -  iCarousel Methods

/*
 *  Returns the number of views necessary in the carousel
 */

- (NSUInteger)numberOfItemsInCarousel:(iCarousel *)carousel
{
    return self.currentMenu.courses.count;
}

/*
 *  Returns the view for each carousel, similar to CellForRow
 */

- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSUInteger)index reusingView:(UIView *)view
{
    if (view == nil) {
        // if the view is nil, create a new view
        CGRect oldFrame = self.carousel.frame;
        CGRect newFrame = CGRectMake(oldFrame.origin.x + 8, oldFrame.origin.y + 8, oldFrame.size.width - 16, oldFrame.size.height -16);
        RMUMenuTable *tableView = [[RMUMenuTable alloc] initWithFrame:newFrame];
        tableView.delegate = self;
        tableView.dataSource = self;
        view = tableView;
        // Tag is assigned at the bottom to give the initial views a tag
        view.tag = index;
    }
    else {
        // View was already created, just refresh the table. Tag is assigned at the beginning before table can reload data
        view.tag = index;
        RMUMenuTable *tableview = (RMUMenuTable*) view;
        [tableview reloadData];
    }
    return view;
}

- (void)carouselCurrentItemIndexDidChange:(iCarousel *)carousel
{
    NSInteger index = carousel.currentItemView.tag;
    RMUCourse *course = self.currentMenu.courses[index];
    [self.currSectionLabel setText:course.courseName];
    if (index > 0) {
        course = self.currentMenu.courses[index-1];
        [self.leftSectionLabel setText:course.courseName];
    }
    else
        [self.leftSectionLabel setText:@""];
    
    if (index < self.currentMenu.courses.count - 1) {
        course = self.currentMenu.courses[index+1];
        [self.rightSectionLabel setText:course.courseName];
    }
    else
        [self.rightSectionLabel setText:@""];
    
}

- (CGFloat)carousel:(iCarousel *)carousel valueForOption:(iCarouselOption)option withDefault:(CGFloat)value
{
    switch (option)
    {
        case iCarouselOptionSpacing:
        {
            return 1.2;
        }
        case iCarouselOptionVisibleItems:
        {
            return 3;
        }
        default:
        {
            return value;
        }
    }
}

#pragma mark - segue methods

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"menuToRating"]){
        RMURevealViewController  *ratingScreen = (RMURevealViewController*)segue.destinationViewController;
        ratingScreen.currentRestaurant = self.currentRestaurant;
    }
}

#pragma mark - SWReveal Delegate

/*
 *  Freezes controls on the main page when you navigate to the rear page
 */

- (void)revealController:(SWRevealViewController *)revealController didMoveToPosition:(FrontViewPosition)position
{
    if (position == 3) {
        [self.carousel setUserInteractionEnabled:YES];
        [self.menuButton setImage:[UIImage imageNamed:@"icon_list"] forState:UIControlStateNormal];
    }
    else if (position == 4) {
        [self.carousel setUserInteractionEnabled:NO];
        [self.menuButton setImage:[UIImage imageNamed:@"icon_list_select"] forState:UIControlStateNormal];
    }
}

@end
