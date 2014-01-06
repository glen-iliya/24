//
//  TaskBarTableViewCell.h
//  24metest
//
//  Created by iliya on 1/5/14.
//  Copyright (c) 2014 iliya. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol TaskBarTableViewCellDelegate <NSObject>

-(void) barTapped;
-(void) doneTapped;
@end


@interface TaskBarTableViewCell : UITableViewCell
- (IBAction)barTapped:(id)sender;
@property (nonatomic, weak) id <TaskBarTableViewCellDelegate> delegate;
- (IBAction)doneTapped:(id)sender;


@end
