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
                             ([[Currency alloc] initWithFlag:@"🇺🇸" name:@"$" value:@62.41]),
                             ([[Currency alloc] initWithFlag:@"🇪🇺" name:@"€" value:@70.56]),
                             ([[Currency alloc] initWithFlag:@"🇬🇧" name:@"£" value:@79.33]),
                             ([[Currency alloc] initWithFlag:@"🇨🇭" name:@"CHF" value:@63.58]),
                             nil];
        
        self.currenciesToAdd = [[NSMutableArray<Currency*> alloc] initWithObjects:
                                ([[Currency alloc] initWithFlag:@"🇺🇦" name:@"UAH" value:@1.0]),
                                ([[Currency alloc] initWithFlag:@"🇳🇿" name:@"NZ$" value:@62.41]),
                                ([[Currency alloc] initWithFlag:@"🇨🇦" name:@"$" value:@70.56]),
                                ([[Currency alloc] initWithFlag:@"🇦🇺" name:@"A$" value:@79.33]),
                                nil];
    }
    return self;
}

@end
