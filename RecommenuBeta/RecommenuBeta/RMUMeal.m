//
//  RMUMeal.m
//  RecommenuBeta
//
//  Created by Blake Ellingham on 12/10/13.
//  Copyright (c) 2013 Blake Ellingham. All rights reserved.
//

#import "RMUMeal.h"

@implementation RMUMeal

- (id)initWithDictionary:(NSDictionary*) mealDictionary
{
    self = [[RMUMeal alloc]init];
    if (self) {
        self.mealName = [mealDictionary objectForKey:@"name"];
        self.mealDescription = [mealDictionary objectForKey:@"description"];
        self.mealID = [mealDictionary objectForKey:@"entryId"];
        self.mealPrice = [mealDictionary objectForKey:@"price"];
    }
    return self;
}

//- (void)initializeAllRankings: 
@end
