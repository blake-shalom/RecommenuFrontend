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

@interface RMUMenuScreen : UIViewController

- (void)getRestaurantWithFoursquareID:(NSNumber *)foursquareID andName:(NSString *)name;

@end
