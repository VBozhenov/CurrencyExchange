//
//  RatesViewController.h
//  CurrencyExchange
//
//  Created by Vladimir Bozhenov on 25/06/2019.
//  Copyright © 2019 Vladimir Bozhenov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainViewController.h"
#import "Currency+CoreDataProperties.h"

@interface RatesViewController : UIViewController
@property (nonatomic, strong) NSArray<Currency*> *rates;

@end
