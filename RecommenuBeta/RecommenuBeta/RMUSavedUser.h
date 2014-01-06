//
//  RMUSavedUser.h
//  RecommenuBeta
//
//  Created by Blake Ellingham on 1/2/14.
//  Copyright (c) 2014 Blake Ellingham. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class RMUSavedRecommendation;

@interface RMUSavedUser : NSManagedObject

@property (nonatomic, retain) NSNumber * hasLoggedIn;
@property (nonatomic, retain) NSString * userURI;
@property (nonatomic, retain) NSString * firstName;
@property (nonatomic, retain) NSString * lastName;
@property (nonatomic, retain) NSString * facebookID;
@property (nonatomic, retain) NSString * foodieID;
@property (nonatomic, retain) NSString * email;
@property (nonatomic, retain) NSString * city;
@property (nonatomic, retain) NSDate * dateLogged;
@property (nonatomic, retain) NSSet *ratingsForUser;
@end

@interface RMUSavedUser (CoreDataGeneratedAccessors)

- (void)addRatingsForUserObject:(RMUSavedRecommendation *)value;
- (void)removeRatingsForUserObject:(RMUSavedRecommendation *)value;
- (void)addRatingsForUser:(NSSet *)values;
- (void)removeRatingsForUser:(NSSet *)values;

@end
