//
//  Data.m
//  CurrencyExchange
//
//  Created by Vladimir Bozhenov on 25/06/2019.
//  Copyright © 2019 Vladimir Bozhenov. All rights reserved.
//

#import "Data.h"

@implementation Data

+ (Data *)sharedObject {
    static Data *sharedClass = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedClass = [[self alloc] init];
    });
    return sharedClass;
}

- (id)init {
    if (self = [super init]) {
        self.myCurrencies = [[NSMutableArray<Currency*> alloc] initWithObjects:
                             ([[Currency alloc] initWithFlag:@"🇷🇺" name:@"₽" value:@1.0]),
                             ([[Currency alloc] initWithFlag:@"🇺🇸" name:@"$" value:@62.94]),
                             ([[Currency alloc] initWithFlag:@"🇪🇺" name:@"€" value:@71.58]),
                             ([[Currency alloc] initWithFlag:@"🇬🇧" name:@"£" value:@80.14]),
                             ([[Currency alloc] initWithFlag:@"🇨🇭" name:@"CHF" value:@64.47]),
                             nil];
        
        self.currenciesToAdd = [[NSMutableArray<Currency*> alloc] initWithObjects:
                                ([[Currency alloc] initWithFlag:@"🇺🇦" name:@"UAH" value:@2.4]),
                                ([[Currency alloc] initWithFlag:@"🇳🇿" name:@"NZ$" value:@41.56]),
                                ([[Currency alloc] initWithFlag:@"🇨🇦" name:@"$" value:@47.71]),
                                ([[Currency alloc] initWithFlag:@"🇦🇺" name:@"A$" value:@43.72]),
                                nil];
    }
    return self;
}

@end
