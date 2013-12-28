//
//  RMUFallbackScreen.h
//  RecommenuBeta
//
//  Created by Blake Ellingham on 12/9/13.
//  Copyright (c) 2013 Blake Ellingham. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFNetworking.h"
#import "RMUMenuScreen.h"
#import "RMURevealViewController.h"

@interface RMUFallbackScreen : UITableViewController

- (void) pushFallbackRestaurants:(NSMutableArray *)fallbacks;

@end
