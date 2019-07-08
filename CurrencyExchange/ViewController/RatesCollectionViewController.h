//
//  RatesCollectionViewController.h
//  CurrencyExchange
//
//  Created by Vladimir Bozhenov on 05/07/2019.
//  Copyright © 2019 Vladimir Bozhenov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Currency.h"

@interface RatesCollectionViewController : UIViewController

@property (nonatomic, strong) NSMutableArray<Currency*> *rates;

@end
