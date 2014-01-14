//
//  RMUDonutGraph.h
//  RecommenuAlpha
//
//  Created by Blake Ellingham on 10/31/13.
//  Copyright (c) 2013 Blake Ellingham. All rights reserved.
//
#warning TODO start here and go down through files, adding comments


#import <UIKit/UIKit.h>
#import "UIColor+RMUColors.h"

@interface RMUDonutGraph : UIView
@property CGFloat likes;
@property CGFloat dislikes;

- (void)displayLikes:(NSInteger)likes dislikes:(NSInteger) dislikes;

@end
