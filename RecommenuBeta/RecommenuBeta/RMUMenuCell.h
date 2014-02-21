//
//  RMUMenuCell.h
//  RecommenuBeta
//
//  Created by Blake Ellingham on 12/21/13.
//  Copyright (c) 2013 Blake Ellingham. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RMUDonutGraph.h"

@interface RMUMenuCell : UITableViewCell

// Allows manipulation of the interface elements
@property (weak, nonatomic) IBOutlet UILabel *mealLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *friendLikeLabel;
@property (weak, nonatomic) IBOutlet UILabel *expertLikeLabel;
@property (weak, nonatomic) IBOutlet UILabel *crowdLikeLabel;
@property (weak, nonatomic) IBOutlet RMUDonutGraph *donutGraph;
@property (weak, nonatomic) IBOutlet UIView *likeView;
@property (weak, nonatomic) IBOutlet UIView *descView;
@property (weak, nonatomic) IBOutlet UIButton *friendsButton;
@property (weak, nonatomic) IBOutlet UIButton *foodieButton;
@property (weak, nonatomic) IBOutlet UIButton *crowdButton;

@end
