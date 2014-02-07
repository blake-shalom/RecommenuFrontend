//
//  RMUMenuCell.m
//  RecommenuBeta
//
//  Created by Blake Ellingham on 12/21/13.
//  Copyright (c) 2013 Blake Ellingham. All rights reserved.
//

#import "RMUMenuCell.h"

@implementation RMUMenuCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

/*
 *  Laysout the correct configurations of the subviews
 */

- (void)layoutSubviews
{
    [self.mealLabel setTextColor:[UIColor RMUTitleColor]];
    [self.descriptionLabel setTextColor:[UIColor RMUDescriptionGrayColor]];
    [self.priceLabel setTextColor:[UIColor RMUDescriptionGrayColor]];
    [self.crowdLikeLabel setTextColor:[UIColor RMULikeBlueColor]];
    [self.friendLikeLabel setTextColor:[UIColor RMULikeBlueColor]];
    [self.expertLikeLabel setTextColor:[UIColor RMULikeBlueColor]];
}

@end
