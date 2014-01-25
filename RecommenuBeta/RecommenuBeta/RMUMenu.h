//
//  RMUMenu.h
//  RecommenuBeta
//
//  Created by Blake Ellingham on 12/10/13.
//  Copyright (c) 2013 Blake Ellingham. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

@interface RMUMenu : NSObject

@property NSString *menuName;
@property NSMutableArray *courses;
@property NSString *menuFoursquareID;

- (id)initWithDictionary:(NSDictionary*) menu;

@end
