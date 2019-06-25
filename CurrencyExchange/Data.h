//
//  Data.h
//  CurrencyExchange
//
//  Created by Vladimir Bozhenov on 25/06/2019.
//  Copyright © 2019 Vladimir Bozhenov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Currency.h"

NS_ASSUME_NONNULL_BEGIN

@interface Data : NSObject {
}

+ (Data *)sharedObject;
@property NSMutableArray<Currency *> *myCurrencies;
@property NSMutableArray<Currency *> *currenciesToAdd;

@end

NS_ASSUME_NONNULL_END
