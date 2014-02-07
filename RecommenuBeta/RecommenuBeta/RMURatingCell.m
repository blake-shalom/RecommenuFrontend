//
//  RMURatingCell.m
//  RecommenuBeta
//
//  Created by Blake Ellingham on 12/29/13.
//  Copyright (c) 2013 Blake Ellingham. All rights reserved.
//

#import "RMURatingCell.h"

@implementation RMURatingCell

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

/*
 *  Lays out the color of different interface elements
 */

- (void)layoutSubviews
{
    [self.mealLabel setTextColor:[UIColor RMUTitleColor]];
    [self.descriptionLabel setTextColor:[UIColor RMUDescriptionGrayColor]];
    [self.priceLabel setTextColor:[UIColor RMUDescriptionGrayColor]];
}

@end
