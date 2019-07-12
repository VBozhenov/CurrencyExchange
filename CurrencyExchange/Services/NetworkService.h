//
//  NetworkService.h
//  CurrencyExchange
//
//  Created by Vladimir Bozhenov on 28/06/2019.
//  Copyright © 2019 Vladimir Bozhenov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Currency+CoreDataProperties.h"
#import "DataService.h"

@interface NetworkService : NSObject

+ (instancetype)sharedInstance;

- (void)getRates:(void (^)(NSArray<Currency*> *rates))completion;

@end
