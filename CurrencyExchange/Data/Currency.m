//
//  Currency.m
//  CurrencyExchange
//
//  Created by Vladimir Bozhenov on 25/06/2019.
//  Copyright © 2019 Vladimir Bozhenov. All rights reserved.
//

#import "Currency.h"

@implementation Currency

- (instancetype)initFromDictionary:(NSDictionary*)dictionary {
    self = [super init];
    
    if (self) {
        self.charCode = [dictionary valueForKey:@"charCode"];
        self.nominal = [dictionary valueForKey:@"nominal"];
        self.name = [dictionary valueForKey:@"name"];
        self.value = [dictionary valueForKey:@"value"];
        self.previous = [dictionary valueForKey:@"previous"];

    }
    
    return self;
}

@end
