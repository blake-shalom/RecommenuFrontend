//
//  RMURatingScreen.h
//  RecommenuBeta
//
//  Created by Blake Ellingham on 12/29/13.
//  Copyright (c) 2013 Blake Ellingham. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "iCarousel.h"
#import "RMURestaurant.h"
#import "RMUCourse.h"
#import "RMUMenuCell.h"
#import "RMUMenuTable.h"
#import "RMURevealViewController.h"
#import "RMURatingCell.h"

@interface RMURatingScreen : UIViewController
<UITableViewDataSource, UITableViewDelegate, iCarouselDataSource, iCarouselDelegate>

- (void)setupViews;
- (void)setupMenuElementsWithRestaurant:(RMURestaurant*)restaurant;
- (void)loadMenu: (RMUMenu*)menu;

@end
