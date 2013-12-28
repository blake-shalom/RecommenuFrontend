//
//  RMURevealViewController.h
//  RecommenuBeta
//
//  Created by Blake Ellingham on 12/27/13.
//  Copyright (c) 2013 Blake Ellingham. All rights reserved.
//

#import "SWRevealViewController.h"
#import "RMURestaurant.h"
#import "RMUMenuScreen.h"

@interface RMURevealViewController : SWRevealViewController

@property (strong,nonatomic) RMURestaurant *currentRestaurant;

- (void)getRestaurantWithFoursquareID:(NSNumber *)foursquareID andName:(NSString *)name;

@end
