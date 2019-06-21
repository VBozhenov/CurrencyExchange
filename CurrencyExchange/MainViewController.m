//
//  MainViewController.m
//  CurrencyExchange
//
//  Created by Vladimir Bozhenov on 21/06/2019.
//  Copyright © 2019 Vladimir Bozhenov. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSDictionary *currencyValues = @{@"RUR" : @1.0,
                                     @"USD" : @60.0,
                                     @"EUR" : @70.0
                                     };
    NSArray *currency = [currencyValues allKeys];

    [self.view setBackgroundColor:[UIColor whiteColor]];
    self.title = @"Currency Exchange";
    
    //Segmented controls
    UISegmentedControl *fromSegmentedControl = [[UISegmentedControl alloc] initWithFrame:CGRectMake(5, 200, [self.view bounds].size.width - 10, 100)];
    UISegmentedControl *toSegmentedControl = [[UISegmentedControl alloc] initWithFrame:CGRectMake(5, 500, [self.view bounds].size.width - 10, 100)];
    [fromSegmentedControl initWithItems:currency];
    [toSegmentedControl initWithItems:currency];
    [fromSegmentedControl setSelectedSegmentIndex:0];
    [toSegmentedControl setSelectedSegmentIndex:0];
    [self.view addSubview:fromSegmentedControl];
    [self.view addSubview:toSegmentedControl];
    
    
}

@end
