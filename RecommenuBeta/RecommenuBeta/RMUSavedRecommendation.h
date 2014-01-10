//
//  RMUSavedRecommendation.h
//  RecommenuBeta
//
//  Created by Blake Ellingham on 1/2/14.
//  Copyright (c) 2014 Blake Ellingham. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface RMUSavedRecommendation : NSManagedObject

@property (nonatomic, retain) NSString * entreeFoursquareID;
@property (nonatomic, retain) NSString * restFoursquareID;
@property (nonatomic, retain) NSDate * timeRated;
@property (nonatomic, retain) NSNumber * isRecommendPositive;
@property (nonatomic, retain) NSManagedObject *userForRecommedation;
@property (nonatomic, retain) NSString * entreeName;
@property (nonatomic, retain) NSString * restaurantName;

@end
