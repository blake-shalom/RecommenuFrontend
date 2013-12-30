//
//  RMUAnimationClass.h
//  RecommenuBeta
//
//  Created by Blake Ellingham on 12/8/13.
//  Copyright (c) 2013 Blake Ellingham. All rights reserved.
//
#define SIZE_OF_BOUNCE 3.0f
#define HEIGHT_OF_IPHONE_SCREEN 568.0f
#define WIDTH_OF_IPHONE_SCREEN 320.0f

#import <Foundation/Foundation.h>
// Enum that states direction of animation
typedef enum  {
    buttonAnimationDirectionTop,
    buttonAnimationDirectionBottom,
    buttonAnimationDirectionRight
} buttonAnimationDirection;

@interface RMUAnimationClass : NSObject

+ (void)animateFlyInView:(UIView *) view withDuration:(CGFloat) duration
               withDelay:(CGFloat)delay fromDirection:(buttonAnimationDirection)direction
          withCompletion:(void (^)(BOOL))completion withBounce:(BOOL)doesBounce;


@end
