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
#import "RMUSideMenuScreen.h"
#import "RMURatingScreen.h"

@interface RMURevealViewController : SWRevealViewController
<RMUSideMenuScreenDelegate>
@property (strong,nonatomic) RMURestaurant *currentRestaurant;

- (void)getRestaurantWithFoursquareID:(NSString *)foursquareID andName:(NSString *)name;

@end


