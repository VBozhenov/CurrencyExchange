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

@end

@implementation CurrencyTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        self.currencyName = [[UILabel alloc] initWithFrame:CGRectMake(8,
                                                                      20,
                                                                      150,
                                                                      20)];
        [self.currencyName setTextAlignment:NSTextAlignmentLeft];
        [self.currencyName setFont:[UIFont systemFontOfSize:20 weight:UIFontWeightBold]];
        [self.contentView addSubview:self.currencyName];
        
        self.currencyValue = [[UILabel alloc] initWithFrame:CGRectMake(self.bounds.size.width - 80,
                                                                       20,
                                                                       150,
                                                                       20)];
        [self.currencyValue setTextAlignment:NSTextAlignmentRight];
        [self.currencyValue setFont:[UIFont systemFontOfSize:20 weight:UIFontWeightBold]];
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
    [super setSelected:selected animated:animated];
}

- (void)setupCellWithCurrency:(Currency*)currency {
    [self.currencyName setText:currency.fullName];
    [self.currencyValue setText:[NSString stringWithFormat:@"= %@ ₽ 🇷🇺", [currency.value stringValue]]];
}

@end
