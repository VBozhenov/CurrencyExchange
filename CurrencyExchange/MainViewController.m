//
//  MainViewController.m
//  CurrencyExchange
//
//  Created by Vladimir Bozhenov on 21/06/2019.
//  Copyright © 2019 Vladimir Bozhenov. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()

@property (nonatomic, strong) UILabel *resultLabel;
@property (nonatomic, strong) UILabel *fromCurrencyLabel;
@property (nonatomic, strong) UILabel *toCurrencyLabel;
@property (nonatomic, strong) UISegmentedControl *fromSegmentedControl;
@property (nonatomic, strong) UISegmentedControl *toSegmentedControl;
@property (nonatomic, strong) NSDictionary *currencyValues;
@property (nonatomic, strong) NSArray *currency;
@property (nonatomic, strong) UITextField *inputValueTextField;

@end

@implementation MainViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.currencyValues = @{@"🇷🇺 ₽" : @1.0,
                            @"🇺🇸 $" : @62.41,
                            @"🇪🇺 €" : @70.56,
                            @"🇬🇧 £" : @79.33,
                          @"🇨🇭 CHF" : @63.58
                            };
    
    self.currency = [self.currencyValues allKeys];

    [self.view setBackgroundColor:[UIColor lightGrayColor]];
    self.title = @"Currency Exchange";
    
    //Segmented controls
    self.fromSegmentedControl = [[UISegmentedControl alloc] initWithFrame:CGRectMake(5,
                                                                                     200,
                                                                                     [self.view bounds].size.width - 10,
                                                                                     100)];
    [self.fromSegmentedControl initWithItems:self.currency];
    [self.fromSegmentedControl setSelectedSegmentIndex:0];
    [self.fromSegmentedControl addTarget:self action:@selector(changeSegment:) forControlEvents:(UIControlEventValueChanged)];
    [self.view addSubview:self.fromSegmentedControl];
    
    self.toSegmentedControl = [[UISegmentedControl alloc] initWithFrame:CGRectMake(5,
                                                                                   500,
                                                                                   [self.view bounds].size.width - 10,
                                                                                   100)];
    [self.toSegmentedControl initWithItems:self.currency];
    [self.toSegmentedControl setSelectedSegmentIndex:0];
    [self.toSegmentedControl addTarget:self action:@selector(changeSegment:) forControlEvents:(UIControlEventValueChanged)];
    [self.view addSubview:self.toSegmentedControl];
    
    //Labels
    UILabel *labelFrom = [[UILabel alloc] initWithFrame:CGRectMake(0,
                                                                   150,
                                                                   [self.view bounds].size.width,
                                                                   50)];
    [labelFrom setTextColor:[UIColor blueColor]];
    [labelFrom setText:@"Convert from:"];
    [labelFrom setTextAlignment:(NSTextAlignmentCenter)];
    [labelFrom setFont:[UIFont systemFontOfSize:30 weight:(UIFontWeightBold)]];
    [self.view addSubview:labelFrom];
    
    UILabel *labelTo = [[UILabel alloc] initWithFrame:CGRectMake(0,
                                                                 450,
                                                                 [self.view bounds].size.width,
                                                                 50)];
    [labelTo setTextColor:[UIColor blueColor]];
    [labelTo setText:@"Convert to:"];
    [labelTo setTextAlignment:(NSTextAlignmentCenter)];
    [labelTo setFont:[UIFont systemFontOfSize:30 weight:(UIFontWeightBold)]];
    [self.view addSubview:labelTo];
    
    self.resultLabel = [[UILabel alloc] initWithFrame:CGRectMake(150,
                                                                 600,
                                                                 [self.view bounds].size.width - 200,
                                                                 50)];
    [self.resultLabel setTextColor:[UIColor blueColor]];
    [self.resultLabel setText:@"0"];
    [self.resultLabel setTextAlignment:(NSTextAlignmentCenter)];
    [self.resultLabel setFont:[UIFont systemFontOfSize:30 weight:(UIFontWeightBold)]];
    [self.view addSubview:self.resultLabel];
    
    self.fromCurrencyLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,
                                                                       275,
                                                                       150,
                                                                       100)];
    [self.fromCurrencyLabel setTextColor:[UIColor blueColor]];
    [self.fromCurrencyLabel setText:[NSString stringWithFormat:@"%@", self.currency[[self.fromSegmentedControl selectedSegmentIndex]]]];
    [self.fromCurrencyLabel setTextAlignment:(NSTextAlignmentCenter)];
    [self.fromCurrencyLabel setFont:[UIFont systemFontOfSize:30 weight:(UIFontWeightBold)]];
    [self.view addSubview:self.fromCurrencyLabel];
    
    self.toCurrencyLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,
                                                                     575,
                                                                     150,
                                                                     100)];
    [self.toCurrencyLabel setTextColor:[UIColor blueColor]];
    [self.toCurrencyLabel setText:[NSString stringWithFormat:@"%@", self.currency[[self.toSegmentedControl selectedSegmentIndex]]]];
    [self.toCurrencyLabel setTextAlignment:(NSTextAlignmentCenter)];
    [self.toCurrencyLabel setFont:[UIFont systemFontOfSize:30 weight:(UIFontWeightBold)]];
    [self.view addSubview:self.toCurrencyLabel];
    
    //TextField
    self.inputValueTextField = [[UITextField alloc] initWithFrame:CGRectMake(150,
                                                                             300,
                                                                             [self.view bounds].size.width - 200,
                                                                             50)];
    self.inputValueTextField.delegate = self;
    [self.inputValueTextField setBackgroundColor:[UIColor whiteColor]];
    [self.inputValueTextField setBorderStyle:(UITextBorderStyleLine)];
    [self.inputValueTextField setPlaceholder:@"Enter value"];
    [self.inputValueTextField setKeyboardType:UIKeyboardTypeNumbersAndPunctuation];
    [self.inputValueTextField addTarget:self action:@selector(updateResults) forControlEvents:(UIControlEventEditingChanged)];
    [self.view addSubview:self.inputValueTextField];
    
}

- (void)changeSegment:(UISegmentedControl*)sender {
    if (sender == self.fromSegmentedControl) {
        [self.fromCurrencyLabel setText:[NSString stringWithFormat:@"%@", self.currency[[sender selectedSegmentIndex]]]];
    } else {
        [self.toCurrencyLabel setText:[NSString stringWithFormat:@"%@", self.currency[[sender selectedSegmentIndex]]]];
    }
    self.updateResults;
}

- (void) updateResults {
    float ratio = [[self.currencyValues valueForKey:self.currency[[self.toSegmentedControl selectedSegmentIndex]]] floatValue] / [[self.currencyValues valueForKey:self.currency[[self.fromSegmentedControl selectedSegmentIndex]]] floatValue];
    float input = [[self.inputValueTextField text] floatValue];
    [self.resultLabel setText:[NSString stringWithFormat:@"%.2f", input / ratio]];
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return true;
}

@end
