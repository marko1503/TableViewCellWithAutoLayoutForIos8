//
//  AppDelegate.m
//  TableViewCellWithAutoLayoutForIos8
//
//  Created by Maksym Prokopchuk on 8/4/15.
//  Copyright (c) 2015 Maksym Prokopchuk. All rights reserved.
//

#import "AppDelegate.h"
#import "DynamicTableViewController.h"

@interface AppDelegate ()

@end


@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    DynamicTableViewController *viewController = [[DynamicTableViewController alloc] initWithStyle:UITableViewStylePlain];
    self.navigationController = [[UINavigationController alloc] initWithRootViewController:viewController];
    
    self.window.rootViewController = self.navigationController;
    [self.window makeKeyAndVisible];
    
    return YES;
}

@end
