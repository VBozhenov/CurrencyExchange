//
//  StartViewController.m
//  CurrencyExchange
//
//  Created by Vladimir Bozhenov on 21/06/2019.
//  Copyright © 2019 Vladimir Bozhenov. All rights reserved.
//

#import "StartViewController.h"
#import "MainViewController.h"

@interface StartViewController ()

@end

@implementation StartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor lightGrayColor]];
    
    //Label
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0,
                                                               100,
                                                               [self.view bounds].size.width,
                                                               50)];
    [label setBackgroundColor:[UIColor lightGrayColor]];
    [label setTextColor:[UIColor blueColor]];
    [label setText:@"CURRENCY EXCHANGE"];
    [label setTextAlignment:(NSTextAlignmentCenter)];
    [label setFont:[UIFont systemFontOfSize:30 weight:(UIFontWeightBold)]];
    [self.view addSubview:label];
    
    //ImageView
    UIImageView *logo = [[UIImageView alloc] initWithFrame:CGRectMake(0,
                                                                      250,
                                                                      [self.view bounds].size.width,
                                                                      100)];
    [logo setImage:[UIImage imageNamed:@"konverter"]];
    [logo setBackgroundColor:[UIColor lightGrayColor]];
    [logo setContentMode:UIViewContentModeScaleAspectFill];
    [self.view addSubview:logo];
    
    //Button
    UIButton *startButton = [[UIButton alloc] initWithFrame:CGRectMake([self.view bounds].size.width / 2 - 100,
                                                                       600,
                                                                       200,
                                                                       30)];
    [startButton setTitle:@"Push to start" forState:UIControlStateNormal];
    [startButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [startButton addTarget:self action:@selector(openMainViewController) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:startButton];
    
    //ActivityIndicator
    UIActivityIndicatorView *activityIndicator = [[UIActivityIndicatorView alloc]
                                                  initWithFrame:CGRectMake([self.view bounds].size.width / 2 - 100,
                                                                           [self.view bounds].size.height - 200,
                                                                           200,
                                                                           200)];
    [activityIndicator setActivityIndicatorViewStyle:(UIActivityIndicatorViewStyleWhiteLarge)];
    [activityIndicator setHidesWhenStopped:true];
    [activityIndicator startAnimating];
    [self.view addSubview:activityIndicator];
}

-(void) openMainViewController {
    MainViewController *mainViewController = [[MainViewController alloc] init];
    [self.navigationController pushViewController:mainViewController animated:true];
};

@end
