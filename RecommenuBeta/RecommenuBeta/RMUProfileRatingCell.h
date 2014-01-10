//
//  RMUProfileRatingCell.h
//  RecommenuBeta
//
//  Created by Blake Ellingham on 1/9/14.
//  Copyright (c) 2014 Blake Ellingham. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RMUProfileRatingCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *likeDislikeImage;
@property (weak, nonatomic) IBOutlet UILabel *entreeLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;

@end
