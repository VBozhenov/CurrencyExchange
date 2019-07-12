//
//  CurrencyTableViewCell.m
//  CurrencyExchange
//
//  Created by Vladimir Bozhenov on 25/06/2019.
//  Copyright © 2019 Vladimir Bozhenov. All rights reserved.
//

#import "CurrencyTableViewCell.h"

@interface CurrencyTableViewCell ()

@property (nonatomic, strong) UILabel *currencyName;
@property (nonatomic, strong) UILabel *currencyValue;
@property (nonatomic, strong) UILabel *isFavorite;

@end

@implementation CurrencyTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style
              reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style
                reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        self.isFavorite = [[UILabel alloc] initWithFrame:CGRectMake(5,
                                                                    20,
                                                                    15,
                                                                    15)];
        [self.isFavorite setTextAlignment:NSTextAlignmentCenter];
        self.isFavorite.text = @"★";
        [self.isFavorite setFont:[UIFont systemFontOfSize:15
                                                   weight:UIFontWeightThin]];
        [self.contentView addSubview:self.isFavorite];

        
        self.currencyName = [[UILabel alloc] initWithFrame:CGRectMake(40,
                                                                      20,
                                                                      250,
                                                                      20)];
        [self.currencyName setTextAlignment:NSTextAlignmentLeft];
        [self.currencyName setNumberOfLines:0];
        [self.currencyName setFont:[UIFont systemFontOfSize:15
                                                     weight:UIFontWeightThin]];
        [self.contentView addSubview:self.currencyName];
        
        self.currencyValue = [[UILabel alloc] initWithFrame:CGRectMake(self.bounds.size.width - 80,
                                                                       20,
                                                                       150,
                                                                       20)];
        [self.currencyValue setTextAlignment:NSTextAlignmentRight];
        [self.currencyValue setFont:[UIFont systemFontOfSize:15
                                                      weight:UIFontWeightBold]];
        [self.contentView addSubview:self.currencyValue];
    }
    
    [self setSelectionStyle:UITableViewCellSelectionStyleNone];

    return self;
}

- (void)prepareForReuse {
    [super prepareForReuse];
    self.currencyName.text = nil;
    self.currencyValue.text = nil;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected
              animated:animated];
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
