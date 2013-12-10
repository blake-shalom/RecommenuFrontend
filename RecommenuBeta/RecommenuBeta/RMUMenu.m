//
//  RMUMenu.m
//  RecommenuBeta
//
//  Created by Blake Ellingham on 12/10/13.
//  Copyright (c) 2013 Blake Ellingham. All rights reserved.
//

#import "RMUMenu.h"

@implementation RMUMenu

- (id)initWithFoursquareID:(NSNumber*)foursquareID
{
    self = [[RMUMenu alloc]init];
    if (self) {
        self.courses = [[NSMutableArray alloc]init];
        
    }
    return self;
}

@end
