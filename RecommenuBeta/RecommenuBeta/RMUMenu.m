//
//  RMUMenu.m
//  RecommenuBeta
//
//  Created by Blake Ellingham on 12/10/13.
//  Copyright (c) 2013 Blake Ellingham. All rights reserved.
//

#import "RMUMenu.h"
#import "RMUCourse.h"

@implementation RMUMenu

/*
 *  Called from a RMURestaurant, sets initial properties and then iterates over the courses in the menu
 */

- (id)initWithDictionary:(NSDictionary*) menu
{
    self = [super init];
    if (self) {
        self.menuName = [menu objectForKey:@"name"];
        self.menuFoursquareID = [menu objectForKey:@"menuId"];
        self.courses = [[NSMutableArray alloc]init];
        for (NSDictionary* course in [[menu objectForKey:@"entries"] objectForKey:@"items"]) {
            [self.courses addObject:[[RMUCourse alloc]initWithDictionary:course]];
        }
    }
    return self;
}

@end

