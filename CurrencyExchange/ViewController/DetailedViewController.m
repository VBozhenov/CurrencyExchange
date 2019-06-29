//
//  DetailedViewController.m
//  CurrencyExchange
//
//  Created by Vladimir Bozhenov on 29/06/2019.
//  Copyright © 2019 Vladimir Bozhenov. All rights reserved.
//

#import "DetailedViewController.h"

@interface DetailedViewController ()

@property (nonatomic, strong) UILabel *currencyName;
@property (nonatomic, strong) UILabel *currencyRate;
@property (nonatomic, strong) UILabel *difference;

@end

@implementation DetailedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view setBackgroundColor:[UIColor lightGrayColor]];
    
    [self setTitle:[NSString stringWithFormat:@"%@", self.currency.charCode]];
    [self.navigationController.navigationBar setPrefersLargeTitles:true];
    
    self.currencyName = [[UILabel alloc] initWithFrame:CGRectMake(0,
                                                                 150,
                                                                 [self.view bounds].size.width,
                                                                 50)];
    [self.currencyName setTextColor:[UIColor blueColor]];
    [self.currencyName setText: [NSString stringWithFormat:@"%@ %@", self.currency.nominal, self.currency.name]];
    [self.currencyName setTextAlignment:(NSTextAlignmentCenter)];
    [self.currencyName setFont:[UIFont systemFontOfSize:30
                                                weight:(UIFontWeightBold)]];
    [self.view addSubview:self.currencyName];
    
    self.currencyRate = [[UILabel alloc] initWithFrame:CGRectMake(0,
                                                                 300,
                                                                 [self.view bounds].size.width,
                                                                 50)];
    [self.currencyRate setTextColor:[UIColor blueColor]];
    [self.currencyRate setText:[NSString stringWithFormat:@"%.4f %@", [self.currency.value floatValue], @"руб"]];
    [self.currencyRate setTextAlignment:(NSTextAlignmentCenter)];
    [self.currencyRate setFont:[UIFont systemFontOfSize:30
                                                weight:(UIFontWeightBold)]];
    [self.view addSubview:self.currencyRate];
    
    self.difference = [[UILabel alloc] initWithFrame:CGRectMake(0,
                                                                 450,
                                                                 [self.view bounds].size.width,
                                                                 50)];
    float diff = [self.currency.value floatValue] - [self.currency.previous floatValue];
    
    if (diff > 0) {
        [self.difference setTextColor:[UIColor greenColor]];
        [self.difference setText:[NSString stringWithFormat:@"⬆︎ %.4f", diff]];
    } else if (diff < 0) {
        [self.difference setTextColor:[UIColor redColor]];
        [self.difference setText:[NSString stringWithFormat:@"⬇︎ %.4f", diff]];
    } else {
        [self.difference setTextColor:[UIColor grayColor]];
        [self.difference setText:[NSString stringWithFormat:@"⚬ %.4f", diff]];

    }
    

    [self.difference setTextAlignment:(NSTextAlignmentCenter)];
    [self.difference setFont:[UIFont systemFontOfSize:30
                                                weight:(UIFontWeightBold)]];
    [self.view addSubview:self.difference];
    
}

@end
