//
//  RatesCollectionViewCell.h
//  CurrencyExchange
//
//  Created by Vladimir Bozhenov on 06/07/2019.
//  Copyright © 2019 Vladimir Bozhenov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Currency.h"

NS_ASSUME_NONNULL_BEGIN

@interface RatesCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) UILabel *currencyName;
@property (nonatomic, strong) UILabel *currencyValue;

- (void)setupCellWithCurrency:(Currency*)currency;

@end

NS_ASSUME_NONNULL_END
