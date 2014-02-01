//
//  RMUSavedUserPhoto.h
//  RecommenuBeta
//
//  Created by Blake Ellingham on 2/1/14.
//  Copyright (c) 2014 Blake Ellingham. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface RMUSavedUserPhoto : NSManagedObject

@property (nonatomic, retain) NSData * userPhoto;

@end
