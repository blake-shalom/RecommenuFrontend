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
    self = [super init];
    if (self) {
        self.mealName = [mealDictionary objectForKey:@"name"];
        self.mealDescription = [mealDictionary objectForKey:@"description"];
        self.mealID = [mealDictionary objectForKey:@"entryId"];
        self.mealPrice = [mealDictionary objectForKey:@"price"];
        NSLog(@"meal members: %@, %@, %@, %@", self.mealName, self.mealDescription, self.mealID, self.mealPrice);
    }
    return self;
}

//- (void)initializeAllRankings: 
@end
