//
//  RMUMeal.m
//  RecommenuBeta
//
//  Created by Blake Ellingham on 12/10/13.
//  Copyright (c) 2013 Blake Ellingham. All rights reserved.
//

#import "RMUMeal.h"

@implementation RMUMeal

/*
 *  Called from the Course menu, assign properties from JSON dictionary
 */

- (id)initWithDictionary:(NSDictionary*) mealDictionary
{
    self = [super init];
    if (self) {
        self.mealName = [mealDictionary objectForKey:@"name"];
        self.mealDescription = [mealDictionary objectForKey:@"description"];
        self.mealID = [mealDictionary objectForKey:@"entryId"];
        self.mealPrice = [mealDictionary objectForKey:@"price"];
        self.isLiked = NO;
        self.isDisliked = NO;
        self.expertLikes = [NSNumber numberWithInt:0];
        self.crowdLikes = [NSNumber numberWithInt:0];
        self.friendLikes = [NSNumber numberWithInt:0];
    }
    return self;
}

/*
 *  Loads correct number of likes dislikes etc
 */

- (void)loadLikeDislikeInformationWithDictionary: (NSDictionary *)rateDictionary
{
    self.crowdLikes = [rateDictionary objectForKey:@"likes"];
    self.crowdDislikes = [rateDictionary objectForKey:@"dislikes"];
    
    // Handle foodie objects
    NSDictionary *foodieDict = [rateDictionary objectForKey:@"foodie"];
    self.expertLikes = [foodieDict objectForKey:@"flikes"];
    self.expertDislikes = [foodieDict objectForKey:@"fdislikes"];
    self.foodieLikeID = [foodieDict objectForKey:@"like_ids"];
    self.foodieDislikeID = [foodieDict objectForKey:@"dislike_ids"];
    
    NSDictionary *friendDict = [rateDictionary objectForKey:@"facebook"];
    self.friendLikes = [friendDict objectForKey:@"likes"];
    self.friendDislikes = [friendDict objectForKey:@"dislikes"];
    self.facebookLikeID = [friendDict objectForKey:@"like_ids"];
    self.facebookDislikeID = [friendDict objectForKey:@"dislike_ids"];
    
}
@end
