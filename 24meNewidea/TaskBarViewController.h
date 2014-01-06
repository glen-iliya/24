//
//  TaskBarViewController.h
//  24meNewidea
//
//  Created by iliya on 1/5/14.
//  Copyright (c) 2014 iliya. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TaskBarTableViewCell.h"

@protocol TaskBarViewControllerDelegate <NSObject>

-(void) closeBarTapped;
-(void) openFullBarTapped;
-(void) closeFullBarTapped;

@end


@interface TaskBarViewController : UITableViewController<TaskBarTableViewCellDelegate>{
    NSString* taskName;
    Boolean isBarOpen;
    Boolean firstBarLoaded;
}

@property (nonatomic, weak) id <TaskBarViewControllerDelegate> delegate;
- (id)initWithStyle:(UITableViewStyle)style andTask:(NSString *)task;


@end
