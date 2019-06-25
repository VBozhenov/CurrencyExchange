//
//  Currency.m
//  CurrencyExchange
//
//  Created by Vladimir Bozhenov on 25/06/2019.
//  Copyright © 2019 Vladimir Bozhenov. All rights reserved.
//

#import "Currency.h"

@implementation Currency

- (instancetype)initWithFlag: (NSString*) flag
                        name: (NSString*) name
                       value: (NSNumber*) value
{
    self = [super init];
    if (self) {
        self.flag = flag;
        self.name = name;
        self.value = value;
        self.fullName = [NSString stringWithFormat:@"%@ %@", flag, name];
    }
    return self;
}

@end
