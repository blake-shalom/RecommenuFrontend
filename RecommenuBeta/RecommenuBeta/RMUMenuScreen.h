//
//  RMUMenuScreen.h
//  RecommenuBeta
//
//  Created by Blake Ellingham on 12/18/13.
//  Copyright (c) 2013 Blake Ellingham. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "iCarousel.h"
#import "RMURestaurant.h"
#import "RMUCourse.h"
#import "RMUMenuCell.h"
#import "RMUMenuTable.h"
#import "RMURevealViewController.h"
#import "RMUButton.h"
#import "GAITrackedViewController.h"
#import "RMUFoodieFriendPopup.h"
#import "RMUAnimationClass.h"
#import "RMUOtherProfileScreen.h"

@interface RMUMenuScreen : GAITrackedViewController
<UITableViewDataSource, UITableViewDelegate, iCarouselDataSource,
iCarouselDelegate, SWRevealViewControllerDelegate, UIAlertViewDelegate,
RMUFoodieFriendPopupDelegate>

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *indicator;

- (void)setupViews;
- (void)setupMenuElementsWithRestaurant:(RMURestaurant*)restaurant;
- (void)loadMenu: (RMUMenu*)menu;

@end