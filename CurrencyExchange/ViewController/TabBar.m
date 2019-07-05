//
//  TabBar.m
//  CurrencyExchange
//
//  Created by Vladimir Bozhenov on 05/07/2019.
//  Copyright © 2019 Vladimir Bozhenov. All rights reserved.
//

#import "TabBar.h"
#import "MainViewController.h"
#import "MapViewController.h"

@interface TabBar ()

@end

@implementation TabBar

- (instancetype)init
{
    self = [super init];
    if (self) {
        MainViewController *mainViewController = [[MainViewController alloc] init];
        mainViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Main" image:[UIImage imageNamed:@"cash"] tag:0];
        
        MapViewController *mapViewController = [[MapViewController alloc] init];
        mapViewController.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"Map" image:[UIImage imageNamed:@"map"] tag:1];
        
        self.viewControllers = @[mainViewController, mapViewController];
        [self.tabBar setTintColor:[UIColor blackColor]];
        [self setSelectedIndex:0];
    }
    return self;
}


@end
