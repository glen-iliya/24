//
//  TaskBarViewController.m
//  24meNewidea
//
//  Created by iliya on 1/5/14.
//  Copyright (c) 2014 iliya. All rights reserved.
//

#import "TaskBarViewController.h"
#import "TaskBarTableViewCell.h"

@interface TaskBarViewController ()

@end

@implementation TaskBarViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
       
        // Custom initialization
    }
    return self;
}


- (id)initWithStyle:(UITableViewStyle)style andTask:(NSString *)task
{
    self = [super initWithStyle:style];
    if (self) {
        taskName = task;
        // Custom initialization
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    isBarOpen = false;  // is the fullbar open (2nd cell is 500 points)
    firstBarLoaded = false; // for animation of the small bar. (open down from tableview with one cell)
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

-(void) tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([indexPath row] == 0){
        
        if (!firstBarLoaded){   // animation of the first bar
            firstBarLoaded = true;
            [self.tableView beginUpdates];
            NSIndexPath* changeArrowRow = [NSIndexPath indexPathForRow:1 inSection:0];
            NSArray* rowsToReload = [NSArray arrayWithObjects:changeArrowRow, nil];
            [self.tableView insertRowsAtIndexPaths:rowsToReload withRowAnimation:UITableViewRowAnimationTop];
            [self.tableView endUpdates];
        }
     
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row ==1 && !isBarOpen){
        return 65;
    }
    if (indexPath.row==1 && isBarOpen){
        return 473;
    }
    return 44;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (firstBarLoaded)
        return 2;
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0){
        static NSString *CellIdentifier = @"Cell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        cell.textLabel.text = taskName;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    else{
        TaskBarTableViewCell *cell = (TaskBarTableViewCell *) [tableView dequeueReusableCellWithIdentifier:@"TaskBarTableViewCell"];
        if (!cell) {
            NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"TaskBarTableViewCell" owner:self options:nil];
            cell = [topLevelObjects objectAtIndex:0];
            cell.delegate = self;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }

    }
    
    return Nil;
}

#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0 && !isBarOpen){
        [self.delegate closeBarTapped];
    }
    if (indexPath.row==0 && isBarOpen)
        [self doneTapped];
}

#pragma mark - delegate methods

-(void) barTapped{
    isBarOpen = true;
    [self.delegate openFullBarTapped];// tasktableviewcontroller delegate
    
}
-(void) doneTapped{
    isBarOpen = false;
    [self.delegate closeFullBarTapped];// tasktableviewcontroller delegate
    

    
}

@end
