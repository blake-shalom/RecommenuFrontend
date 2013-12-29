//
//  RMULocateScreen.h
//  RecommenuBeta
//
//  Created by Blake Ellingham on 11/29/13.
//  Copyright (c) 2013 Blake Ellingham. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MapBox/MapBox.h"
#import "RMUButton.h"
#import "RMUAnimationClass.h"
#import "AFNetworking.h"
#import "RMURestaurant.h"
#import "RMUMenuScreen.h"
#import "RMURevealViewController.h"

@interface RMULocateScreen : UIViewController
<CLLocationManagerDelegate, UIAlertViewDelegate>

@end
