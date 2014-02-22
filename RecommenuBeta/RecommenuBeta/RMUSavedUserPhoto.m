//
//  RMUSavedUserPhoto.m
//  RecommenuBeta
//
//  Created by Blake Ellingham on 2/1/14.
//  Copyright (c) 2014 Blake Ellingham. All rights reserved.
//

#import "RMUSavedUserPhoto.h"


@implementation RMUSavedUserPhoto

@dynamic userPhoto;
@dynamic userForSavedPhoto;

- (void)storeUserImageAsPNG:(UIImage*)userImage
{
    self.userPhoto = UIImagePNGRepresentation(userImage);
}

-(UIImage*)imageForPhotoData
{
    return [UIImage imageWithData:self.userPhoto];
}

@end
