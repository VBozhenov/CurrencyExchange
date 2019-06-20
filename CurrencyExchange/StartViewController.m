//
//  StartViewController.m
//  CurrencyExchange
//
//  Created by Vladimir Bozhenov on 21/06/2019.
//  Copyright © 2019 Vladimir Bozhenov. All rights reserved.
//

#import "StartViewController.h"

@interface StartViewController ()

@end

@implementation StartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor lightGrayColor]];
    
    
    //Label
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 100, [self.view bounds].size.width, 50)];
    [label setBackgroundColor:[UIColor lightGrayColor]];
    [label setTextColor:[UIColor blueColor]];
    [label setText:@"CURRENCY EXCHANGE"];
    [label setTextAlignment:(NSTextAlignmentCenter)];
    [label setFont:[UIFont systemFontOfSize:30 weight:(UIFontWeightBold)]];
    [self.view addSubview:label];
    
    //ImageView
    UIImageView *logo = [[UIImageView alloc] initWithFrame:CGRectMake(0, 250, [self.view bounds].size.width, 100)];
    [logo setImage:[UIImage imageNamed:@"konverter"]];
    [logo setBackgroundColor:[UIColor lightGrayColor]];
    [logo setContentMode:UIViewContentModeScaleAspectFill];
    [self.view addSubview:logo];
}


@end
