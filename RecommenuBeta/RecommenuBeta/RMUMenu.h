//
//  RMUMenu.h
//  RecommenuBeta
//
//  Created by Blake Ellingham on 12/10/13.
//  Copyright (c) 2013 Blake Ellingham. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RMUMenu : NSObject

@property NSString *restaurantName;
@property NSString *restaurantAddress;
@property NSMutableArray *courses;

- (id)initWithFoursquareID:(NSNumber*)foursquareID;

@end
