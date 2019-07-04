//
//  MainViewController.m
//  CurrencyExchange
//
//  Created by Vladimir Bozhenov on 21/06/2019.
//  Copyright © 2019 Vladimir Bozhenov. All rights reserved.
//

#import "MainViewController.h"
#import "RatesViewController.h"
#import "MapViewController.h"
#import "NetworkService.h"
#import "Currency.h"

@interface MainViewController () <UIPickerViewDelegate, UIPickerViewDelegate>

@property (nonatomic, strong) NSMutableArray *rates;
@property (nonatomic, strong) NSMutableArray *names;


@property (nonatomic,strong) UIPickerView *fromPicker;
@property (nonatomic,strong) UIPickerView *toPicker;

@property (nonatomic, strong) UILabel *resultLabel;
@property (nonatomic, strong) UITextField *inputValueTextField;

@end

@implementation MainViewController


double fromValue = 1;
double toValue = 1;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view setBackgroundColor:[UIColor lightGrayColor]];
    [self setTitle:@"Currency Exchange"];
    [self.navigationController.navigationBar setPrefersLargeTitles:true];
    
    Currency *rub = [Currency new];
    rub.charCode = @"RUB";
    rub.nominal = @1;
    rub.name = @"Российский рубль";
    rub.value = @1.0;
    rub.previous = @1.0;
    
    self.rates = [NSMutableArray new];
    [self.rates addObject:rub];
    self.names = [NSMutableArray new];
    self.names[0] = @"Российский рубль";
    
    
    [[NetworkService sharedInstance] getRates:^(NSArray *rates) {
        
        [self.rates addObjectsFromArray:rates];
        [rates enumerateObjectsUsingBlock:^(Currency* obj,
                                            NSUInteger idx,
                                            BOOL * _Nonnull stop) {
            [self.names addObject:obj.name];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.fromPicker reloadAllComponents];
                [self.toPicker reloadAllComponents];
                
            });
            
        }];
    }];
    
    //PickerView
    self.fromPicker = [[UIPickerView alloc] initWithFrame:CGRectMake(0,
                                                                     230,
                                                                     [self.view bounds].size.width,
                                                                     150)];
    self.fromPicker.delegate = self;
    self.fromPicker.dataSource = self;
    [self.view addSubview:self.fromPicker];
    
    self.toPicker = [[UIPickerView alloc] initWithFrame:CGRectMake(0,
                                                                   480,
                                                                   [self.view bounds].size.width,
                                                                   150)];
    self.toPicker.delegate = self;
    self.toPicker.dataSource = self;
    [self.view addSubview:self.toPicker];
    
}

- (void) updateResults {
    float ratio = toValue / fromValue ;
    float input = [[self.inputValueTextField text] floatValue];
    [self.resultLabel setText:[NSString stringWithFormat:@"%.2f",
                               input / ratio]];
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return true;
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:true];
    
    [self.resultLabel removeFromSuperview];
    [self.inputValueTextField removeFromSuperview];
    
    //Labels
    UILabel *labelFrom = [[UILabel alloc] initWithFrame:CGRectMake(0,
                                                                   130,
                                                                   [self.view bounds].size.width,
                                                                   50)];
    [labelFrom setTextColor:[UIColor blueColor]];
    [labelFrom setText:@"Convert from:"];
    [labelFrom setTextAlignment:(NSTextAlignmentCenter)];
    [labelFrom setFont:[UIFont systemFontOfSize:30
                                         weight:(UIFontWeightBold)]];
    [self.view addSubview:labelFrom];
    
    UILabel *labelTo = [[UILabel alloc] initWithFrame:CGRectMake(0,
                                                                 380,
                                                                 [self.view bounds].size.width,
                                                                 50)];
    [labelTo setTextColor:[UIColor blueColor]];
    [labelTo setText:@"Convert to:"];
    [labelTo setTextAlignment:(NSTextAlignmentCenter)];
    [labelTo setFont:[UIFont systemFontOfSize:30
                                       weight:(UIFontWeightBold)]];
    [self.view addSubview:labelTo];
    
    self.resultLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,
                                                                 430,
                                                                 [self.view bounds].size.width,
                                                                 50)];
    [self.resultLabel setTextColor:[UIColor blueColor]];
    [self.resultLabel setText:@"0.00"];
    [self.resultLabel setTextAlignment:(NSTextAlignmentCenter)];
    [self.resultLabel setFont:[UIFont systemFontOfSize:30
                                                weight:(UIFontWeightBold)]];
    [self.view addSubview:self.resultLabel];
    
    //TextField
    self.inputValueTextField = [[UITextField alloc] initWithFrame:CGRectMake(150,
                                                                             180,
                                                                             [self.view bounds].size.width - 300,
                                                                             50)];
    self.inputValueTextField.delegate = self;
    [self.inputValueTextField setBackgroundColor:[UIColor whiteColor]];
    [self.inputValueTextField setBorderStyle:(UITextBorderStyleLine)];
    [self.inputValueTextField setPlaceholder:@"Enter value"];
    [self.inputValueTextField setKeyboardType:UIKeyboardTypeNumbersAndPunctuation];
    [self.inputValueTextField addTarget:self action:@selector(updateResults)
                       forControlEvents:(UIControlEventEditingChanged)];
    [self.view addSubview:self.inputValueTextField];
    
    //Button
    UIButton *buttonToMap = [[UIButton alloc] initWithFrame:CGRectMake([self.view bounds].size.width / 2 - 200,
                                                                       680,
                                                                       400,
                                                                       50)];
    [buttonToMap setBackgroundColor:[UIColor blueColor]];
    [buttonToMap setTitle:@"Find nearest exchange office" forState:normal];
    [buttonToMap addTarget:self
                    action:@selector(toMapViewButtonTaped)
          forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:buttonToMap];
    
    //BarButtonItem
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Rates"
                                                                      style:(UIBarButtonItemStylePlain)
                                                                     target:self
                                                                     action:@selector(barButtonTaped)];
    self.navigationItem.rightBarButtonItem = barButtonItem;
}

- (void) barButtonTaped {
    RatesViewController *ratesViewController = [[RatesViewController alloc] init];
    ratesViewController.rates = self.rates;
    [self.navigationController pushViewController:ratesViewController
                                         animated:true];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)thePickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)thePickerView numberOfRowsInComponent:(NSInteger)component {
    return self.names.count;
}

- (NSString *)pickerView:(UIPickerView *)thePickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return self.names[row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row
       inComponent:(NSInteger)component {
    if (pickerView == self.fromPicker) {
        fromValue = [[self.rates[row] valueForKey:@"value"] doubleValue] * [[self.rates[row] valueForKey:@"nominal"] doubleValue];
        [self updateResults];
    } else {
        toValue = [[self.rates[row] valueForKey:@"value"] doubleValue] * [[self.rates[row] valueForKey:@"nominal"] doubleValue];
        [self updateResults];
    }
}

- (void) toMapViewButtonTaped {
    
    dispatch_async(dispatch_get_main_queue(), ^{
        MapViewController *mapViewController = [[MapViewController alloc] init];
        [self.navigationController pushViewController:mapViewController
                                             animated:true];
    });
}

@end
