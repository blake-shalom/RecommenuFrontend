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

@interface RMUMenuScreen : UIViewController
<UITableViewDataSource, UITableViewDelegate, iCarouselDataSource, iCarouselDelegate, SWRevealViewControllerDelegate, UIAlertViewDelegate>

- (void)setupViews;
- (void)setupMenuElementsWithRestaurant:(RMURestaurant*)restaurant;
- (void)loadMenu: (RMUMenu*)menu;

@end
