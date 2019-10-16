//
//  DataService.h
//  CurrencyExchange
//
//  Created by Vladimir Bozhenov on 09/07/2019.
//  Copyright © 2019 Vladimir Bozhenov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Currency+CoreDataProperties.h"

NS_ASSUME_NONNULL_BEGIN

@interface DataService : NSObject

+ (instancetype)sharedInstance;

- (void)createCurrencyWithCharCode:(NSString*)charCode
                       withNominal:(NSNumber*)nominal
                          withName:(NSString*)name
                         withValue:(NSNumber*)value
                      withPrevious:(NSNumber*)previous
                    withIsFavorite:(BOOL)isFavorite;

- (NSArray*)getAllCurrencies;
- (void)save;

@end

NS_ASSUME_NONNULL_END
