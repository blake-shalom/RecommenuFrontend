//
//  RMUCourse.h
//  RecommenuBeta
//
//  Created by Blake Ellingham on 12/10/13.
//  Copyright (c) 2013 Blake Ellingham. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RMUMeal.h"

@interface RMUCourse : NSObject

@property NSString *courseName;
@property NSMutableArray *meals;

- (id)initWithDictionary:(NSDictionary*) course;

@end
