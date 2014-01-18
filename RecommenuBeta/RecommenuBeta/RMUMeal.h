//
//  RMUMeal.h
//  RecommenuBeta
//
//  Created by Blake Ellingham on 12/10/13.
//  Copyright (c) 2013 Blake Ellingham. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RMUMeal : NSObject

@property NSString *mealID;
@property NSString *mealName;
@property NSString *mealDescription;
@property NSString *mealPrice;
@property NSNumber *crowdLikes;
@property NSNumber *crowdDislikes;
@property NSNumber *friendLikes;
@property NSNumber *expertLikes;
@property NSMutableArray *facebookLikeID;
@property NSMutableArray *facebookDislikeID;
@property NSMutableArray *foodieLikeID;
@property NSMutableArray *foodieDislikeID;
@property BOOL isLiked;
@property BOOL isDisliked;

- (id)initWithDictionary:(NSDictionary*) mealDictionary;
- (void)loadLikeDislikeInformationWithDictionary: (NSDictionary *)rateDictionary;

@end
