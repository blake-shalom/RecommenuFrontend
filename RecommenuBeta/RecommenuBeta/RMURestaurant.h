//
//  RMURestaurant.h
//  RecommenuBeta
//
//  Created by Blake Ellingham on 12/11/13.
//  Copyright (c) 2013 Blake Ellingham. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
#import "RMUMenu.h"
@interface RMURestaurant : NSObject

@property NSMutableArray *menus;
@property NSString *restName;
@property NSString *restFoursquareID;

-(id) initWithDictionary:(NSDictionary *)restaurantDictionary andRestaurantName:(NSString*) name;

@end
