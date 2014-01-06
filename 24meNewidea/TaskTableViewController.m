//
//  TaskTableViewController.m
//  24metest
//
//  Created by iliya on 1/4/14.
//  Copyright (c) 2014 iliya. All rights reserved.
//

#import "TaskTableViewController.h"
#import "TaskBarTableViewCell.h"



@interface TaskTableViewController ()

@end

@implementation TaskTableViewController
@synthesize greyView, taskBarInitialX, taskBarInitialY;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    tasks = [[NSArray alloc]initWithObjects:@"Call dad after work", @"Call dad after work", @"Groceries list - from Liat", @"Call Dad after work", @"Groceries list - from Liat", @"Pick up the laundry", @"Birthday - Shawn Binder", @"Birthday - Shawn Binder",@"Birthday - Shawn Binder", @"AT&T bill - $52.32",@"AT&T bill - $52.32",@"AT&T bill - $52.32" , nil];
    greyView.alpha = 0.0;
    greyViewTapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(closeGreyView)];
    [greyView addGestureRecognizer:greyViewTapGesture];
    barIsShown = false; // bar view is shown
    taskBarInitialX = 0;
    taskBarInitialY = 0;

}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row==selectedRow.row+2 && barIsShown)
        return 21; // half bar
    return 44;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (barIsShown){
        return [tasks count]+2;
    }
    else{
      return [tasks count] ;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    if (barIsShown ){ // miss 2.5 cells with no data
        if (indexPath.row < selectedRow.row){
                cell.textLabel.text = [tasks objectAtIndex:indexPath.row];
        }
        else if (indexPath.row == selectedRow.row || indexPath.row == selectedRow.row+1 || indexPath.row == selectedRow.row+2){
             cell.textLabel.text = @"";
            }
        else
            cell.textLabel.text = [tasks objectAtIndex:indexPath.row-2];
    }
    else{
        cell.textLabel.text = [tasks objectAtIndex:indexPath.row];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
    


#pragma mark - Table view delegate


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
     barIsShown = YES;
     selectedRow = indexPath;
    
    [UIView beginAnimations:nil context:nil]; // add the grey view
    [UIView setAnimationDuration:0.4f];
    [UIView setAnimationCurve:UIViewAnimationCurveLinear];
    [UIView setAnimationDelegate:self];
    [greyView setHidden:false];
    greyView.alpha = 0.5f;
    [self.view addSubview:greyView];
    [UIView commitAnimations];
    
    NSString* tempTask =  [tasks objectAtIndex:indexPath.row];  // add the task view
    taskBarViewController = [[TaskBarViewController alloc]initWithStyle:UITableViewStylePlain andTask:tempTask];
    CGRect rectOfCellInTableView = [tableView rectForRowAtIndexPath:indexPath];
    [taskBarViewController.view setFrame:CGRectMake(rectOfCellInTableView.origin.x, rectOfCellInTableView.origin.y, 320, 44+65)];
    taskBarViewController.delegate=self;
    [self.view addSubview:taskBarViewController.view];
    
    if (barIsShown){  // add 2.5 empty cells
        [tableView beginUpdates];
        NSIndexPath* changeRow = [NSIndexPath indexPathForRow:selectedRow.row+1 inSection:0];
        NSArray* rowsToReload = [NSArray arrayWithObjects:changeRow, nil];
        [self.tableView insertRowsAtIndexPaths:rowsToReload withRowAnimation:UITableViewRowAnimationBottom];
        NSIndexPath* changeRow1 = [NSIndexPath indexPathForRow:selectedRow.row+2 inSection:0];
        NSArray* rowsToReload1 = [NSArray arrayWithObjects:changeRow1, nil];
        [self.tableView insertRowsAtIndexPaths:rowsToReload1 withRowAnimation:UITableViewRowAnimationNone];
        [tableView endUpdates];
    }


}

-(void)closeGreyView{
    
    [UIView animateWithDuration:0.2f
                          delay:0.0f
                        options:(UIViewAnimationCurveLinear | UIViewAnimationOptionAllowUserInteraction)
                     animations:^{
                         taskBarViewController.view.frame = CGRectMake(taskBarViewController.view.frame.origin.x, taskBarViewController.view.frame.origin.y, 320, 44);  // make task view smalles
                     }
                     completion:^(BOOL finished) {
                         [UIView animateWithDuration:0.8f
                                               delay:1.5f
                                             options:(UIViewAnimationCurveLinear | UIViewAnimationOptionAllowAnimatedContent)
                                          animations:^{
                                              greyView.alpha = 0.0f;
                                              [greyView setHidden:true];
                                              [taskBarViewController.view removeFromSuperview];  // remove grey & tass view
                                          }
                                          completion:^(BOOL finished) {

                                          }];
                     }];
    barIsShown = false;
    
    [self.tableView beginUpdates];  // remove 2.5 cells
    NSIndexPath* changeRow = [NSIndexPath indexPathForRow:selectedRow.row+1 inSection:0];
    NSArray* rowsToReload = [NSArray arrayWithObjects:changeRow, nil];
    [self.tableView deleteRowsAtIndexPaths:rowsToReload withRowAnimation:UITableViewRowAnimationBottom];
    NSIndexPath* changeRow1 = [NSIndexPath indexPathForRow:selectedRow.row+2 inSection:0];
    NSArray* rowsToReload1 = [NSArray arrayWithObjects:changeRow1, nil];
    [self.tableView deleteRowsAtIndexPaths:rowsToReload1 withRowAnimation:UITableViewRowAnimationNone];
    [self.tableView endUpdates];
}

#pragma mark - task  bar delegates

-(void) closeBarTapped{
    [self closeGreyView];
}


-(void) openFullBarTapped{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.4f];
    taskBarInitialX = taskBarViewController.view.frame.origin.x;
    taskBarInitialY = taskBarViewController.view.frame.origin.y;
    
    [taskBarViewController.view setFrame:CGRectMake(0, 0, 320, 518)]; // make it full screen
    [taskBarViewController.tableView reloadData];
    [self.tableView scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:YES]; // scroll the table view to top
    [UIView commitAnimations];
}

-(void) closeFullBarTapped{
    
    [UIView animateWithDuration:0.4f
                          delay:0.0f
                        options:(UIViewAnimationCurveLinear | UIViewAnimationOptionAllowUserInteraction)
                     animations:^{
                         [taskBarViewController.view setFrame:CGRectMake(taskBarInitialX, taskBarInitialY, 320, 65+44)];
                         [taskBarViewController.tableView reloadData];

                     }
                     completion:^(BOOL finished) {
                          [self closeGreyView];
                     }];

}

@end
