//
//  RMUAnimationClass.m
//  RecommenuBeta
//
//  Created by Blake Ellingham on 12/8/13.
//  Copyright (c) 2013 Blake Ellingham. All rights reserved.
//

#import "RMUAnimationClass.h"

@implementation RMUAnimationClass
/*
 *  Animates a flyin with a given view
 *  params: view - the view being animated, duration - duration of the animation, delay - duration of the delay, direction - direction the view is coming from
 *  withCompletion - after code is executed do this next, withBounce - does the animation do a bounce or not
 */

+ (void)animateFlyInView:(UIView *) view withDuration:(CGFloat) duration
               withDelay:(CGFloat)delay fromDirection:(buttonAnimationDirection)direction
          withCompletion:(void (^)(BOOL))completion withBounce:(BOOL)doesBounce


{
    CGRect oldFrame = view.frame;
    CGRect bounceFrame = oldFrame;
    [view setUserInteractionEnabled:NO];
    
    // On each direction change the frame from which it is bouncing
    switch (direction) {
            
            // Frame Bounces from the bottom
        case buttonAnimationDirectionBottom:
            view.frame = CGRectMake(view.frame.origin.x, HEIGHT_OF_IPHONE_SCREEN ,
                                    view.frame.size.width, view.frame.size.height);
            if (doesBounce)
                bounceFrame.origin.y -= SIZE_OF_BOUNCE;
            break;
            
            // Frame Bounces from the Top
        case buttonAnimationDirectionTop:
            view.frame = CGRectMake(view.frame.origin.x,  - view.frame.size.height,
                                    view.frame.size.width, view.frame.size.height);
            if (doesBounce)
                bounceFrame.origin.y += SIZE_OF_BOUNCE;
            break;
        case buttonAnimationDirectionRight:
            view.frame = CGRectMake(WIDTH_OF_IPHONE_SCREEN, view.frame.origin.y,
                                    view.frame.size.width, view.frame.size.height);
            if (doesBounce)
                bounceFrame.origin.x -= SIZE_OF_BOUNCE;
            break;
        default:
            break;
    }
    
    // First the over animation
    [UIView animateWithDuration:duration
                          delay:delay
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:^
     {
         [view setFrame:bounceFrame];
     }
                     completion: ^(BOOL finished)
     {
         [view setUserInteractionEnabled:YES];
         if (doesBounce){
             
             // If there is a bounce then animate again back to the position
             [UIView animateWithDuration:0.1f
                              animations:^
              {
                  [view setFrame:oldFrame];
              }
                              completion:completion];
         }
         
         // else just do completion
         else{
             if (completion)
                 completion(finished);
         }
     }];
    
}

@end
