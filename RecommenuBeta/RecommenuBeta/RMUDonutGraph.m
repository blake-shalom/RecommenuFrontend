//
//  RMUDonutGraph.m
//  RecommenuAlpha
//
//  Created by Blake Ellingham on 10/31/13.
//  Copyright (c) 2013 Blake Ellingham. All rights reserved.
//

#import "RMUDonutGraph.h"

#define WIDTH_OF_GRAPH 3.0f

#pragma mark - C - drawing functions

// Creates a hoop from the center of the view
CGMutablePathRef createHoopPathFromCenterOfView(CGRect view, CGFloat outerRadius, CGFloat innerRadius, CGFloat theta, bool clockwise)
{
    
    CGPoint arcCenter = CGPointMake((view.origin.x + view.size.width / 2), (view.origin.y + view.size.height / 2));
    CGFloat startAngle = 0;
    
    CGMutablePathRef path = CGPathCreateMutable();
    
    CGPathAddArc(path, NULL, arcCenter.x, arcCenter.y, outerRadius, startAngle, theta, clockwise);
    CGPathAddArc(path, NULL, arcCenter.x, arcCenter.y, innerRadius, theta, startAngle, !clockwise);
        
    return path;
}

@implementation RMUDonutGraph


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)displayLikes:(NSInteger)likes dislikes:(NSInteger) dislikes
{
    self.likes = likes;
    self.dislikes = dislikes;
    [self setNeedsDisplay];
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
//    CGPoint arcCenter = CGPointMake((rect.origin.x + rect.size.width / 2), (rect.origin.y + rect.size.height / 2));
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGFloat likesToRadians = 2 * M_PI * ( self.likes / (self.likes + self.dislikes));
    if (likesToRadians == 0)
        likesToRadians = 2 * M_PI;
    float extraSpace = 0.0;
    if (self.likes != 0) {
        CGContextSaveGState(context);
        CGMutablePathRef likePath = createHoopPathFromCenterOfView(rect, rect.size.width/2.0f, rect.size.width/2.0f - WIDTH_OF_GRAPH, - likesToRadians, 1);
        CGContextAddPath(context, likePath);
        CGContextSetFillColorWithColor(context, [UIColor RMUGoodGreenColor].CGColor);
        CGContextFillPath(context);
        CGContextRestoreGState(context);
        CFRelease(likePath);
        extraSpace = 0.05;
    }
    
    if (self.dislikes != 0) {
        CGContextSaveGState(context);
        CGMutablePathRef dislikePath = createHoopPathFromCenterOfView(rect, rect.size.width/2.0f, rect.size.width/2.0f - WIDTH_OF_GRAPH, -likesToRadians - extraSpace, 0);
        CGContextAddPath(context, dislikePath);
        CGContextSetFillColorWithColor(context, [UIColor RMUBadRedColor].CGColor);
        CGContextFillPath(context);
        CGContextRestoreGState(context);
        CFRelease(dislikePath);
        // Create blank path
        CGContextSaveGState(context);
        CGMutablePathRef blankPath = createHoopPathFromCenterOfView(rect, rect.size.width/2.0f, rect.size.width/2.0f - 3.0f, extraSpace , 0);
        CGContextAddPath(context, blankPath);
        CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
        CGContextFillPath(context);
        CGContextRestoreGState(context);
        CFRelease(blankPath);
            
    }
    else if (self.likes == 0){
        CGContextSaveGState(context);
        CGMutablePathRef dislikePath = createHoopPathFromCenterOfView(rect, rect.size.width/2.0f, rect.size.width/2.0f - WIDTH_OF_GRAPH, M_PI * 2, 0);
        CGContextAddPath(context, dislikePath);
        CGContextSetFillColorWithColor(context, [UIColor RMUDividingGrayColor].CGColor);
        CGContextFillPath(context);
        CGContextRestoreGState(context);
        CFRelease(dislikePath);
    }
}


@end
