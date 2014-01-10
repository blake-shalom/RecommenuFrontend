//
//  RMUProfileRatingCell.m
//  RecommenuBeta
//
//  Created by Blake Ellingham on 1/9/14.
//  Copyright (c) 2014 Blake Ellingham. All rights reserved.
//

#import "RMUProfileRatingCell.h"



@implementation RMUProfileRatingCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)layoutSubviews
{
    [self.entreeLabel setTextColor:[UIColor RMUTitleColor]];
    [self.descriptionLabel setTextColor:[UIColor RMUDescriptionGrayColor]];
    [self.dateLabel setTextColor:[UIColor RMUDescriptionGrayColor]];
}

@end
