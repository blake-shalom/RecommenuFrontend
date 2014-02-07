//
//  RMUDonutGraph.h
//  RecommenuAlpha
//
//  Created by Blake Ellingham on 10/31/13.
//  Copyright (c) 2013 Blake Ellingham. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "UIColor+RMUColors.h"

@interface RMUDonutGraph : UIView

// property to set likes and dislikes
@property CGFloat likes;
@property CGFloat dislikes;

// Displays likes and dislikes 
- (void)displayLikes:(NSInteger)likes dislikes:(NSInteger) dislikes;

@end
