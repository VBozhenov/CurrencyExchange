//
//  EditViewController.m
//  CurrencyExchange
//
//  Created by Vladimir Bozhenov on 25/06/2019.
//  Copyright © 2019 Vladimir Bozhenov. All rights reserved.
//

#import "EditViewController.h"

@interface EditViewController ()

@end

@implementation EditViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view setBackgroundColor:[UIColor lightGrayColor]];
    [[Data sharedObject].myCurrencies removeObjectAtIndex:0];
    NSLog(@"%lu", (unsigned long)[[Data sharedObject].myCurrencies count]);
}
@end
