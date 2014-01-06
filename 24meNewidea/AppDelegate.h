//
//  AppDelegate.h
//  24meNewidea
//
//  Created by iliya on 1/5/14.
//  Copyright (c) 2014 iliya. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TaskTableViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>{
    TaskTableViewController* taskTableViewController;
}
@property (strong, nonatomic) UIWindow *window;
@property(nonatomic, retain) UINavigationController *navController;

@end
