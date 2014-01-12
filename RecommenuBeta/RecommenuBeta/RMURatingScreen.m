//
//  RMURatingScreen.m
//  RecommenuBeta
//
//  Created by Blake Ellingham on 12/29/13.
//  Copyright (c) 2013 Blake Ellingham. All rights reserved.
//

#import "RMURatingScreen.h"

@interface RMURatingScreen ()

// Regular properties
@property (weak,nonatomic) RMURestaurant *currentRestaurant;
@property (weak,nonatomic) RMUMenu *currentMenu;
@property (weak,nonatomic) RMUCourse *currentCourse;
@property BOOL isRatingVisible;
@property BOOL isMenuVisible;
@property (strong,nonatomic) RMUSavedUser *user;
@property (weak,nonatomic) RMUAppDelegate *appDelegate;

// IBOutlets
@property (weak, nonatomic) IBOutlet UILabel *restNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *currMenuLabel;
@property (weak, nonatomic) IBOutlet UILabel *leftSectionLabel;
@property (weak, nonatomic) IBOutlet UILabel *currSectionLabel;
@property (weak, nonatomic) IBOutlet UILabel *rightSectionLabel;
@property (weak, nonatomic) IBOutlet iCarousel *carousel;
@property (weak, nonatomic) IBOutlet UIButton *menuButton;

@end

@implementation RMURatingScreen

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
    self.carousel.clipsToBounds = YES;
    self.carousel.pagingEnabled = YES;
    self.revealViewController.delegate = self;
    
    // Set up managed context, user, and app delegate
    self.appDelegate = (RMUAppDelegate*) [UIApplication sharedApplication].delegate;
    NSFetchRequest *request = [[NSFetchRequest alloc]init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"RMUSavedUser" inManagedObjectContext:self.appDelegate.managedObjectContext];
    [request setEntity:entity];
    NSError *error;
    NSArray *fetchedArray = [self.appDelegate.managedObjectContext executeFetchRequest:request error:&error];
    self.user = fetchedArray[0];
}


- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidLoad];
}

- (void)viewWillDisappear:(BOOL)animated
{
    NSLog(@"In view will disappear");
    NSError *error;
    if (![self.appDelegate.managedObjectContext save:&error])
        NSLog(@"ERROR SAVING: %@", error);
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
    [self.carousel reloadData];
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
    [self.carousel reloadData];
}

#pragma mark - interactivity

/*
 *  Views other avalable menus at the restaurant
 */

- (IBAction)viewMenus:(id)sender
{
    
    [self.revealViewController performSelectorOnMainThread:@selector(revealToggle:) withObject:self waitUntilDone:NO];
}


#pragma mark - UITableViewDelagate

/*
 *  Returns appropriate height for individual rows, depdning on text etc
 */

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100.0f;
}


#pragma mark - UITableViewDataSource

/*
 *  Cell for row at index path, oh shizz
 */

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"rCell";
    NSInteger index = tableView.tag;
    RMUCourse *course = self.currentMenu.courses[index];
    [tableView registerNib:[UINib nibWithNibName:@"ratingTableCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:CellIdentifier];
    RMURatingCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    if (cell == nil) {
        cell = [[RMURatingCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    RMUMeal *currentMeal = course.meals[indexPath.row];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    [cell.mealLabel setText:currentMeal.mealName];
    [cell.descriptionLabel setText:currentMeal.mealDescription];
    [cell.priceLabel setText:currentMeal.mealPrice];
    
    cell.likeButton.tag = indexPath.row;
    cell.dislikeButton.tag = indexPath.row;
    [cell.likeButton addTarget:self action:@selector(likeEntree:) forControlEvents:UIControlEventTouchUpInside];
    [cell.dislikeButton addTarget:self action:@selector(dislikeEntree:) forControlEvents:UIControlEventTouchUpInside];
    cell.likeButton.selected = currentMeal.isLiked;
    cell.dislikeButton.selected = currentMeal.isDisliked;
    
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

#pragma mark - like methods

/*
 *  Likes an entree dudeee
 */

- (void)likeEntree:(UIButton*)button
{
    RMUMeal *meal = (RMUMeal*) self.currentCourse.meals[button.tag];
    if (!meal.isLiked && !meal.isDisliked){
        button.selected = !button.selected;
        meal.isLiked = YES;
        RMUSavedRecommendation *likeRecommendation = (RMUSavedRecommendation*) [NSEntityDescription insertNewObjectForEntityForName:@"RMUSavedRecommendation"
                                                                                                             inManagedObjectContext:self.appDelegate.managedObjectContext];
        likeRecommendation.entreeFoursquareID = meal.mealID;
        likeRecommendation.entreeName = meal.mealName;
        likeRecommendation.restaurantName = self.currentRestaurant.restName;
        likeRecommendation.restFoursquareID = self.currentRestaurant.restFoursquareID;
        likeRecommendation.isRecommendPositive = [NSNumber numberWithBool:YES];
        likeRecommendation.timeRated = [NSDate date];
        likeRecommendation.entreeDesc = meal.mealDescription;
        [self.user addRatingsForUserObject:likeRecommendation];
        [self postRatingToRMUDBFromSavedRecommendation:likeRecommendation];
    }
}

/*
 *  Dislikes an entree
 */

- (void)dislikeEntree:(UIButton*)button
{
    RMUMeal *meal = (RMUMeal*) self.currentCourse.meals[button.tag];
    if (!meal.isLiked && !meal.isDisliked){
        button.selected = !button.selected;
        meal.isDisliked = YES;
        
        RMUSavedRecommendation *dislikeRecommendation = (RMUSavedRecommendation*) [NSEntityDescription insertNewObjectForEntityForName:@"RMUSavedRecommendation"
                                                                                                             inManagedObjectContext:self.appDelegate.managedObjectContext];
        dislikeRecommendation.entreeFoursquareID = meal.mealID;
        dislikeRecommendation.entreeName = meal.mealName;
        dislikeRecommendation.restaurantName = self.currentRestaurant.restName;
        dislikeRecommendation.restFoursquareID = self.currentRestaurant.restFoursquareID;
        dislikeRecommendation.isRecommendPositive = [NSNumber numberWithBool:NO];
        dislikeRecommendation.timeRated = [NSDate date];
        dislikeRecommendation.entreeDesc = meal.mealDescription;
        
        [self.user addRatingsForUserObject:dislikeRecommendation];
        [self postRatingToRMUDBFromSavedRecommendation:dislikeRecommendation];
    }
}

/*
 *  Posts to RMU DB that the user liked some content
 */

- (void)postRatingToRMUDBFromSavedRecommendation: (RMUSavedRecommendation*) recommendation
{
    if (self.user.userURI) {
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
        NSString *isPositive;
        if (recommendation.isRecommendPositive.boolValue){
            isPositive = @"True";
        }
        else {
            isPositive = @"False";
        }
        [manager POST:[NSString stringWithFormat:(@"http://glacial-ravine-3577.herokuapp.com/api/v1/rating/")]
           parameters:@{@"foursquare_id": recommendation.entreeFoursquareID,
                        @"positive" : isPositive,
                        @"user" : self.user.userURI}
              success:^(AFHTTPRequestOperation *operation, id responseObject) {
                  // Succeeded, Log the response
                  NSLog(@"%@", responseObject);
              }
              failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                  // Failed. Log the user
                  NSLog(@"error: %@ with response string: %@", error, operation.responseString);
              }];
    }
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
    UITableView *currentTable = (UITableView*) carousel.currentItemView;
    NSInteger index = currentTable.tag;
    self.currentCourse = self.currentMenu.courses[index];
    RMUCourse *course = self.currentCourse;
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
    [currentTable reloadData];
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

