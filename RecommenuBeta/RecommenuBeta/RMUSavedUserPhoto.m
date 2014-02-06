//
//  RMUSavedUserPhoto.m
//  RecommenuBeta
//
//  Created by Blake Ellingham on 2/1/14.
//  Copyright (c) 2014 Blake Ellingham. All rights reserved.
//

#import "RMUSavedUserPhoto.h"

#warning TODO update the photo semi-regularly

@implementation RMUSavedUserPhoto

@dynamic userPhoto;

- (void)storeUserImageAsPNG:(UIImage*)userImage
{
    self.userPhoto = UIImagePNGRepresentation(userImage);
}

@end
