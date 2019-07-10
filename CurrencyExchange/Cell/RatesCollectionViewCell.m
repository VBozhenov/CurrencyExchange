//
//  RatesCollectionViewCell.m
//  CurrencyExchange
//
//  Created by Vladimir Bozhenov on 06/07/2019.
//  Copyright © 2019 Vladimir Bozhenov. All rights reserved.
//

#import "RatesCollectionViewCell.h"

@interface RatesCollectionViewCell ()

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
        
//        UISegmentedControl *fromSegmentedControl = [[UISegmentedControl alloc] initWithFrame:CGRectMake(5, 200, [self.view bounds].size.width - 10, 100)];
//        UISegmentedControl *toSegmentedControl = [[UISegmentedControl alloc] initWithFrame:CGRectMake(5, 500, [self.view bounds].size.width - 10, 100)];
//        [fromSegmentedControl initWithItems:currency];
//        [toSegmentedControl initWithItems:currency];
//        [fromSegmentedControl setSelectedSegmentIndex:0];
//        [toSegmentedControl setSelectedSegmentIndex:0];
//        [self.view addSubview:fromSegmentedControl];
//        [self.view addSubview:toSegmentedControl];


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
    self.currencyName.text = [NSString stringWithFormat:@"%d %@",
                              currency.nominal,
                              currency.name];
    self.currencyValue.text = [NSString stringWithFormat:@"%.4f",
                               currency.value];
}

@end
