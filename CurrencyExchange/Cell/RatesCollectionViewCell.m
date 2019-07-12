//
//  RatesCollectionViewCell.m
//  CurrencyExchange
//
//  Created by Vladimir Bozhenov on 06/07/2019.
//  Copyright © 2019 Vladimir Bozhenov. All rights reserved.
//

#import "RatesCollectionViewCell.h"

@interface RatesCollectionViewCell ()

@property (nonatomic, strong) UILabel *isFavorite;

@end

@implementation RatesCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
}


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setBackgroundColor:[UIColor lightGrayColor]];
        
        self.isFavorite = [[UILabel alloc] initWithFrame:CGRectMake([self bounds].size.width / 2 - 15,
                                                                    [self bounds].size.height / 2 - 15,
                                                                    30,
                                                                    30)];
        [self.isFavorite setTextAlignment:NSTextAlignmentCenter];
        self.isFavorite.text = @"★";
        [self.isFavorite setFont:[UIFont systemFontOfSize:30
                                                   weight:UIFontWeightThin]];
        [self.contentView addSubview:self.isFavorite];
        
        self.currencyName = [[UILabel alloc] initWithFrame:CGRectMake(8,
                                                                      8,
                                                                      [self bounds].size.width - 16,
                                                                      80)];
        [self.currencyName setTextAlignment:NSTextAlignmentCenter];
        [self.currencyName setNumberOfLines:0];
        [self.currencyName setFont:[UIFont systemFontOfSize:15
                                                     weight:UIFontWeightThin]];
        
        [self.contentView addSubview:self.currencyName];
        
        self.currencyValue = [[UILabel alloc] initWithFrame:CGRectMake(8,
                                                                       [self bounds].size.height - 100,
                                                                       [self bounds].size.width - 16,
                                                                       80)];
        [self.currencyValue setTextAlignment:NSTextAlignmentCenter];
        [self.currencyValue setNumberOfLines:0];
        [self.currencyValue setFont:[UIFont systemFontOfSize:15
                                                      weight:UIFontWeightBold]];
        
        [self.contentView addSubview:self.currencyValue];
    }
    return self;
}

- (void)prepareForReuse {
    [super prepareForReuse];
    self.currencyName.text = nil;
    self.currencyValue.text = nil;
}

- (void)setupCellWithCurrency:(Currency*)currency {
    if (currency.isFavorite) {
        [self.isFavorite setTextColor:[UIColor orangeColor]];
    } else {
        [self.isFavorite setTextColor:[UIColor grayColor]];
    }
    self.currencyName.text = [NSString stringWithFormat:@"%d %@",
                              currency.nominal,
                              currency.name];
    self.currencyValue.text = [NSString stringWithFormat:@"%.4f",
                               currency.value];
}

@end
