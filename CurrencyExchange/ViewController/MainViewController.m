//
//  MainViewController.m
//  CurrencyExchange
//
//  Created by Vladimir Bozhenov on 21/06/2019.
//  Copyright © 2019 Vladimir Bozhenov. All rights reserved.
//

#import "MainViewController.h"
#import "EditViewController.h"

@interface MainViewController ()

@property (nonatomic, strong) UILabel *resultLabel;
@property (nonatomic, strong) UILabel *fromCurrencyLabel;
@property (nonatomic, strong) UILabel *toCurrencyLabel;
@property (nonatomic, strong) UITextField *inputValueTextField;

@end

@implementation MainViewController


- (void)viewDidLoad {
    [super viewDidLoad];

    [self.view setBackgroundColor:[UIColor lightGrayColor]];
    self.title = @"Currency Exchange";
}

- (void)viewWillAppear:(BOOL)animated {
    
    [self.fromSegmentedControl removeAllSegments];
    [self.toSegmentedControl removeAllSegments];
    [self.fromCurrencyLabel removeFromSuperview];
    [self.toCurrencyLabel removeFromSuperview];
    [self.resultLabel removeFromSuperview];
    [self.inputValueTextField removeFromSuperview];
    
    //Segmented controls
//    if ([[Data sharedObject].myCurrencies count] > 0) {
//        
//        self.fromSegmentedControl = [[UISegmentedControl alloc] initWithFrame:CGRectMake(5,
//                                                                                         150,
//                                                                                         [self.view bounds].size.width - 10,
//                                                                                         20)];
//        for (int index = 0; index < [[Data sharedObject].myCurrencies count]; index++) {
//            [self.fromSegmentedControl insertSegmentWithTitle:[Data sharedObject].myCurrencies[index].fullName
//                                                      atIndex:index animated:false];
//        }
        
//        [self.fromSegmentedControl setSelectedSegmentIndex:0];
//        [self.fromSegmentedControl addTarget:self action:@selector(changeSegment:)
//                            forControlEvents:(UIControlEventValueChanged)];
//        [self.view addSubview:self.fromSegmentedControl];
//
//        self.toSegmentedControl = [[UISegmentedControl alloc] initWithFrame:CGRectMake(5,
//                                                                                       400,
//                                                                                       [self.view bounds].size.width - 10,
//                                                                                       20)];
//        for (int index = 0; index < [[Data sharedObject].myCurrencies count]; index++) {
//            [self.toSegmentedControl insertSegmentWithTitle:[Data sharedObject].myCurrencies[index].fullName
//                                                    atIndex:index animated:false];
//        }
//        [self.toSegmentedControl setSelectedSegmentIndex:0];
//        [self.toSegmentedControl addTarget:self action:@selector(changeSegment:)
//                          forControlEvents:(UIControlEventValueChanged)];
//        [self.view addSubview:self.toSegmentedControl];
//
//
//        //Labels
//        UILabel *labelFrom = [[UILabel alloc] initWithFrame:CGRectMake(0,
//                                                                       100,
//                                                                       [self.view bounds].size.width,
//                                                                       50)];
//        [labelFrom setTextColor:[UIColor blueColor]];
//        [labelFrom setText:@"Convert from:"];
//        [labelFrom setTextAlignment:(NSTextAlignmentCenter)];
//        [labelFrom setFont:[UIFont systemFontOfSize:30
//                                             weight:(UIFontWeightBold)]];
//        [self.view addSubview:labelFrom];
//
//        UILabel *labelTo = [[UILabel alloc] initWithFrame:CGRectMake(0,
//                                                                     350,
//                                                                     [self.view bounds].size.width,
//                                                                     50)];
//        [labelTo setTextColor:[UIColor blueColor]];
//        [labelTo setText:@"Convert to:"];
//        [labelTo setTextAlignment:(NSTextAlignmentCenter)];
//        [labelTo setFont:[UIFont systemFontOfSize:30
//                                           weight:(UIFontWeightBold)]];
//        [self.view addSubview:labelTo];
//
//        self.resultLabel = [[UILabel alloc] initWithFrame:CGRectMake(150,
//                                                                     500,
//                                                                     [self.view bounds].size.width - 200,
//                                                                     50)];
//        [self.resultLabel setTextColor:[UIColor blueColor]];
//        [self.resultLabel setText:@"0.00"];
//        [self.resultLabel setTextAlignment:(NSTextAlignmentCenter)];
//        [self.resultLabel setFont:[UIFont systemFontOfSize:30
//                                                    weight:(UIFontWeightBold)]];
//        [self.view addSubview:self.resultLabel];
//
//        self.fromCurrencyLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,
//                                                                           225,
//                                                                           150,
//                                                                           100)];
//        [self.fromCurrencyLabel setTextColor:[UIColor blueColor]];
//        [self.fromCurrencyLabel setText:[NSString stringWithFormat:@"%@", [Data sharedObject].myCurrencies[[self.fromSegmentedControl selectedSegmentIndex]].fullName]];
//        [self.fromCurrencyLabel setTextAlignment:(NSTextAlignmentCenter)];
//        [self.fromCurrencyLabel setFont:[UIFont systemFontOfSize:30
//                                                          weight:(UIFontWeightBold)]];
//        [self.view addSubview:self.fromCurrencyLabel];
//
//        self.toCurrencyLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,
//                                                                         475,
//                                                                         150,
//                                                                         100)];
//        [self.toCurrencyLabel setTextColor:[UIColor blueColor]];
//        [self.toCurrencyLabel setText:[NSString stringWithFormat:@"%@", [Data sharedObject].myCurrencies[[self.toSegmentedControl selectedSegmentIndex]].fullName]];
//        [self.toCurrencyLabel setTextAlignment:(NSTextAlignmentCenter)];
//        [self.toCurrencyLabel setFont:[UIFont systemFontOfSize:30
//                                                        weight:(UIFontWeightBold)]];
//        [self.view addSubview:self.toCurrencyLabel];
//
//        //TextField
//        self.inputValueTextField = [[UITextField alloc] initWithFrame:CGRectMake(150,
//                                                                                 250,
//                                                                                 [self.view bounds].size.width - 200,
//                                                                                 50)];
//        self.inputValueTextField.delegate = self;
//        [self.inputValueTextField setBackgroundColor:[UIColor whiteColor]];
//        [self.inputValueTextField setBorderStyle:(UITextBorderStyleLine)];
//        [self.inputValueTextField setPlaceholder:@"Enter value"];
//        [self.inputValueTextField setKeyboardType:UIKeyboardTypeNumbersAndPunctuation];
//        [self.inputValueTextField addTarget:self action:@selector(updateResults)
//                           forControlEvents:(UIControlEventEditingChanged)];
//        [self.view addSubview:self.inputValueTextField];
//
//    }
//
//
//    //BarButtonItem
//    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:(UIBarButtonSystemItemEdit)
//                                                                                   target:self
//                                                                                   action:@selector(barButtonTaped)];
//    self.navigationItem.rightBarButtonItem = barButtonItem;
//}
//
//- (void)changeSegment:(UISegmentedControl*)sender {
//    if (sender == self.fromSegmentedControl) {
//        [self.fromCurrencyLabel setText:[NSString stringWithFormat:@"%@", [Data sharedObject].myCurrencies[[sender selectedSegmentIndex]].fullName]];
//    } else {
//        [self.toCurrencyLabel setText:[NSString stringWithFormat:@"%@", [Data sharedObject].myCurrencies[[sender selectedSegmentIndex]].fullName]];
//    }
//    [self updateResults];
//}
//
//- (void) updateResults {
//    float ratio = [[Data sharedObject].myCurrencies[[self.toSegmentedControl selectedSegmentIndex]].value floatValue] / [[Data sharedObject].myCurrencies[[self.fromSegmentedControl selectedSegmentIndex]].value floatValue];
//    float input = [[self.inputValueTextField text] floatValue];
//    [self.resultLabel setText:[NSString stringWithFormat:@"%.2f", input / ratio]];
//
//}
//
//- (BOOL)textFieldShouldReturn:(UITextField *)textField {
//    [textField resignFirstResponder];
//    return true;
//}
//
//- (void) barButtonTaped {
//    EditViewController *editViewController = [[EditViewController alloc] init];
//    [self.navigationController pushViewController:editViewController animated:true];
}

@end
