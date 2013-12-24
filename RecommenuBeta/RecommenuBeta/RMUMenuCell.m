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

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)layoutSubviews
{
    [self.mealLabel setTextColor:[UIColor RMUTitleColor]];
    [self.descriptionLabel setTextColor:[UIColor RMUDescriptionGrayColor]];
    [self.priceLabel setTextColor:[UIColor RMUDescriptionGrayColor]];
}

@end
