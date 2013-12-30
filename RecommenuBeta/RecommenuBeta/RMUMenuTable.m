//
//  RMUMenuTable.m
//  RecommenuBeta
//
//  Created by Blake Ellingham on 12/24/13.
//  Copyright (c) 2013 Blake Ellingham. All rights reserved.
//

#import "RMUMenuTable.h"

@implementation RMUMenuTable

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
        [self setBackgroundColor:[UIColor clearColor]];
        
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
