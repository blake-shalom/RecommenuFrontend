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
        self.contentView.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
        self.selectionStyle = UITableViewCellSelectionStyleNone;

    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.contentView.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
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
    [super layoutSubviews];
    
    [self.mealLabel setTextColor:[UIColor RMUTitleColor]];
    [self.descriptionLabel setTextColor:[UIColor RMUDescriptionGrayColor]];
    [self.priceLabel setTextColor:[UIColor RMUDescriptionGrayColor]];
    [self.crowdLikeLabel setTextColor:[UIColor RMULikeBlueColor]];
    [self.friendLikeLabel setTextColor:[UIColor RMULikeBlueColor]];
    [self.expertLikeLabel setTextColor:[UIColor RMULikeBlueColor]];
    CGRect oldDescFrame = self.descriptionLabel.frame;
    NSString *descText = self.descriptionLabel.text;
    CGSize maxSize = CGSizeMake(224.0f, CGFLOAT_MAX);
    UIFont *currentFont = [UIFont fontWithName:@"Avenir-Roman" size:10.0f];
    CGRect textRect = [descText boundingRectWithSize:maxSize
                                             options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading)
                                          attributes:@{NSFontAttributeName:currentFont}
                                             context:nil];
    oldDescFrame.size = textRect.size;
    [self.descriptionLabel setFrame:oldDescFrame];
    [self.descriptionLabel updateConstraints];
//    if ([self.descriptionLabel.text isEqualToString:@"Grilled banana with hot chocolate, caramel & almonds atop ice cream"])
//        NSLog(@"created frame size- H: %f W: %f. Actual size- H: %f, %f", oldDescFrame.size.height, oldDescFrame.size.width, self.descriptionLabel.frame.size.height, self.descriptionLabel.frame.size.width);

}

@end
