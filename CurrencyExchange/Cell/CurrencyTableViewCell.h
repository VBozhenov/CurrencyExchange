//
//  CurrencyTableViewCell.h
//  CurrencyExchange
//
//  Created by Vladimir Bozhenov on 25/06/2019.
//  Copyright © 2019 Vladimir Bozhenov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Currency+CoreDataProperties.h"
#import "RatesViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface CurrencyTableViewCell : UITableViewCell

- (void)setupCellWithCurrency:(Currency*)currency;

@end

NS_ASSUME_NONNULL_END
