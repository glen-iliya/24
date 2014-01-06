//
//  TaskBarTableViewCell.m
//  24metest
//
//  Created by iliya on 1/5/14.
//  Copyright (c) 2014 iliya. All rights reserved.
//

#import "TaskBarTableViewCell.h"

@implementation TaskBarTableViewCell
@synthesize delegate;

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

- (IBAction)barTapped:(id)sender {
    [self.delegate barTapped];
}
- (IBAction)doneTapped:(id)sender {
    [self.delegate doneTapped];
}
@end
