//
//  RMUFoodieFriendPopup.m
//  RecommenuBeta
//
//  Created by Blake Ellingham on 2/13/14.
//  Copyright (c) 2014 Blake Ellingham. All rights reserved.
//

#import "RMUFoodieFriendPopup.h"

@interface RMUFoodieFriendPopup()

@property NSArray *likeArray;
@property NSArray *dislikeArray;

@end

@implementation RMUFoodieFriendPopup

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)populateWithFriendsLikeArray:(NSArray*)likeArray withFriendsDislikeArray: (NSArray*)dislikeArray
{
    
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section)
        return self.dislikeArray.count;
    else
        return self.dislikeArray.count;
}

-(UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [[UITableViewCell alloc]init];
}

-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section)
        return @"DISLIKE";
    else
        return @"LIKE";
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
