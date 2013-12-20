//
//  RMUCourse.m
//  RecommenuBeta
//
//  Created by Blake Ellingham on 12/10/13.
//  Copyright (c) 2013 Blake Ellingham. All rights reserved.
//

#import "RMUCourse.h"

@implementation RMUCourse

- (id)initWithDictionary:(NSDictionary*) course
{
    self = [super init];
    if (self) {
        self.courseName = [course objectForKey:@"name"];
        NSLog(@"course member: %@", self.courseName);
        self.meals = [[NSMutableArray alloc]init];
        for (NSDictionary* meal in [course objectForKey:@"items"]) {
            [self.meals addObject:[[RMUMeal alloc]initWithDictionary:meal]];
        }
    }
    return self;
}

@end
