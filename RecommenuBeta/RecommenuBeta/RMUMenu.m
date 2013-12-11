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

- (id)initWithDictionary:(NSDictionary*) menu
{
    self = [super init];
    if (self) {
        self.menuName = [menu objectForKey:@"name"];
        self.courses = [[NSMutableArray alloc]init];
        for (NSDictionary* course in [menu objectForKey:@"items"]) {
            [self.courses addObject:[[RMUMeal alloc]initWithDictionary:course]];
        }
    }
    return self;
}

@end

