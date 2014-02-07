//
//  RMULocationCell.m
//  RecommenuBeta
//
//  Created by Blake Ellingham on 1/28/14.
//  Copyright (c) 2014 Blake Ellingham. All rights reserved.
//

#import "RMULocationCell.h"

@implementation RMULocationCell

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
    [super layoutSubviews];
    [self.locationSwitch setOnTintColor:[UIColor RMULogoBlueColor]];
    if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusDenied)
        [self.locationSwitch setOn:NO];
    else
        [self.locationSwitch setOn:YES];
    
}
- (IBAction)locationPreferenceChanged:(UISwitch *)sender
{
    if (sender.on) {
        NSLog(@"SWITCH IS ON");
    }
    else {
        NSLog(@"SWITCH IS OFF");
    }
}
@end
