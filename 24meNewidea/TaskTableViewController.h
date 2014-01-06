//
//  TaskTableViewController.h
//  24metest
//
//  Created by iliya on 1/4/14.
//  Copyright (c) 2014 iliya. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TaskBarTableViewCell.h"
#import "TaskBarViewController.h"

@interface TaskTableViewController : UITableViewController<TaskBarViewControllerDelegate>{
    NSArray *tasks;
    UITapGestureRecognizer *greyViewTapGesture;
    Boolean barIsShown;
    NSIndexPath* selectedRow;  //tapped row
    TaskBarViewController* taskBarViewController;
   }
@property (strong, nonatomic) IBOutlet UIView *greyView;
@property (nonatomic) int taskBarInitialX; // for returning the taskbar view to right place after done pressed
@property (nonatomic) int taskBarInitialY;


@end
