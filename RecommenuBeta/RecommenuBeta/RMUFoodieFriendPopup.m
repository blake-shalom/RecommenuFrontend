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
@property popupState state;

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

#pragma mark - populate methods

/*
 *  adds the friend identification into the popup that allows for a friend to be viewed sets state to friend state
 */

- (void)populateWithFriendsLikeArray:(NSArray*)likeArray withFriendsDislikeArray: (NSArray*)dislikeArray withNameofEntree:(NSString*)entreeName
{
    NSInteger likes = likeArray.count;
    NSInteger dislikes = dislikeArray.count;
    [self.likeLabel setText:[NSString stringWithFormat:(@"%i Likes"), likes]];
    [self.dislikeLabel setText:[NSString stringWithFormat:(@"%i Dislikes"), dislikes]];
    [self.headLabel setText:[NSString stringWithFormat:(@"People who like %@"), entreeName]];
    [self.donutGraph displayLikes:likes dislikes:dislikes];
    self.state = popupStateFriendState;
    self.likeArray = [NSArray arrayWithArray:likeArray];
    self.dislikeArray = [NSArray arrayWithArray:dislikeArray];
    [self.friendfoodTable reloadData];
}

/*
 *  Populates with recommendation from the crowd and sets the subviews
 */

- (void)populateWithCrowdLikes:(NSInteger) likes withCrowdDislikes:(NSInteger)dislikes withNameOfEntree:(NSString*)entreeName
{
    [self.likeLabel setText:[NSString stringWithFormat:(@"%i Likes"), likes]];
    [self.dislikeLabel setText:[NSString stringWithFormat:(@"%i Dislikes"), dislikes]];
    [self.headLabel setText:[NSString stringWithFormat:(@"People who like %@"), entreeName]];
    [self.donutGraph displayLikes:likes dislikes:dislikes];
    self.state = popupStateCrowdState;
}

#pragma mark - UITable View methods

/*
 *  Number of rows determined from the underlying arrays that keep track of id's
 */

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section)
        return self.dislikeArray.count;
    else
        return self.likeArray.count;
}

/*
 *  If crowd, then no table. If friend then present their fb photo. IF foodie link to their special profile
 */

-(UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"friendCell";
    RMUProfileFriendCell *friendCell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    NSArray *friendArray;
    if (indexPath.section)
        friendArray = self.dislikeArray;
    else
        friendArray = self.likeArray;

    switch (self.state) {
        // Crowd popup, nothing to do
        case popupStateCrowdState:
            break;
        // Friend popup, load profile view
        case popupStateFriendState: {
            FBProfilePictureView *profileView = [[FBProfilePictureView alloc]initWithProfileID:friendArray[indexPath.row] pictureCropping:FBProfilePictureCroppingSquare];
            NSLog(@"friend: %@", friendArray[indexPath.row]);
            [friendCell.numRatingsLabel setText:@""];
            [friendCell.friendnNameLabel setText:@""];
            [profileView setFrame:friendCell.friendImage.frame];
            [friendCell addSubview:profileView];
            break;
        }
        // Foodie popup, eiuther load profile or standard foodie pic
        case popupStateFoodieState: {
            //TODO check for facebookID
            if (NO) {
                FBProfilePictureView *profileView = [[FBProfilePictureView alloc]initWithProfileID:friendArray[indexPath.row] pictureCropping:FBProfilePictureCroppingSquare];
                [profileView setFrame:friendCell.friendImage.frame];
                [friendCell addSubview:profileView];
            }
            else
                [friendCell.friendImage setImage:[UIImage imageNamed:@"foodie_certified"]];
            break;
        }
        default:
            break;
    }
    return friendCell;
}

/*
 *  Always just like and dislike sections
 */

-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

/*
 *  Titles either dislike or like
 */

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section)
        return @"DISLIKE";
    else
        return @"LIKE";
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 67.0;
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
