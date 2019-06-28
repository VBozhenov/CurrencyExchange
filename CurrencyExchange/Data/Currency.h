//
//  Currency.h
//  CurrencyExchange
//
//  Created by Vladimir Bozhenov on 25/06/2019.
//  Copyright © 2019 Vladimir Bozhenov. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Currency : NSObject

@property (nonatomic, strong) NSString *charCode;
@property (nonatomic, strong) NSNumber *nominal;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSNumber *value;
@property (nonatomic, strong) NSNumber *previous;

- (instancetype)initFromDictionary:(NSDictionary*)dictionary;

@end

NS_ASSUME_NONNULL_END
